import 'package:shared_preferences/shared_preferences.dart';
import 'package:login/modelo/classes/receita.dart';
import 'package:login/modelo/classes/autorizacao.dart';
import 'dart:convert';

class LocalStorageService {
  static const String LISTA_RECEITAS = 'lista_receitas';
  static const String AUTORIZACAO = 'autorizacao';

  // Salvar a lista
  static Future<void> salvarAutorizacao( Autorizacao auth) async {
    //instancia a classe sp
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //converte a lista de produtos em string
    final String encodedData = json.encode(auth.toMap());
    //Persiste o dadop
    await prefs.setString(AUTORIZACAO, encodedData);
  }
  // Salvar a lista
  static Future<void> desgravarAutorizacao() async {
    //instancia a classe sp
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(AUTORIZACAO);
  }
  // Recuperar a lista
  static Future<Autorizacao?> carregarAutorizacao() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? authJson = prefs.getString(AUTORIZACAO);

    if (authJson == null) return null;

    //RETORNA LISTA DE PRODUTOS
    return Autorizacao.fromMap(json.decode(authJson));
  }
  // Salvar a lista
  static Future<void> salvarReceitas(List<Receita> lista) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String encodedData = Receita.encode(lista);

    await prefs.setString(LISTA_RECEITAS, encodedData);
  }

  // Recuperar a lista
  static Future<List<Receita>> carregarReceitas() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? receitasJson = prefs.getString(LISTA_RECEITAS);

    if (receitasJson == null) return [];

    return Receita.decode(receitasJson);
  }
}