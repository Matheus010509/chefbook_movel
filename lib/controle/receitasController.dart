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

      // Favoritos salvos por usuário (sobrevivem ao logout)
      final Set<int> favoritosIds =
      await LocalStorageService.carregarFavoritos(auth.email);

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

            // É favorita se estiver no conjunto local do usuário
            // ou se a API já a marcar como favorita.
            bool favoritoFinal = favoritosIds.contains(id) ||
                (receitaJson['favorito'] == 1 || receitaJson['favorito'] == true);

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
    final auth = await LocalStorageService.carregarAutorizacao();
    if (auth == null) return;

    List<Receita> todas = await LocalStorageService.carregarReceitas();
    for (var r in todas) {
      if (r.id == id) r.favorito = !r.favorito;
    }
    await LocalStorageService.salvarReceitas(todas);

    final ids = todas.where((r) => r.favorito).map((r) => r.id).toSet();
    await LocalStorageService.salvarFavoritos(auth.email, ids);
  }
}