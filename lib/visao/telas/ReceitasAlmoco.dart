import 'package:flutter/material.dart';

class ReceitasAlmoco extends StatelessWidget {
  const ReceitasAlmoco({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Almoço'),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            _receitaCompleta(
              nome: "Arroz e Feijão",
              ingredientes: [
                "Arroz",
                "Feijão",
                "Sal",
              ],
              preparo: [
                "Cozinhe o arroz",
                "Cozinhe o feijão",
                "Sirva juntos",
              ],
            ),

            const SizedBox(height: 20),

            _receitaCompleta(
              nome: "Carne Assada",
              ingredientes: [
                "Carne",
                "Alho",
                "Sal",
              ],
              preparo: [
                "Tempere a carne",
                "Leve ao forno",
                "Asse por 40 minutos",
              ],
            ),

          ],
        ),
      ),
    );
  }

  Widget _receitaCompleta({ //segue a mesma logica que as receitas favoritas
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

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                nome,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              IconButton(
                onPressed: () {
                },
                icon: const Icon(
                  Icons.favorite_border,
                  color: Colors.red,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          const Text("Ingredientes:",
              style: TextStyle(fontWeight: FontWeight.bold)),

          for (var item in ingredientes)
            Text("- $item"),

          const SizedBox(height: 10),

          const Text("Modo de preparo:",
              style: TextStyle(fontWeight: FontWeight.bold)),

          for (var passo in preparo)
            Text("- $passo"),
        ],
      ),
    );
  }
}