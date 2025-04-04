import 'package:flutter/material.dart';
import 'package:gestion_patrimoine_dcf/app/modules/dashbord/views/home/liste_activite.dart';
import 'package:get/get.dart';

import '../../../cartographie/views/home_cartographie.dart';
import '../../../marcheHorsLigne/activite_marche_hors_ligne.dart';
import '../../../suivi_matiere/views/acceuil_suivi_matiere.dart';


class ListeModule extends StatefulWidget {
  final backgroundColor;
  final icon;
  final String libelle;
  final int numero;
  ListeModule({
    super.key,
    required this.backgroundColor,
    required this.icon,
    required this.libelle,
    required this.numero,
  });

  @override
  State<ListeModule> createState() => _ListeModuleState();
}

class _ListeModuleState extends State<ListeModule> {
  int _currentIndex = 0; // Index de l'élément sélectionné

  void _changerPage(int index) {
    setState(() {
      _currentIndex = index; // Mettre à jour l'index sélectionné
    });
    // Ajouter une action spécifique si nécessaire
    switch (index) {
      case 0:
        Get.to(() => ListeActivite()); // Utilisation de GetX pour la navigation
        break;
      case 2:
      Get.to(() => AccueilSuiviMatiere());
        break;
      case 3:
      Get.to(() => MapScreen());
        break;
      case 4:
      Get.to(() => ListeActiviteMarcheHorsLigne());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: widget.backgroundColor,
            boxShadow: [
              BoxShadow(color: Colors.black12, spreadRadius: 2, blurRadius: 16)
            ]),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Icon(widget.icon, size: 65,),
            SizedBox(
              height: 15,
            ),
            Text(
              "${widget.libelle}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
