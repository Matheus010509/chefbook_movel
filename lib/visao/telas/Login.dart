import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:login/controle/autorizacaoController.dart';
import 'package:login/modelo/classes/autorizacao.dart';

import 'package:login/visao/telas/Splash2.dart';


class Login extends StatefulWidget {
  const Login({super.key, required this.title});

  final String title;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _enviarFormulario() async {
    if (!_formKey.currentState!.validate()) {
      return;
    } //ele envia os dados para a classe autorizacao.

    Autorizacao auth = Autorizacao(usuario: _emailController.text.trim(), senha: _passwordController.text, token_autorizacao: '',);

    bool autenticado = await AutorizaController.verificaAutorizacaoOnline(auth); //passo o usuario para ver se bate com o login salvo.
    //ele verifica isso no autorizacaocontroller

    if (!mounted) return;

    if (autenticado) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Usuário autenticado: ${auth.usuario}", //mensagem rapida para mostrar que esta autenticado. E mostrar o email
          ),
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => Splash2(), //chamo o splash que vai chamar a tela Inicio
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Usuário ou senha inválidos."), //caso o auth for diferente do padrao, manda uma mensagem rapida tmb falando que nao é validos
        ),
      );
    }
  }


  Widget _showEntrar() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),

          // EMAIL
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: "Email",
              filled: true,
              fillColor: Colors.white,
              prefixIcon: const Icon(Icons.email),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "Informe seu email";
              }

              if (!value.contains("@")) { //para ser email precisa ter o @, senao da uma mensagem vermelha
                return "Email inválido";
              }

              return null;
            },
          ),

          const SizedBox(height: 20),

          // SENHA
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              hintText: "Senha",
              filled: true,
              fillColor: Colors.white,
              prefixIcon: const Icon(Icons.lock),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Informe sua senha";
              }

              if (value.length < 6) {
                return "A senha deve possuir pelo menos 6 caracteres";
              }

              return null;
            },
          ),

          const SizedBox(height: 30),

          SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: _enviarFormulario, //vou enviar o formulario para
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text("Acessar"),
            ),
          ),

        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    ScreenUtil.init(
      context,
      designSize: const Size(750, 1304),
    );

    return Scaffold(
      body: Container(
        color: const Color(0xFFFFDDAA),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 60,
            left: 25,
            right: 25,
          ),
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
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Expanded(
                child: _showEntrar(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}