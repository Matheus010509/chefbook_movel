import 'package:flutter/material.dart';

class ReceitasSobremesa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sobremesa"),
        backgroundColor: Colors.orange,
      ),
      body: const Center(
        child: Text("Receitas de Sobremesa 🍰"),
      ),
    );
  }
}