import 'package:flutter/material.dart';

class ReceitasLanche extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lanche"),
        backgroundColor: Colors.orange,
      ),
      body: const Center(
        child: Text("Receitas de Lanche 🍔"),
      ),
    );
  }
}