import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TelaTres extends StatefulWidget {
  const TelaTres({super.key, required this.title});

  final String title;

  @override
  State<TelaTres> createState() => _TelaTresState();
}

class _TelaTresState extends State<TelaTres> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(750, 1304));

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,

        //  TÍTULO
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text(
            'Perfil',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              // evita erro de overflow
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),

                    // Ícone de perfil
                    const Icon(
                      Icons.person,
                      size: 80,
                      color: Colors.orange,
                    ),

                    const SizedBox(height: 20),

                    // Nome
                    _infoCard("Nome", "Matheus Nascimento"),

                    const SizedBox(height: 10),

                    // Email
                    _infoCard("Email", "matheusnascimento010520@gmail.com"),

                    const SizedBox(height: 10),

                    // Senha
                    _infoCard("Senha", "********"),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // estilizando o card de informacao
  Widget _infoCard(String titulo, String valor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Text(
            "$titulo: ",
            style: const TextStyle(
                fontWeight: FontWeight.bold), //colocando o titulo em negrito
          ),
          Expanded(
            //  evita quebrar layout se texto for grande
            child: Text(valor),
          ),
        ],
      ),
    );
  }
}
