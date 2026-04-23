import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login/visao/telas/Splash2.dart';
import 'package:login/visao/telas/TelaRecuperacaoSenha.dart';
import 'package:login/visao/telas/Principal.dart';

bool _entrarActive = false;
bool _cadastrarActive = true;

TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();
TextEditingController _newEmailController = TextEditingController();
TextEditingController _newPasswordController = TextEditingController();

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

  // 🔐 LOGIN
  Widget _showEntrar(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [

        const SizedBox(height: 20),

        TextField(
          controller: _emailController,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            hintText: "Email",
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            prefixIcon: const Icon(Icons.email, color: Colors.grey),
          ),
        ),

        const SizedBox(height: 20),

        TextField(
          controller: _passwordController,
          obscureText: true,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            hintText: "Senha",
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            prefixIcon: const Icon(Icons.lock, color: Colors.grey),
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
            style: TextStyle(color: Colors.white70),
          ),
        ),
      ],
    );
  }

  // 📝 CADASTRO
  Widget _showCadastrar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [

        const SizedBox(height: 20),

        TextField(
          controller: _newEmailController,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            hintText: "Novo email",
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            prefixIcon: const Icon(Icons.email, color: Colors.grey),
          ),
        ),

        const SizedBox(height: 20),

        TextField(
          controller: _newPasswordController,
          obscureText: true,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            hintText: "Nova senha",
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            prefixIcon: const Icon(Icons.lock, color: Colors.grey),
          ),
        ),

        const SizedBox(height: 30),

        ElevatedButton(
          onPressed: () => telaSplash2(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text("Cadastrar"),
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
        color: const Color(0xFFFFCC80),
        child: Padding(
          padding: const EdgeInsets.only(top: 60, left: 25, right: 25),
          child: Column(
            children: [

              // 🧾 LOGO
              const Column(
                children: [
                  Text(
                    "ChefBook",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Seu organizador de receitas",
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // 🔘 MENU
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => setState(() => _alterarParaEntrar()),
                    child: Text(
                      "ACESSAR",
                      style: TextStyle(
                        fontSize: _cadastrarActive ? 20 : 16,
                        color: Colors.white,
                        fontWeight: _cadastrarActive ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => setState(() => _alterarParaCadastrar()),
                    child: Text(
                      "CADASTRAR",
                      style: TextStyle(
                        fontSize: _entrarActive ? 20 : 16,
                        color: Colors.white,
                        fontWeight: _entrarActive ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              Expanded(
                child: _cadastrarActive
                    ? _showEntrar(context)
                    : _showCadastrar(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void _alterarParaCadastrar() {
    _entrarActive = true;
    _cadastrarActive = false;
  }

  static void _alterarParaEntrar() {
    _entrarActive = false;
    _cadastrarActive = true;
  }
}