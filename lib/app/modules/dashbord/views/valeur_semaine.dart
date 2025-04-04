import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../constants/constants.dart';
import '../../../layout/layout.dart';
import 'currentPage.dart';

class ValeurSemainePage extends StatefulWidget {
   ValeurSemainePage({super.key});

  @override
  State<ValeurSemainePage> createState() => _ValeurSemainePageState();
}

class _ValeurSemainePageState extends State<ValeurSemainePage> {
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
      appBar: AppBar(
        centerTitle: true,
        title:  Text("VALEUR DE LA SEMAINE", style: kHeading,),
        backgroundColor: Colors.lightBlueAccent,
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Container(height: 220,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.lightBlue[100], // Couleur de fond du container
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(24),
                child:  Text(
                  "$valeurSemaine",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Container(height: 90,),
             Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: ElevatedButton(
              onPressed: () {
                Get.offAll(() =>  CurentPage());
              },
              style: ElevatedButton.styleFrom(
                elevation: 3,
                backgroundColor: Colors.lightBlue,
                padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.login, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    "Dashbord",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          )
          ],
        ),
        
      ),
      
    );
  }
}
