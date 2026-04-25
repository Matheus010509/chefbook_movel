import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login/visao/telas/Splash2.dart';
import 'package:login/visao/telas/TelaRecuperacaoSenha.dart';

TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();

class Login extends StatefulWidget {
  const Login({super.key, required this.title});
  final String title;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  telaSplash2(context){
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Splash2()),
    );
  }

  telaRecuperacaoSenha(context){
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => TelaRecuperacaoSenha()),
    );
  }

  // LOGIN
  Widget _showEntrar(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [

        const SizedBox(height: 20),

        TextField(
          controller: _emailController,
          decoration: InputDecoration(
            hintText: "Email",
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            prefixIcon: const Icon(Icons.email),
          ),
        ),

        const SizedBox(height: 20),

        TextField(
          controller: _passwordController,
          obscureText: true,
          decoration: InputDecoration(
            hintText: "Senha",
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            prefixIcon: const Icon(Icons.lock),
          ),
        ),

        const SizedBox(height: 30),

        SizedBox(
          height: 50,
          child: ElevatedButton(
            onPressed: () => telaSplash2(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text("Acessar"),
          ),
        ),

        const SizedBox(height: 15),

        TextButton(
          onPressed: () => telaRecuperacaoSenha(context),
          child: const Text(
            "Esqueci minha senha",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    ScreenUtil.init(context, designSize: const Size(750, 1304));

    return Scaffold(
      body: Container(
        color: const Color(0xFFFFDDAA),
        child: Padding(
          padding: const EdgeInsets.only(top: 60, left: 25, right: 25),
          child: Column(
            children: [

              const Column(
                children: [
                  Text(
                    "ChefBook",
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Seu organizador de receitas",
                    style: TextStyle(color: Colors.black87,
                      fontSize: 18
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              Expanded(
                child: _showEntrar(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}