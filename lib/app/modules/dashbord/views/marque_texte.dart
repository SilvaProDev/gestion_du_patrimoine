import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../../constants/constants.dart';

class MarqueePage extends StatefulWidget {
  const MarqueePage({super.key});

  @override
  State<MarqueePage> createState() => _MarqueePageState();
}

class _MarqueePageState extends State<MarqueePage> {
    String valeurSemaine = "Chargement...";

    @override
  void initState() {
    super.initState();
    fetchValeurSemaine();
  }

  Future<void> fetchValeurSemaine() async {
    final url = Uri.parse('$baseCodeEthique/valeur-semaine/?format=json');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // Réparer le problème d'accents
        final decoded = utf8.decode(response.bodyBytes); // <== clé ici
        final data = json.decode(decoded);

        setState(() {
          valeurSemaine = data['valeur'];
        });
      } else {
        setState(() {
          valeurSemaine = "Erreur ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        valeurSemaine = "Erreur réseau : $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(
        child: Container(
          height: 50,
          color: Colors.lightBlue[50],
          child: Marquee(
            text: "${valeurSemaine} .",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
            scrollAxis: Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.center,
            blankSpace: 60.0,
            velocity: 50.0,
            pauseAfterRound: const Duration(seconds: 1),
            startPadding: 10.0,
            accelerationDuration: const Duration(seconds: 0),
            accelerationCurve: Curves.linear,
            decelerationDuration: const Duration(milliseconds: 500),
            decelerationCurve: Curves.easeOut,
          ),
        ),
      ),
    );
  }
}
