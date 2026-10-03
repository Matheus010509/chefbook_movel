import 'package:flutter/material.dart';
import 'package:login/controle/receitasController.dart';
import 'package:login/modelo/classes/receita.dart';
import 'package:login/visao/telas/ReceitaDetalhe.dart';

class ReceitasPorCategoria extends StatefulWidget {
  final String categoria;

  const ReceitasPorCategoria({super.key, required this.categoria});

  @override
  State<ReceitasPorCategoria> createState() => _ReceitasPorCategoriaState();
}

class _ReceitasPorCategoriaState extends State<ReceitasPorCategoria> {
  List<Receita> _receitas = [];

  @override
  void initState() {
    super.initState();
    _carregarReceitas();
  }

  Future<void> _carregarReceitas() async {
    List<Receita> lista = await ListaReceitaController.listarPorCategoria(widget.categoria);
    //listo apenas as categorias que possuem pelo menos uma receita

    if (!mounted) return;

    setState(() {
      _receitas = lista;
    });
  }

  Future<void> _alternarFavorito(int id) async {
    await ListaReceitaController.favoritarReceita(id);
    await _carregarReceitas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, //  mesma cor do AppBar
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            widget.categoria,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: _receitas.isEmpty
          ? const Center(
        child: Text(
          'Nenhuma receita nessa categoria ainda.',
          style: TextStyle(fontSize: 18),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _receitas.length,
        itemBuilder: (context, index) {
          return _cardPrevia(_receitas[index]);
        },
      ),
    );
  }

  Widget _cardPrevia(Receita receita) {
    return GestureDetector(
      onTap: () {
        Navigator.push( //empilho a pagina de detalhe, pois ai depois consigo voltar
          context,
          MaterialPageRoute(builder: (_) => ReceitaDetalhe(receita: receita)),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.orange.shade50,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              child: receita.imagemUrl != null
                  ? Image.network(
                receita.imagemUrl!,
                width: 90,
                height: 90,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 90,
                  height: 90,
                  color: Colors.orange.shade100,
                  child: const Icon(Icons.image_not_supported, //caso a imagem de errado, mostro esse icone
                      color: Colors.orange),
                ),
              )
                  : Container(
                width: 90,
                height: 90,
                color: Colors.orange.shade100,
                child: const Icon(Icons.restaurant, color: Colors.orange),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Text(
                  receita.nome,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                receita.favorito ? Icons.favorite : Icons.favorite_border,
                color: Colors.red,
              ),
              onPressed: () => _alternarFavorito(receita.id), //coloca um valor oposto do preenchido
            ),
          ],
        ),
      ),
    );
  }
}