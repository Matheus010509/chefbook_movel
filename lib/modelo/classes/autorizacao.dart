import 'dart:convert';

class Autorizacao {

  final String usuario;
  final String email;
  final String senha;
  final String token_autorizacao;

  Autorizacao({
    required this.usuario,
    required this.email,
    required this.senha,
    required this.token_autorizacao,
  });

  Map<String, dynamic> toMap() {
    return {
      'usuario': usuario,
      'email': email,
      'senha': senha,
      'token_autorizacao': token_autorizacao,
    };
  }

  factory Autorizacao.fromMap(Map<String, dynamic> map) {
    return Autorizacao(
      usuario: map['usuario'] ?? '',
      email: map['email'] ?? '',
      senha: map['senha'] ?? '',
      token_autorizacao: map['token_autorizacao'] ?? '',
    );
  }

  static String encode(List<Autorizacao> Autorizacaos) => json.encode(
    Autorizacaos.map<Map<String, dynamic>>((p) => p.toMap()).toList(),
  );

  static List<Autorizacao> decode(String AutorizacaosJson) =>
      (json.decode(AutorizacaosJson) as List<dynamic>).map<Autorizacao>((item) => Autorizacao.fromMap(item)).toList();
}