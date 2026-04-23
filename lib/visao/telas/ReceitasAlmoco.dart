import 'package:flutter/material.dart';

class ReceitasAlmoco extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Almoço"),
        backgroundColor: Colors.orange,
      ),
      body: const Center(
        child: Text("Receitas de Almoço 🍛"),
      ),
    );
  }
}