import 'package:shared_preferences/shared_preferences.dart';
import 'package:login/modelo/classes/receita.dart';

class LocalStorageService {
  static const String LISTA_RECEITAS = 'lista_receitas';

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