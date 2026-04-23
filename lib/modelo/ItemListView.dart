//classe modelo de objeto
class ItemListView {
  final String dataHora;
  final String valor;

  ItemListView({required this.dataHora, required this.valor});

  factory ItemListView.fromJson(Map<String, dynamic> json) {
    return ItemListView(
      dataHora: json['dataHora'],
      valor: json['valor'],
    );
  }
}