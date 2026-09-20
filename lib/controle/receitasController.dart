import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:login/modelo/classes/receita.dart';
import 'package:login/modelo/classes/autorizacao.dart';
import 'package:login/modelo/LocalStorageService.dart';
import 'package:login/visao/util/constantes.dart';

/// Cuida da sincronização com a API (Splash2 chama isso)
class ReceitasController {

  static Future<bool> buscarEAtualizarReceitas() async {
    try {
      Autorizacao? auth = await LocalStorageService.carregarAutorizacao();
      if (auth == null) return false;

      // Carrega o que já está salvo localmente (com os favoritos atuais)
      List<Receita> receitasAntigas = await LocalStorageService.carregarReceitas();

      //  Monta um mapa id -> favorito, pra consulta rápida
      Map<int, bool> favoritosSalvos = {
        for (var r in receitasAntigas) r.id: r.favorito
      };

      final response = await http.get(
        Uri.parse('${Constantes.baseUrl}/receitas-por-categoria'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${auth.token_autorizacao}',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> categoriasJson = jsonDecode(response.body);
        List<Receita> todasReceitas = [];

        for (var categoriaJson in categoriasJson) {
          String nomeCategoria = categoriaJson['nome'];
          List<dynamic> receitasJson = categoriaJson['receitas'];

          for (var receitaJson in receitasJson) {
            int id = receitaJson['id'];

            // Se essa receita já existia localmente, mantém o favorito antigo.
            //    Se for uma receita nova (nunca vista antes), usa o valor da API.
            bool favoritoFinal = favoritosSalvos.containsKey(id)
                ? favoritosSalvos[id]!
                : (receitaJson['favorito'] == 1 || receitaJson['favorito'] == true);

            todasReceitas.add(Receita(
              id: id,
              nome: receitaJson['titulo'],
              categoria: nomeCategoria,
              ingredientes: _stringParaLista(receitaJson['ingredientes']),
              preparo: _stringParaLista(receitaJson['modo_preparo']),
              favorito: favoritoFinal,
              imagemUrl: receitaJson['imagem_url'],
            ));
          }
        }

        await LocalStorageService.salvarReceitas(todasReceitas);
        return true;
      }

      return false;
    } catch (e) {
      return false;
    }
  }

  static List<String> _stringParaLista(String? texto) {
    if (texto == null || texto.trim().isEmpty) return [];
    return texto.split(',').map((e) => e.trim()).toList();
  }
}

// Cuida das operações locais sobre a lista já salva (favoritar, listar, etc.)
class ListaReceitaController {

  static Future<List<Receita>> listarFavoritas() async {
    List<Receita> todas = await LocalStorageService.carregarReceitas();
    return todas.where((r) => r.favorito == true).toList();
  }

  static Future<List<Receita>> listarPorCategoria(String categoria) async {
    List<Receita> todas = await LocalStorageService.carregarReceitas();
    return todas.where((r) => r.categoria.toLowerCase() == categoria.toLowerCase()).toList();
  }

  static Future<void> favoritarReceita(int id) async {
    List<Receita> todas = await LocalStorageService.carregarReceitas();

    List<Receita> atualizada = todas.map((r) {
      if (r.id == id) {r.favorito = !r.favorito; // inverte o valor: true vira false, false vira true
      }
      return r;
    }).toList();

    await LocalStorageService.salvarReceitas(atualizada);
  }
}