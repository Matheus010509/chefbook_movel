import 'package:login/modelo/LocalStorageService.dart';
import 'package:login/modelo/classes/receita.dart';

class ListaReceitaController {
  static Future<List<Receita>> listarReceitas({
    String? categoria,
  }) async {
    final receitas =
    await LocalStorageService.carregarReceitas();

    if (categoria == null) {
      return receitas;
    }

    return receitas
        .where((r) => r.categoria == categoria)
        .toList();
  }

  static Future<List<Receita>> listarFavoritas() async {
    final receitas =
    await LocalStorageService.carregarReceitas();

    return receitas
        .where((r) => r.favorito)
        .toList();
  }

  static Future<void> favoritarReceita(int id) async {
    final receitas =
    await LocalStorageService.carregarReceitas();

    for (final receita in receitas) {
      if (receita.id == id) {
        receita.favorito = !receita.favorito;

        await LocalStorageService.salvarReceitas(
          receitas,
        );

        break;
      }
    }
  }
}