import 'package:flutter/material.dart';
import 'package:login/visao/telas/Perfil.dart';
import 'package:login/visao/telas/Favoritas.dart';
import 'package:login/visao/telas/Inicio.dart';
import 'package:login/visao/util/WidgetsUteis.dart';

class Principal extends StatefulWidget {
  const Principal({super.key});

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {

  int _currentIndex = 0;

  List<Widget> _screens = [
    TelaUm(title: 'Home'),        // index 0
    TelaDois(title: 'Favoritas'), // index 1
    TelaTres(title: 'Perfil'),    // index 2
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _screens[_currentIndex],
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.restaurant, color: Colors.white),
          WidgetsUteis().espacoHorizontal5,
          const Text(
            "ChefBook",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.orange,
      centerTitle: true,
    );
  }

  BottomNavigationBar _bottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      selectedItemColor: Colors.orange,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Início",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: "Favoritas",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "Perfil",
        ),
      ],
    );
  }
}