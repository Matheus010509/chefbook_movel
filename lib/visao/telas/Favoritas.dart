import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login/modelo/ItemListView.dart';
import 'package:login/visao/estilos/EstilosTexto.dart';
import 'package:login/visao/util/WidgetsUteis.dart';

class TelaDois extends StatefulWidget {
  const TelaDois({super.key, required this.title});

  final String title;

  @protected
  @override
  State<TelaDois> createState() => _TelaDoisState();
}

class _TelaDoisState extends State<TelaDois> {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    ScreenUtil.init(context, designSize: const Size(750, 1304));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Receitas Favoritas'),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),

      // SCROLL
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            _receitaCompleta(
              nome: "Lasanha",
              ingredientes: [
                "500g de carne moída",
                "1 pacote de massa de lasanha",
                "2 xícaras de molho de tomate",
                "300g de queijo mussarela",
                "Sal e temperos a gosto",
              ],
              preparo: [
                "Cozinhe a carne moída com temperos.",
                "Adicione o molho de tomate.",
                "Monte camadas de massa, carne e queijo.",
                "Repita as camadas.",
                "Leve ao forno por 30 minutos.",
              ],
            ),

            const SizedBox(height: 20), //adicionando um espaco, entre as duas receitas

            _receitaCompleta(
              nome: "Bolo de Chocolate",
              ingredientes: [
                "2 xícaras de farinha",
                "1 xícara de açúcar",
                "1 xícara de chocolate em pó",
                "3 ovos",
                "1 xícara de leite",
                "1 colher de fermento",
              ],
              preparo: [
                "Misture todos os ingredientes.",
                "Bata bem até ficar homogêneo.",
                "Despeje em uma forma untada.",
                "Leve ao forno por 40 minutos.",
                "Espere esfriar e sirva.",
              ],
            ),
          ],
        ),
      ),
    );
  }

  // aqui eu estou fazendo a telinha laranja das receitas
  Widget _receitaCompleta({
    required String nome,
    required List<String> ingredientes,
    required List<String> preparo,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text( //estilizando para ficar padronizado
            nome,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Ingredientes:", style: TextStyle(fontWeight: FontWeight.bold)),

              for (var item in ingredientes) //eu vou usar o for para tranformar cada ingrediente em uma lista bonitinha
                Text("- $item"),
            ],
          ),

          const SizedBox(height: 10),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Modo de preparo:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              for (var passo in preparo)
                Text("- $passo"), //fazendo a mesma coisa que fiz com ingredientes
            ],
          ),
        ],
      ),
    );
  }
}