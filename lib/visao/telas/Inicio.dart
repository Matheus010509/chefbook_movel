import 'package:flutter/material.dart';
import 'package:login/modelo/classes/receita.dart';
import 'package:login/modelo/LocalStorageService.dart';
import 'package:login/visao/telas/ReceitasPorCategoria.dart';

class TelaUm extends StatefulWidget {
  const TelaUm({super.key, required this.title});

  final String title;

  @override
  State<TelaUm> createState() => _TelaHomeState();
}

class _TelaHomeState extends State<TelaUm> {
  List<String> _categorias = [];

  final Map<String, IconData> _iconesConhecidos = { //ja deixo pre-pronto pois no web eu cadastrei essas categorias para todos
    'Almoço': Icons.lunch_dining,
    'Janta': Icons.dinner_dining,
    'Lanche': Icons.fastfood,
    'Sobremesa': Icons.cake,
  };

  @override
  void initState() {
    super.initState();
    _carregarCategorias();
  }

  Future<void> _carregarCategorias() async {
    List<Receita> receitas = await LocalStorageService.carregarReceitas();

    Set<String> nomesUnicos = receitas.map((r) => r.categoria).toSet(); //pois so pode existir um nome de categoria

    if (!mounted) return;

    setState(() {
      _categorias = nomesUnicos.toList();
    });
  }

  IconData _iconeDaCategoria(String categoria) {
    return _iconesConhecidos[categoria.toLowerCase()] ?? Icons.restaurant_menu;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Categorias",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: _categorias.isEmpty //caso nao tiver nenhuma categoria (nenhuma receita cadastrada na categoria) eu exibo essa mensagem
          ? const Center(child: Text("Nenhuma categoria encontrada."))
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _categorias.length,
        itemBuilder: (context, index) {
          final categoria = _categorias[index];
          return _categoriaCard(context, categoria);
        },
      ),
    );
  }

  Widget _categoriaCard(BuildContext context, String titulo) { //aqui é o card bonitinho, laranja, para exibir as categorias
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ReceitasPorCategoria(categoria: titulo), //me redireciona para a categoria clicada
          ),
        );
      },
      child: Container(
        height: 190,
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Colors.orange.shade400,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Center(
              child: Icon(
                _iconeDaCategoria(titulo),
                size: 70,
                color: Colors.white.withOpacity(0.5),
              ),
            ),

            // gradiente escuro
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.5),
                    Colors.black.withOpacity(0.0),
                  ],
                  stops: const [0.0, 0.7],
                ),
              ),
            ),

            // nome da categoria centralizado
            Center(
              child: Text(
                titulo[0].toUpperCase() + titulo.substring(1),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Colors.black54,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}