import 'package:flutter/material.dart';
import 'package:gestion_patrimoine_dcf/app/modules/dashbord/models/type_dossier_model.dart';

class ListeNatureDossier extends StatelessWidget {
  final icon;
  final TypeDossierModel typeDossier;
  final color;
  ListeNatureDossier(
      {super.key,
      required this.icon,
      required this.typeDossier,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("mes dossier");
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 12),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            width: 420,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.greenAccent.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            child: Icon(
                              icon,
                            ),
                            padding: EdgeInsets.all(10),
                            color: color,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              typeDossier.libelle!,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${typeDossier.nbreDossier}',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Column(
                //       children: [Text("Non traité"), Text("2")],
                //     ),
                //     Column(
                //       children: [Text("Traité"), Text("2")],
                //     ),
                //     Column(
                //       children: [Text("Visé"), Text("9")],
                //     ),
                //     Column(
                //       children: [Text("Différé"), Text("5")],
                //     ),
                //     Column(
                //       children: [Text("Réjété"), Text("8")],
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
