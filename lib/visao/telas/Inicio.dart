import 'package:flutter/material.dart';
import 'package:login/visao/telas/ReceitasJanta.dart';
import 'package:login/visao/telas/ReceitasAlmoco.dart';
import 'package:login/visao/telas/ReceitasLanche.dart';
import 'package:login/visao/telas/ReceitasSobremesa.dart';

class TelaUm extends StatefulWidget {
  const TelaUm({super.key, required this.title});
  final String title;

  @override
  State<TelaUm> createState() => _TelaHomeState();
}

class _TelaHomeState extends State<TelaUm> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          children: [

            _categoria(context, "Almoço", Icons.lunch_dining, () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => ReceitasAlmoco()));
            }),

            _categoria(context, "Lanche", Icons.fastfood, () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => ReceitasLanche()));
            }),

            _categoria(context, "Sobremesa", Icons.cake, () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => ReceitasSobremesa()));
            }),

            _categoria(context, "Janta", Icons.dinner_dining, () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => ReceitasJanta()));
            }),
          ],
        ),
      ),
    );
  }

  Widget _categoria(BuildContext context, String titulo, IconData icone, VoidCallback onTap) {
    return GestureDetector(
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