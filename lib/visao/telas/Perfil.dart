import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login/controle/autorizacaoController.dart';
import 'package:login/modelo/classes/autorizacao.dart';
import 'package:login/modelo/LocalStorageService.dart';
import 'package:login/visao/telas/Login.dart';

class TelaTres extends StatefulWidget {
  const TelaTres({super.key, required this.title});

  final String title;

  @override
  State<TelaTres> createState() => _TelaTresState();
}

class _TelaTresState extends State<TelaTres> {
  Autorizacao? _usuario;

  @override
  void initState() {
    super.initState();
    _carregarUsuario();
  }

  Future<void> _carregarUsuario() async { //preparando as informacoes para exibi-las
    Autorizacao? auth = await LocalStorageService.carregarAutorizacao();

    if (!mounted) return;

    setState(() {
      _usuario = auth;
    });
  }

  Future<void> _fazerLogout() async { //vou chamar a funcao la do meu autorizacaoController de logout
    await AutorizaController.logout();

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const Login(title: "ChefBook")),
          (route) => false, // limpa toda a pilha de navegação
    );
  }

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
      body: _usuario == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
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

                    // Nome (dinâmico, vem do usuário logado)
                    _infoCard("Nome", _usuario!.usuario),

                    const SizedBox(height: 10),

                    // Email (dinâmico, vem do usuário logado)
                    _infoCard("Email", _usuario!.email),

                    const SizedBox(height: 40),

                    // Botão de logout
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _fazerLogout,
                        icon: const Icon(Icons.logout),
                        label: const Text("Sair"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),

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