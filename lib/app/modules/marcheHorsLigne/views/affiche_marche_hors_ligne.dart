import 'package:flutter/material.dart';
import 'package:gestion_patrimoine_dcf/app/modules/marche/models/marche_model.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'detail_marche_hors_ligne.dart';


class AfficheMarcheHorsLigne extends StatelessWidget {
  MarcheModel marche;
  final int nbre;
  AfficheMarcheHorsLigne({super.key, required this.marche, required this.nbre});
 
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Column(
        children: [
          Container(
            child: ListTile(
              
              leading: CircleAvatar(
                backgroundColor: Colors.grey[200],
                child: Text('${nbre+1}',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue[400]
                ),
                ),
              ),
              title: Text('${marche.libelleMarche}',
                  style: GoogleFonts.roboto(
                      
                      fontSize: 12)),
              subtitle: Row(
                children: [
                  Text('Mont:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),
                  ),
                  Text('${marche.montantMarche}',
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue, 
                      fontSize: 14)),
                  SizedBox(width: 8,),
                  Text('Procedure:',
                   style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),
                  ),
                  Expanded(
                    child: Container(
                      child: Text('${marche.libelleProcedure}',
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue, 
                          fontSize: 14)
                          ),
                    ),
                  )
                ],
              ),
              onTap: () {
                Get.to( DetailMarcheHorsLigne(), arguments: {
                  'marcheId':marche.id,
                  'libelleMarche':marche.libelleMarche,
                  'montantMarche':marche.montantMarche
                });
              },
            ),
          ),
          // Divider(
          //   color: Colors.black,
          // ),
        ],
      ),
    );
  }
}
