import 'package:flutter/material.dart';
import 'package:login/visao/telas/ReceitasJanta.dart';
import 'package:login/visao/telas/ReceitasAlmoco.dart';
import 'package:login/visao/telas/ReceitasLanche.dart';
import 'package:login/visao/telas/ReceitasSobremesa.dart';

class TelaUm extends StatefulWidget {
  const TelaUm({super.key, required this.title});

  final String title;

  @override
  State<TelaUm> createState() =>
      _TelaHomeState(); //eu dei o nome de telaum, e estou usando para chamar nas outras paginas
}

class _TelaHomeState extends State<TelaUm> {
  //Ele pega o titula ChefBook da tela principal, que retornar um app bar
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          //essa é uma grid que eu coloquei, para ficar dois por dois
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          children: [
            _categoria(context, "Almoço", Icons.lunch_dining, () {
              //estou colocando um icone em todas as categorias, para ficar visualmente bonito
              Navigator.push(
                  context, //vou usar o push porque eu consigo voltar se quiser
                  MaterialPageRoute(
                      builder: (_) =>
                          ReceitasAlmoco())); //eu estou mudando de pagina, chamando o builder da receitas daquelas categorias
            }),
            _categoria(context, "Lanche", Icons.fastfood, () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => ReceitasLanche()));
            }),
            _categoria(context, "Sobremesa", Icons.cake, () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => ReceitasSobremesa()));
            }),
            _categoria(context, "Janta", Icons.dinner_dining, () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => ReceitasJanta()));
            }),
          ],
        ),
      ),
    );
  }

  Widget _categoria(
      BuildContext context, String titulo, IconData icone, VoidCallback onTap) {
    return GestureDetector(
      //esse detector serve para detectar um toque na tela. Toda vez que for tocado ele percebera
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.orange.shade100,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icone, size: 50, color: Colors.orange),
            const SizedBox(height: 10),
            Text(
              titulo,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
