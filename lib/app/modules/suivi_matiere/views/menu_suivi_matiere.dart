import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'inventaire/suivi_matiere_inventaire_view.dart';

class MenuSuiviMatiere extends StatefulWidget {
  final Color? backgroundColor;
  final  icon;
  final String libelle;
  final int numero;
  MenuSuiviMatiere({
    super.key,
     this.backgroundColor,
     this.icon,
    required this.libelle,
    required this.numero,
  });

  @override
  State<MenuSuiviMatiere> createState() => _MenuSuiviMatiereState();
}

class _MenuSuiviMatiereState extends State<MenuSuiviMatiere> {
  int _currentIndex = 0; // Index de l'élément sélectionné

  void _changerPage(int index) {
    setState(() {
      _currentIndex = index; // Mettre à jour l'index sélectionné
    });
    // Ajouter une action spécifique si nécessaire
    switch (index) {
      case 0:
      Get.to(() => SuiviMatiereInventaireView());
        break;
      case 1:
      // Get.to(() => InventaireView());
        break;
     
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        color: Colors.grey.shade300,
       
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
       
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Icon(widget.icon as IconData?, size: 65,),
            SizedBox(
              height: 15,
            ),
            Text(
              "${widget.libelle}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                 fontSize: 17),
            )
          ],
        ),
      ),
      onTap: () {
        print(widget.numero);
        _changerPage(widget.numero);
      },
    );
  }
}
