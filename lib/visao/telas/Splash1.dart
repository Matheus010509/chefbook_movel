import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login/controle/autorizacaoController.dart';
import 'package:login/visao/estilos/EstilosTexto.dart';
import 'package:login/visao/util/WidgetsUteis.dart';
import 'package:login/visao/telas/Login.dart';
import 'package:login/visao/telas/Splash2.dart';

// Classe inicial da tela
class Splash1 extends StatefulWidget {
  const Splash1({super.key});

  @override
  State<Splash1> createState() => _Splash1State();
}

class _Splash1State extends State<Splash1> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () async {
      await verificaLogin();
    });
  }

  Future<void> verificaLogin() async {
    debugPrint("[FEEDBACK] Verificando autenticação salva...");

    bool autenticado =
    await AutorizaController.verificaAutorizacaoOffline();

    if (!mounted) return;

    if (autenticado) {
      debugPrint("[FEEDBACK] Usuário já autenticado.");

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => Splash2(),
        ),
      );
    } else {
      debugPrint("[FEEDBACK] Usuário não autenticado.");

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const Login(
            title: "ChefBook",
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(750, 1304),
    );

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Redirecionando...",
              style: EstilosTextosCustomizado.title(context),
            ),
            WidgetsUteis().espacoHorizontal15,
            WidgetsUteis().barraCircularProgresso(),
          ],
        ),
      ),
    );
  }
}