import 'package:shared_preferences/shared_preferences.dart';
import 'package:login/modelo/classes/receita.dart';
import 'package:login/modelo/classes/autorizacao.dart';
import 'dart:convert';

class LocalStorageService {
  static const String LISTA_RECEITAS = 'lista_receitas';
  static const String AUTORIZACAO = 'autorizacao';

  // AUTORIZAÇÃO


  static Future<void> salvarAutorizacao(Autorizacao auth) async {
    final SharedPreferences prefs =
    await SharedPreferences.getInstance();

    final String encodedData = json.encode(auth.toMap());

    await prefs.setString(AUTORIZACAO, encodedData);
  }

  static Future<void> desgravarAutorizacao() async {
    final SharedPreferences prefs =
    await SharedPreferences.getInstance();

    await prefs.remove(AUTORIZACAO);
  }

  static Future<Autorizacao?> carregarAutorizacao() async {
    final SharedPreferences prefs =
    await SharedPreferences.getInstance();

    final String? authJson =
    prefs.getString(AUTORIZACAO);

    if (authJson == null) {
      return null;
    }

    return Autorizacao.fromMap(json.decode(authJson));
  }


  // RECEITAS


  static Future<void> salvarReceitas(
      List<Receita> lista) async {
    final SharedPreferences prefs =
    await SharedPreferences.getInstance();

    final String encodedData =
    Receita.encode(lista);

    await prefs.setString(
      LISTA_RECEITAS,
      encodedData,
    );
  }

  static Future<List<Receita>> carregarReceitas() async {
    final SharedPreferences prefs =
    await SharedPreferences.getInstance();

    final String? receitasJson =
    prefs.getString(LISTA_RECEITAS);

    // Primeira execução:
    // ainda não existem receitas salvas.
    if (receitasJson == null) {
      final List<Receita> receitasIniciais = [
        Receita(
          id: 1,
          nome: "Arroz e Feijão",
          categoria: "almoco",
          ingredientes: [
            "Arroz",
            "Feijão",
            "Sal",
          ],
          preparo: [
            "Cozinhe o arroz.",
            "Cozinhe o feijão.",
            "Sirva juntos.",
          ],
          favorito: false,
        ),

        Receita(
          id: 2,
          nome: "Carne Assada",
          categoria: "almoco",
          ingredientes: [
            "Carne",
            "Alho",
            "Sal",
          ],
          preparo: [
            "Tempere a carne.",
            "Leve ao forno.",
            "Asse por 40 minutos.",
          ],
          favorito: false,
        ),

        Receita(
          id: 3,
          nome: "Lasanha",
          categoria: "janta",
          ingredientes: [
            "500g de carne moída",
            "1 pacote de massa de lasanha",
            "2 xícaras de molho de tomate",
            "300g de mussarela",
          ],
          preparo: [
            "Prepare o molho.",
            "Monte as camadas.",
            "Leve ao forno por 40 minutos.",
          ],
          favorito: false,
        ),

        Receita(
          id: 4,
          nome: "Sanduíche Natural",
          categoria: "lanche",
          ingredientes: [
            "Pão de forma",
            "Peito de peru",
            "Alface",
            "Tomate",
          ],
          preparo: [
            "Monte o sanduíche.",
            "Sirva gelado.",
          ],
          favorito: false,
        ),

        Receita(
          id: 5,
          nome: "Brigadeiro",
          categoria: "sobremesa",
          ingredientes: [
            "Leite condensado",
            "Chocolate em pó",
            "Manteiga",
          ],
          preparo: [
            "Misture os ingredientes.",
            "Mexa até engrossar.",
            "Deixe esfriar.",
          ],
          favorito: false,
        ),
      ];

      // Salva as receitas no SharedPreferences.
      await salvarReceitas(receitasIniciais);

      return receitasIniciais;
    }

    // Se já existem receitas salvas,
    // carrega diretamente do SharedPreferences.
    return Receita.decode(receitasJson);
  }
}