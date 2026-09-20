import 'dart:convert';

class Receita {
  final int id;
  final String nome;
  final String categoria;
  final List<String> ingredientes;
  final List<String> preparo;
  bool favorito;
  final String? imagemUrl;

  Receita({
    required this.id,
    required this.nome,
    required this.categoria,
    required this.ingredientes,
    required this.preparo,
    required this.favorito,
    this.imagemUrl, // opcional, pois receitas antigas fake não tem
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'categoria': categoria,
      'ingredientes': ingredientes,
      'preparo': preparo,
      'favorito': favorito,
      'imagemUrl': imagemUrl,
    };
  }

  factory Receita.fromMap(Map<String, dynamic> map) {
    return Receita(
      id: map['id'] ?? 0,
      nome: map['nome'] ?? '',
      categoria: map['categoria'] ?? '',
      ingredientes: List<String>.from(map['ingredientes'] ?? []),
      preparo: List<String>.from(map['preparo'] ?? []),
      favorito: map['favorito'] ?? false,
      imagemUrl: map['imagemUrl'],
    );
  }

  static String encode(List<Receita> receitas) => json.encode(
    receitas.map<Map<String, dynamic>>((r) => r.toMap()).toList(),
  );

  static List<Receita> decode(String receitasJson) =>
      (json.decode(receitasJson) as List<dynamic>).map<Receita>((item) => Receita.fromMap(item)).toList();
}