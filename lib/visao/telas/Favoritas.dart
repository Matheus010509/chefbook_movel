import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login/controle/receitasController.dart';
import 'package:login/modelo/classes/receita.dart';
import 'package:login/visao/telas/ReceitaDetalhe.dart';

class TelaDois extends StatefulWidget {
  const TelaDois({super.key, required this.title});

  final String title;

  @override
  State<TelaDois> createState() => _TelaDoisState();
}

class _TelaDoisState extends State<TelaDois> {
  List<Receita> _favoritas = [];

  @override
  void initState() {
    super.initState();
    _carregarFavoritas(); //para listar, quando abrir a tela as receitas favoritadas
  }

  Future<void> _carregarFavoritas() async {
    List<Receita> lista =
    await ListaReceitaController.listarFavoritas(); //pego do controller que pega do shared

    setState(() {
      _favoritas = lista;
    });
  }

  Future<void> _desfavoritar(int id) async {
    await ListaReceitaController.favoritarReceita(id); //a logica do favorita é a seguinte: colocar um valor diferente do preenchido. Se for true, vai virar false
    await _carregarFavoritas();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(750, 1304));

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
          child: const Text(
            'Receitas Favoritas',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: _favoritas.isEmpty
          ? const Center(
        child: Text(
          'Nenhuma receita favoritada.',
          style: TextStyle(fontSize: 18),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _favoritas.length,
        itemBuilder: (context, index) {
          return _cardPrevia(_favoritas[index]);
        },
      ),
    );
  }

  Widget _cardPrevia(Receita receita) { //crio esse card para lista previamente a receita, como imagem e nome
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ReceitaDetalhe(receita: receita)), //chamo essa outra pagina para exibir os dados
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
                  child: const Icon(Icons.image_not_supported,
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
              onPressed: () => _desfavoritar(receita.id), //acao de desfavoritar, que é basicamente colocar um valor false no bool
            ),
          ],
        ),
      ),
    );
  }
}