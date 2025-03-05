import 'package:flutter/material.dart';

import 'inventaire/menu_inventaire_matiere.dart';
import 'menu_suivi_matiere.dart';

class AccueilSuiviMatiere extends StatelessWidget {
  AccueilSuiviMatiere({super.key});

  List<Map<String, dynamic>> listeModule = [
    {"id": 0, "libelle": "INVENTAIRE"},
    {"id": 1, "libelle": "REPARATION"},
  
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[800],
        appBar: AppBar(
          backgroundColor: Colors.blue[800],
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SafeArea(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 10, top: 25),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "SUIVI DES MATIERES",
                            style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              
              child: Expanded(
                
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  padding: EdgeInsets.all(25.0),
                  // color: Colors.grey[100],
                  child: Center(
                    child: Column(
                      children: [
                        //exercice
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Liste des modules",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        //List view
                        Expanded(
                            child: GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 1.1,
                                        mainAxisSpacing: 8),
                                itemCount: listeModule.length,
                                itemBuilder: (context, index) {
                                  return MenuSuiviMatiere(
                                    numero: index,
                                    icon: index==0 ?Icons.inventory_outlined
                                        :Icons.car_repair_outlined,
                                    backgroundColor: index == 1
                                        ? Colors.blue[200]
                                        : index == 2
                                            ? Colors.red[90]
                                            : Colors.green[200],
                                    libelle: listeModule[index]["libelle"],
                                  );
                                }))
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        )));
  }
}
