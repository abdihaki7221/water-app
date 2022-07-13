import 'package:flutter/material.dart';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// providers
import '../providers/home_provider.dart';


class DailyAmountDial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Transform.rotate(
              angle: -pi/2,
              child: Container(
                width: 170,
                height: 170,
                child: CustomPaint(
                  painter: DialPainter(provider.targetReached),
                ),
              ),
            ),
             provider.leftAmount<=0 ? Text(
               'Goal Reached',
               style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.white,)
              ):RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: provider.leftAmount<1000? '${provider.leftAmount} mL': '${(provider.leftAmount/1000).toStringAsFixed(1)} L' ,
                    style:  GoogleFonts.poppins(fontSize: 30,fontWeight: FontWeight.w600)
                  ),
                  TextSpan(text:'\n'),
                  TextSpan(
                    text: 'left to drink',
                    style:  GoogleFonts.poppins(fontSize: 12,fontWeight: FontWeight.w300)
                  ),
                ]
              ),
            )
          ],
        );
      },
    );
  }
}

class DialPainter extends CustomPainter{
  double percent;
  DialPainter(this.percent);
  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.height/2,size.width/2);
    double fullRadius = (size.height/2);
    Paint circle = Paint()..color=Colors.white.withOpacity(0.2)..strokeWidth=6..style=PaintingStyle.stroke;
    Paint arc = Paint()..color = Colors.white..strokeCap=StrokeCap.round..style=PaintingStyle.stroke..strokeWidth=10;
    canvas.drawCircle(Offset(size.width/2,size.height/2), fullRadius-2,circle);
    canvas..drawArc(Rect.fromCircle(center: center,radius: fullRadius-2), 0, 2*pi*percent, false, arc);
  }
  
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}