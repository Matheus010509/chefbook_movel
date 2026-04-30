import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TelaDois extends StatefulWidget {
  const TelaDois({super.key, required this.title});

  final String title;

  @override
  State<TelaDois> createState() => _TelaDoisState();
}

class _TelaDoisState extends State<TelaDois> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(750, 1304));

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,

//titulo "Receitas favoritas"
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text(
            'Receitas Favoritas',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),

      // SCROLL
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _receitaCompleta(
              nome: "Lasanha",
              ingredientes: [
                "500g de carne moída",
                "1 pacote de massa de lasanha",
                "2 xícaras de molho de tomate",
                "300g de queijo mussarela",
                "Sal a gosto",
              ],
              preparo: [
                "Cozinhe a carne",
                "Adicione o molho",
                "Monte as camadas",
                "Leve ao forno",
              ],
            ),
            const SizedBox(height: 20),
            _receitaCompleta(
              nome: "Bolo de Chocolate",
              ingredientes: [
                "2 xícaras de farinha",
                "1 xícara de açúcar",
                "1 xícara de chocolate",
                "3 ovos",
                "1 xícara de leite",
              ],
              preparo: [
                "Misture tudo",
                "Bata bem",
                "Coloque na forma",
                "Asse por 40 minutos",
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _receitaCompleta({
    required String nome,
    required List<String> ingredientes,
    required List<String> preparo,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //  TÍTULO COM FUNDO
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.orange.shade200,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  nome,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Icon(Icons.favorite, color: Colors.red),
              ],
            ),
          ),

          // CONTEÚDO
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // INGREDIENTES
                const Text(
                  "Ingredientes:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 5),

                for (var item in ingredientes) Text("• $item"),

                const SizedBox(height: 12),

                // PREPARO
                const Text(
                  "Modo de preparo:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 5),

                for (var passo in preparo) Text("• $passo"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
