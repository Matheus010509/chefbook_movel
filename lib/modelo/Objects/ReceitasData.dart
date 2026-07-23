import 'package:login/modelo/classes/receita.dart';

/// Lista fixa de todas as receitas do aplicativo.
class ReceitasData {
  static final List<Receita> todas = [
    Receita(
      id: 1,
      nome: "Arroz e Feijão",
      categoria: "almoco",
      ingredientes: [
        "Arroz",
        "Feijão",
        "Sal",
      ],
      preparo: [
        "Cozinhe o arroz.",
        "Cozinhe o feijão.",
        "Sirva juntos.",
      ],
      favorito: false,
    ),

    Receita(
      id: 2,
      nome: "Carne Assada",
      categoria: "almoco",
      ingredientes: [
        "Carne",
        "Alho",
        "Sal",
      ],
      preparo: [
        "Tempere a carne.",
        "Leve ao forno.",
        "Asse por 40 minutos.",
      ],
      favorito: false,
    ),

    Receita(
      id: 3,
      nome: "Lasanha",
      categoria: "janta",
      ingredientes: [
        "500g de carne moída",
        "1 pacote de massa de lasanha",
        "2 xícaras de molho de tomate",
        "300g de mussarela",
      ],
      preparo: [
        "Prepare o molho.",
        "Monte as camadas.",
        "Leve ao forno por 40 minutos.",
      ],
      favorito: false,
    ),

    Receita(
      id: 4,
      nome: "Sanduíche Natural",
      categoria: "lanche",
      ingredientes: [
        "Pão de forma",
        "Peito de peru",
        "Alface",
        "Tomate",
      ],
      preparo: [
        "Monte o sanduíche.",
        "Sirva gelado.",
      ],
      favorito: false,
    ),

    Receita(
      id: 5,
      nome: "Brigadeiro",
      categoria: "sobremesa",
      ingredientes: [
        "Leite condensado",
        "Chocolate em pó",
        "Manteiga",
      ],
      preparo: [
        "Misture os ingredientes.",
        "Mexa até engrossar.",
        "Deixe esfriar.",
      ],
      favorito: false,
    ),
  ];
}