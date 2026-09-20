import 'package:flutter/material.dart';
import 'package:login/controle/receitasController.dart';
import 'package:login/modelo/classes/receita.dart';

class ReceitaDetalhe extends StatefulWidget {
  final Receita receita;

  const ReceitaDetalhe({super.key, required this.receita});

  @override
  State<ReceitaDetalhe> createState() => _ReceitaDetalheState();
}

class _ReceitaDetalheState extends State<ReceitaDetalhe> {
  late Receita _receita;

  @override
  void initState() {
    super.initState();
    _receita = widget.receita;
  }

  Future<void> _alternarFavorito() async { //para favoritar e desvaritar, colocando valores opostos
    await ListaReceitaController.favoritarReceita(_receita.id);

    setState(() {
      _receita.favorito = !_receita.favorito;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: CustomScrollView(
        slivers: [
          // AppBar com imagem de fundo, que recolhe ao rolar
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            backgroundColor: Colors.orange,
            iconTheme: const IconThemeData(color: Colors.white),
            flexibleSpace: FlexibleSpaceBar(
              background: _receita.imagemUrl != null
                  ? Container(
                color: Colors.black,
                child: Image.network(
                  _receita.imagemUrl!, //pego essa imagem que foi definida no model e salva no shared
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.orange.shade100,
                    child: const Icon(Icons.image_not_supported,
                        size: 60, color: Colors.orange),
                  ),
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return Container(
                      color: Colors.black,
                      child: const Center(
                        child: CircularProgressIndicator(color: Colors.orange),
                      ),
                    );
                  },
                ),
              )
                  : Container(
                color: Colors.orange.shade100,
                child: const Icon(Icons.restaurant, size: 70, color: Colors.orange),
              ),
            ),
          ),

          // Conteúdo
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          _receita.nome,
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                      GestureDetector(
                        onTap: _alternarFavorito,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            _receita.favorito ? Icons.favorite : Icons.favorite_border,
                            color: Colors.red,
                            size: 26,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Chip da categoria
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade100,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _receita.categoria[0].toUpperCase() + _receita.categoria.substring(1),
                      style: TextStyle(
                        color: Colors.orange.shade800,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  // Card de ingredientes
                  _secaoCard(
                    titulo: "Ingredientes",
                    icone: Icons.shopping_basket_outlined,
                    itens: _receita.ingredientes,
                  ),

                  const SizedBox(height: 20),

                  // Card de modo de preparo
                  _secaoCard(
                    titulo: "Modo de preparo",
                    icone: Icons.soup_kitchen_outlined,
                    itens: _receita.preparo,
                    numerado: true,
                  ),

                  const SizedBox(height: 36),

                  // Botão de voltar no final da tela
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: OutlinedButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back),
                      label: const Text(
                        "Voltar",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.orange.shade700,
                        side: BorderSide(color: Colors.orange.shade400, width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _secaoCard({
    required String titulo,
    required IconData icone,
    required List<String> itens,
    bool numerado = false,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icone, color: Colors.orange.shade700, size: 22),
              const SizedBox(width: 8),
              Text(
                titulo,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ...itens.asMap().entries.map((entry) {
            final index = entry.key;
            final texto = entry.value;

            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  numerado
                      ? Container(
                    width: 24,
                    height: 24,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.orange.shade600,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      "${index + 1}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                      : Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.only(top: 6),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade600,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      texto,
                      style: const TextStyle(fontSize: 15, height: 1.4),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}