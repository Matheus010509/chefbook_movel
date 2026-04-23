import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login/modelo/ItemListView.dart';
import 'package:login/visao/estilos/EstilosTexto.dart';
import 'package:login/visao/util/WidgetsUteis.dart';

class TelaTres extends StatefulWidget {
  const TelaTres({super.key, required this.title});

  final String title;

  @protected
  @override
  State<TelaTres> createState() => _TelaTresState();
}

class _TelaTresState extends State<TelaTres> {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    ScreenUtil.init(context, designSize: const Size(750, 1304));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),

      // 👇 CONTEÚDO DA TELA
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // 👤 Ícone
            const Icon(
              Icons.person,
              size: 80,
              color: Colors.orange,
            ),

            const SizedBox(height: 20),

            // 🧾 Nome
            _infoCard("Nome", "Matheus Nascimento"),

            const SizedBox(height: 10),

            // 📧 Email
            _infoCard("Email", "matheusnascimento010520@gmail.com"),

            const SizedBox(height: 10),

            // 🔒 Senha
            _infoCard("Senha", "********"),
          ],
        ),
      ),
    );
  }

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
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(valor),
        ],
      ),
    );
  }
}