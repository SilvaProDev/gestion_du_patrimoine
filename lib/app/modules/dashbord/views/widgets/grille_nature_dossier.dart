import 'package:flutter/material.dart';

import '../../models/type_dossier_model.dart';

class GrilleNatureDossier extends StatelessWidget {
  final backgroundColor;
  final icon;
  final TypeDossierModel typeDossier;
  GrilleNatureDossier({
    super.key,
    required this.backgroundColor,
    required this.icon,
    required this.typeDossier,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: backgroundColor,
            boxShadow: [
              BoxShadow(color: Colors.black12, spreadRadius: 2, blurRadius: 16)
            ]),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Icon(icon),
            Container(
              padding: EdgeInsets.all(8),
              child: Text(
                textAlign: TextAlign.center,
                "${typeDossier.libelle}",
                style: TextStyle(
                  
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "${typeDossier.nbreDossier}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            )
          ],
        ),
      ),
      onTap: () {
        print("hello silva");
      },
    );
  }
}
