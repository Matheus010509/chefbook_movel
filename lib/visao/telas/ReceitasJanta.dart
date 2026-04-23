import 'package:flutter/material.dart';

class ReceitasJanta extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Janta"),
        backgroundColor: Colors.orange,
      ),
      body: const Center(
        child: Text("Receitas de Janta 🍝"),
      ),
    );
  }
}