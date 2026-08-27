import 'package:flutter/material.dart';
import 'package:login/controle/receitasController.dart';
import 'package:login/modelo/classes/receita.dart';

class ReceitasAlmoco extends StatefulWidget {
  const ReceitasAlmoco({super.key});

  @override
  State<ReceitasAlmoco> createState() => _ReceitasAlmocoState();
}

class _ReceitasAlmocoState extends State<ReceitasAlmoco> {
  List<Receita> _receitas = [];

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    final dados = await ListaReceitaController.listarReceitas(categoria: "almoco",);
    setState(() {
      _receitas = dados;
    });
  }

  Future<void> _favoritar(int id) async {
    await ListaReceitaController.favoritarReceita(id);
    await _carregarDados(); //vou favoritar a receita e logo em seguida exibir ela novamente na tela
  }

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
          children: [ //estou usando for pq no meu localstorage esta salvando cada igrediente em formato de lista. Ai da para organizar
            for (final receita in _receitas) ...[
              _receitaCompleta(receita),
              const SizedBox(height: 20),
            ],
          ],
        ),
      ),
    );
  }

  Widget _receitaCompleta(Receita receita) { //aqui eu estou criando cada receita. Isso é como se fosse um card
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
                  receita.nome,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () => _favoritar(receita.id), //chama a funcao para favoritar a receita, que esta no meu receitasController
                  icon: Icon(
                    receita.favorito ? Icons.favorite : Icons.favorite_border, //para trocar entre o coracao preenchido e vazio
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Ingredientes:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 5),
                for (var item in receita.ingredientes) Text("• $item"), //um for para mostrar os dados da receita
                const SizedBox(height: 12),
                const Text(
                  "Modo de preparo:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 5),
                for (var passo in receita.preparo) Text("• $passo"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}