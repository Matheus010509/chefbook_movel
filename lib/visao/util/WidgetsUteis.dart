import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login/visao/estilos/EstilosTexto.dart';
import 'package:login/visao/util/CustomIcons.dart';
import 'package:login/visao/util/SocialIcons.dart';
import 'dart:math' as math;

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


  // BARRA CIRCULAR DE PROGRESSO


  Widget barraCircularProgresso({double tamanho = 56}) {
    return SpinnerCapsulas(tamanho: tamanho);
  }


}// Indicador de carregamento com cápsulas em círculo
class SpinnerCapsulas extends StatefulWidget {
  final double tamanho;
  final Color cor;

  const SpinnerCapsulas({
    super.key,
    this.tamanho = 110,
    this.cor = Colors.white,
  });

  @override
  State<SpinnerCapsulas> createState() => _SpinnerCapsulasState();
}

class _SpinnerCapsulasState extends State<SpinnerCapsulas>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.tamanho,
      height: widget.tamanho,
      child: CustomPaint(
        painter: _CapsulasPainter(
          animacao: _controller,
          cor: widget.cor,
        ),
      ),
    );
  }
}

class _CapsulasPainter extends CustomPainter {
  final Animation<double> animacao;
  final Color cor;
  static const int quantidade = 8;

  _CapsulasPainter({required this.animacao, required this.cor})
      : super(repaint: animacao);

  @override
  void paint(Canvas canvas, Size size) {
    final double raio = size.shortestSide / 2;
    final Offset centro = Offset(size.width / 2, size.height / 2);

    final double espessura = raio * 0.16;
    final double raioInterno = raio * 0.50;
    final double raioExterno = raio - espessura / 2;

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = espessura;

    final double progresso = animacao.value * quantidade;

    for (int i = 0; i < quantidade; i++) {
      // Quanto mais atrás do brilho, mais apagada a linha
      final double atraso = (progresso - i) % quantidade;
      final double opacidade = 1.0 - (atraso / quantidade) * 0.85;

      final double angulo = i * 2 * math.pi / quantidade - math.pi / 2;
      final Offset direcao = Offset(math.cos(angulo), math.sin(angulo));

      canvas.drawLine(
        centro + direcao * raioInterno,
        centro + direcao * raioExterno,
        paint..color = cor.withOpacity(opacidade),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _CapsulasPainter oldDelegate) =>
      oldDelegate.cor != cor;
}