import 'dart:convert';

class Receita {
  final int id;
  final String nome;
  final String categoria; // 'almoco', 'janta', 'lanche' ou 'sobremesa'
  final List<String> ingredientes;
  final List<String> preparo;
  bool favorito;

  // Construtor
  Receita({
    required this.id,
    required this.nome,
    required this.categoria,
    required this.ingredientes,
    required this.preparo,
    required this.favorito,
  });

  // Converte o objeto para um Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'categoria': categoria,
      'ingredientes': ingredientes,
      'preparo': preparo,
      'favorito': favorito,
    };
  }

  // Cria um objeto a partir de um Map
  factory Receita.fromMap(Map<String, dynamic> map) {
    return Receita(
      id: map['id'] ?? 0,
      nome: map['nome'] ?? '',
      categoria: map['categoria'] ?? '',
      ingredientes: List<String>.from(map['ingredientes'] ?? []),
      preparo: List<String>.from(map['preparo'] ?? []),
      favorito: map['favorito'] ?? false,
    );
  }

  // Converte uma lista de objetos para uma String JSON
  static String encode(List<Receita> receitas) => json.encode(
    receitas.map<Map<String, dynamic>>((r) => r.toMap()).toList(),
  );

  // Converte uma String JSON para uma lista de objetos
  static List<Receita> decode(String receitasJson) =>
      (json.decode(receitasJson) as List<dynamic>).map<Receita>((item) => Receita.fromMap(item)).toList();
}