import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login/visao/estilos/EstilosTexto.dart';
import 'package:login/visao/util/CustomIcons.dart';
import 'package:login/visao/util/SocialIcons.dart';

class WidgetsUteis {

  // ORGANIZADORES

  // Espaço vertical de 15 pixels
  SizedBox espacoHorizontal15 = SizedBox(
    height: 15.h,
  );

  // Espaço vertical de 5 pixels
  SizedBox espacoHorizontal5 = SizedBox(
    height: 5.h,
  );

  // Linha horizontal
  Widget horizontalLine() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        height: 1.0,
        color: Colors.white.withOpacity(0.6),
      ),
    );
  }

  // BOTÕES

  Widget botaoAzulBorda({
    required BuildContext context,
    required String texto,
    required Function executa,
  }) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF3C5A99),
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: const BorderSide(
              color: Colors.white,
              width: 2.0,
            ),
          ),
          elevation: 4.0,
          overlayColor: Colors.blueAccent.withOpacity(0.2),
        ),
        onPressed: () {
          executa(context);
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(width: 8.0),
            Text(
              texto,
              style: EstilosTextosCustomizado.button(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget botaoAzulBordaIcone({
    required BuildContext context,
    required String texto,
    required Icon icone,
    required Function executa,
  }) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF3C5A99),
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: const BorderSide(
              color: Colors.white,
              width: 2.0,
            ),
          ),
          elevation: 4.0,
          overlayColor: Colors.blueAccent.withOpacity(0.2),
        ),
        onPressed: () {
          executa(context);
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            icone,
            const SizedBox(width: 8.0),
            Text(
              texto,
              style: EstilosTextosCustomizado.button(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget botaoSemBorda({
    required BuildContext context,
    required String texto,
    required Function executa,
  }) {
    return ElevatedButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(12),
        elevation: 2,
        shadowColor: Colors.blue,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Color.fromRGBO(85, 63, 48, 1.0),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      onPressed: () {
        executa(context);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconeSocial(CustomIcons.email),
          const SizedBox(width: 8.0),
          Text(
            texto,
            textAlign: TextAlign.center,
            style: EstilosTextosCustomizado.button(context),
          ),
        ],
      ),
    );
  }


  // LISTA




  // BARRA CIRCULAR DE PROGRESSO

  Widget barraCircularProgresso() {
    return const SizedBox(
      width: 150,
      height: 150,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: CircularProgressIndicator(
              strokeWidth: 8.0,
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.white70,
              ),
            ),
          ),
          SizedBox(
            width: 150,
            height: 150,
            child: CircularProgressIndicator(
              strokeWidth: 8.0,
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}