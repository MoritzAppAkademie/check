import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  void initState() {
    super.initState();
    // Startet einen Timer, der nach 3 Sekunden zur Hauptseite navigiert
    Future.delayed(const Duration(seconds: 3), () {
      // Überprüft, ob das Widget noch im Widget-Baum vorhanden ist, bevor navigiert wird
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Grundstruktur des Startbildschirms
    return Scaffold(
      // Zentriert den Inhalt auf dem Bildschirm
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0), // Äußerer Abstand des Inhalts
          child: Column(
            mainAxisSize: MainAxisSize.min, // Die Column nimmt minimalen vertikalen Raum ein
            crossAxisAlignment:
                CrossAxisAlignment.start, // Inhalte zentriert ausgerichtet
            children: [
              // Shimmer-Effekt auf Text anwenden
              Shimmer.fromColors(
                baseColor: Colors.white,
                highlightColor: const Color.fromRGBO(228, 132, 255, 0.724),
                child: Text(
                  'Willkommen zur Checkliste!', // Textinhalt
                  style: GoogleFonts.robotoMono(
                    textStyle:
                        Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontSize: 36, // Größe des Textes
                              fontWeight: FontWeight.w800, // Schriftgewicht
                            ),
                  ),
                ),
              ),
              const SizedBox(
                  height: 20), // Vertikaler Abstand zwischen Text und Icon
              const Icon(
                Icons
                    .check_circle_outline, // Icon, das unter dem Text angezeigt wird
                size: 48, // Größe des Icons
              ),
            ],
          ),
        ),
      ),
    );
  }
}
