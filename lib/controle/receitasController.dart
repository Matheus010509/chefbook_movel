import 'package:login/modelo/LocalStorageService.dart';
import 'package:login/modelo/classes/receita.dart';

class ListaReceitaController {
  static Future<List<Receita>> listarReceitas({
    String? categoria,
  }) async {
    final receitas = await LocalStorageService.carregarReceitas();

    if (categoria == null) {
      return receitas;
    }

    return receitas.where((r) => r.categoria == categoria).toList(); //para eu conseguir exibir em cada categoria suas respectivas receitas
  }

  static Future<List<Receita>> listarFavoritas() async {
    final receitas = await LocalStorageService.carregarReceitas(); //carrego as receitas que tem o favorito "true"

    return receitas.where((r) => r.favorito).toList();
  }

  static Future<void> favoritarReceita(int id) async {
    final receitas = await LocalStorageService.carregarReceitas();

    for (final receita in receitas) {
      if (receita.id == id) {
        receita.favorito = !receita.favorito; //colocar com diferente do que ja esta preenchido. Ex; se ta favoritada, vai desfavoritar

        await LocalStorageService.salvarReceitas(
          receitas,
        );

        break;
      }
    }
  }
}