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

  Widget _receitaCompleta({
    required String nome, //eu estou colocando como necessario vim uma lista
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
            //estou coloando uma sombra preta
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //estilizando o titulo, colocando um fundo nele, deixando arrendondado
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
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite_border,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),

          //aqui eu estou colando os conteudos das receitas
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //ingredientes
                const Text(
                  "Ingredientes:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 5),

                for (var item
                    in ingredientes) //eu uso esse for para tranformar a lista em  topicos
                  Text("• $item"),

                const SizedBox(height: 12),

                //modo de preparo
                const Text(
                  "Modo de preparo:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 5),

                for (var passo in preparo) //msm coisa que me ingredientes
                  Text("• $passo"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
