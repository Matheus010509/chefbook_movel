import 'package:shared_preferences/shared_preferences.dart';
import 'package:login/modelo/classes/receita.dart';
import 'package:login/modelo/classes/autorizacao.dart';
import 'dart:convert';

class LocalStorageService {
  static const String LISTA_RECEITAS = 'lista_receitas';
  static const String AUTORIZACAO = 'autorizacao';

  // AUTORIZAÇÃO

  static Future<void> salvarAutorizacao(Autorizacao auth) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String encodedData = json.encode(auth.toMap());
    await prefs.setString(AUTORIZACAO, encodedData);
  }

  static Future<void> desgravarAutorizacao() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(AUTORIZACAO);
  }

  static Future<Autorizacao?> carregarAutorizacao() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

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
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String encodedData = Receita.encode(lista);
    await prefs.setString(LISTA_RECEITAS, encodedData,);
  }

  static Future<void> limparReceitas() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(LISTA_RECEITAS);
  }

  static Future<List<Receita>> carregarReceitas() async {
    final SharedPreferences prefs =
    await SharedPreferences.getInstance();

    final String? receitasJson = prefs.getString(LISTA_RECEITAS);

    // Nenhuma receita salva ainda (ex: logo após logout, antes do Splash2 sincronizar com a API).
    // Retorna lista vazia em vez de dados fake, pra não misturar receitas de exemplo com as receitas reais da API.
    if (receitasJson == null) {
      return [];
    }

    // Se já existem receitas salvas, carrega diretamente do SharedPreferences.
    return Receita.decode(receitasJson);
  }
}