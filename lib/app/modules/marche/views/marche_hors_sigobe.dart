import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/activite_model.dart';
import 'liste_marche.dart';

class MarcheHorsSigobe extends StatelessWidget {
  ActiviteModel activites;
  MarcheHorsSigobe({super.key, required this.activites});

  @override
  Widget build(BuildContext context) {
    return Column(
          children: [
            ListTile(
              leading: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 30,
                  minHeight: 30,
                  maxWidth: 35,
                  maxHeight: 35,
                ),
                child: Image.asset("assets/images/image_sidcf.jpg",
                    fit: BoxFit.cover,
                    height: 280,),
              ),
              title: Text('${activites.libelleActivite}',
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),
              ),
              subtitle: Text('Marchés: ${activites.nbreMarche}',
              style: GoogleFonts.poppins(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              fontSize: 14)
              ),
              onTap: () {
               Get.to(() => ListeMarche(
                          activite_id: activites.activiteId!,
                          
                        ));
              },
            ),
            Divider(
              color: Colors.black,
            ),
          ],
        );
  }
}
