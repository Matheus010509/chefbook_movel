import 'package:login/modelo/Objects/ReceitasData.dart';
import 'package:login/modelo/classes/receita.dart';

class ListaReceitaController {

  static Future<List<Receita>> listarReceitas({
    String? categoria,
  }) async {

    if (categoria == null) {
      return ReceitasData.todas;
    }

    return ReceitasData.todas
        .where((r) => r.categoria == categoria)
        .toList();
  }

  static Future<List<Receita>> listarFavoritas() async {

    return ReceitasData.todas
        .where((r) => r.favorito)
        .toList();
  }

  static Future<void> favoritarReceita(int id) async {

    for (Receita receita in ReceitasData.todas) {

      if (receita.id == id) {

        receita.favorito = !receita.favorito;

        break;
      }
    }
  }

}