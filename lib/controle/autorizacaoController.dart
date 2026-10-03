import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:login/modelo/classes/autorizacao.dart';
import 'package:login/modelo/LocalStorageService.dart';
import 'package:login/visao/util/constantes.dart';

class AutorizaController {

  static Future<void> gravaAutorizacao(String usuario, String email, String token) async {
    Autorizacao auth = Autorizacao(
      usuario: usuario,
      email: email,
      senha: '',
      token_autorizacao: token,
    );
    await LocalStorageService.salvarAutorizacao(auth);
  }

  static Future<void> desgravaAutorizacao() async {
    await LocalStorageService.desgravarAutorizacao();
  }

  static Future<bool> verificaAutorizacaoOnline(Autorizacao auth) async {
    try {
      final response = await http.post(
        Uri.parse('${Constantes.baseUrl}/login'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': auth.usuario,
          'password': auth.senha,
        }),
      );

      if (response.statusCode == 200) {
        final dados = jsonDecode(response.body);
        final token = dados['token'];
        final nomeUsuario = dados['user']['name'];
        final emailUsuario = dados['user']['email'];

        await gravaAutorizacao(nomeUsuario, emailUsuario, token);
        return true;
      }

      return false;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> verificaAutorizacaoOffline() async {
    Autorizacao? auth = await LocalStorageService.carregarAutorizacao();
    if (auth == null) return false;
    return true;
  }

  static Future<void> logout() async {
    try {
      Autorizacao? auth = await LocalStorageService.carregarAutorizacao();

      if (auth != null) {
        await http.post(
          Uri.parse('${Constantes.baseUrl}/logout'),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${auth.token_autorizacao}', //token de autorizacao do laravel
          },
        );
      }
    } catch (e) {
      // falha ao notificar a API, mas segue limpando a sessão local mesmo assim
    }

    await desgravaAutorizacao();
    await LocalStorageService.limparReceitas(); // limpa as receitas do usuário anterior, para sempre atualizar de usuario para usuario
  }
}