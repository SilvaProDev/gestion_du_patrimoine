import 'package:flutter/material.dart';
import 'package:gestion_patrimoine_dcf/app/modules/marche/models/image_marche.dart';

import '../../../../constants/constants.dart';

class ImageMarche extends StatelessWidget {
  final ImageMarcheModel imageMarche;

  const ImageMarche({
    super.key,
    required this.imageMarche,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("hello silva");
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        height: 130, // Hauteur fixe pour un meilleur affichage
        width: double.infinity,
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12, 
              spreadRadius: 2, blurRadius: 16)
          ],
          image: DecorationImage(
            image: NetworkImage('${imageUrl}/imagemarches/${imageMarche.fichier}'),
            fit: BoxFit.cover, // Permet d'ajuster l'image correctement
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            // Container(
            //   padding: const EdgeInsets.all(8),
            //   decoration: BoxDecoration(
            //     color: Colors.black54, // Ajout d'un fond pour la lisibilité
            //     borderRadius: BorderRadius.circular(8),
            //   ),
            //   // child: const Text(
            //   //   "4", // Remplace par la vraie valeur si nécessaire
            //   //   textAlign: TextAlign.center,
            //   //   style: TextStyle(
            //   //     fontSize: 14,
            //   //     fontWeight: FontWeight.bold,
            //   //     color: Colors.white,
            //   //   ),
            //   // ),
            // ),
            const SizedBox(height: 15),
            
          ],
        ),
      ),
    );
  }
}
