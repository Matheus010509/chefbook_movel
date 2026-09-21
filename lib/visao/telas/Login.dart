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

  bool _senhaVisivel = false;
  bool _carregando = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _enviarFormulario() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _carregando = true);

    Autorizacao auth = Autorizacao(
      usuario: _emailController.text.trim(),
      email: '',
      senha: _passwordController.text,
      token_autorizacao: '',
    );

    bool autenticado = await AutorizaController.verificaAutorizacaoOnline(auth);

    if (!mounted) return;

    setState(() => _carregando = false);

    if (autenticado) {
      ScaffoldMessenger.of(context).showSnackBar( //mensagem de feedback para o usuario
        SnackBar(
          content: Text("Usuário autenticado: ${auth.usuario}"),
          backgroundColor: Colors.green.shade600,
          behavior: SnackBarBehavior.floating,
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => Splash2(), //me redireciona para o splash 2, e ele para a tela inicio
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Usuário ou senha inválidos."), //mensagem de algo errado
          backgroundColor: Colors.red.shade600,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Widget _campoComLabel({
    required String label,
    required TextEditingController controller,
    required IconData icone,
    required String hint,
    bool isSenha = false,
    TextInputType? teclado,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade700,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          obscureText: isSenha && !_senhaVisivel,
          keyboardType: teclado,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey.shade400),
            filled: true,
            fillColor: Colors.grey.shade100,
            prefixIcon: Icon(icone, color: Colors.orange.shade700, size: 20),
            suffixIcon: isSenha
                ? IconButton(
              icon: Icon(
                _senhaVisivel ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                color: Colors.grey.shade500,
                size: 20,
              ),
              onPressed: () => setState(() => _senhaVisivel = !_senhaVisivel), //para deixar a senha visivel e invisivel
            )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.orange.shade400, width: 1.5),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
          ),
          validator: validator,
        ),
      ],
    );
  }

  Widget _showEntrar() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "Bem-vindo de volta, Chef!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 24),

          _campoComLabel(
            label: "Email",
            controller: _emailController,
            icone: Icons.mail_outline,
            hint: "exemplo@email.com",
            teclado: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "Informe seu email";
              }
              if (!value.contains("@")) { //é necessario ter o @, senao da email
                return "Email inválido";
              }
              return null;
            },
          ),

          const SizedBox(height: 16),

          _campoComLabel(
            label: "Senha",
            controller: _passwordController,
            icone: Icons.lock_outline,
            hint: "••••••••", //para deixar caracteres bonitinhos
            isSenha: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Informe sua senha";
              }
              if (value.length < 6) { //mesma coisa que o email, precisa ter mais de 6
                return "A senha deve possuir pelo menos 6 caracteres";
              }
              return null;
            },
          ),

          const SizedBox(height: 24),

          SizedBox(
            height: 52,
            child: ElevatedButton(
              onPressed: _carregando ? null : _enviarFormulario,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange.shade600,
                foregroundColor: Colors.white,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: _carregando
                  ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2.5,
                ),
              )
                  : const Text(
                "ENTRAR",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, letterSpacing: 0.5),
              ),
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
      backgroundColor: const Color(0xFFFBF3E7),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              const SizedBox(height: 50),

              //logo
              Container(
                width: 84,
                height: 84,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.orange.shade300, width: 2),
                ),
                child: Image.asset(
                  'assets/screenshots/chef_hat.png',
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 16),

              const Text(
                "CHEFBOOK",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Seu Organizador de Receitas",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 13,
                  letterSpacing: 0.5,
                ),
              ),

              const SizedBox(height: 36),

              // CARD BRANCO COM O FORMULÁRIO
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: _showEntrar(),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}