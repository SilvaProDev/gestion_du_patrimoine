import 'package:flutter/material.dart';

import '../../../dashbord/views/widgets/liste_module.dart';
import 'menu_inventaire_matiere.dart';

class SuiviMatiereInventaireView extends StatelessWidget {
  SuiviMatiereInventaireView({super.key});

  List<Map<String, dynamic>> listeModule = [
    {"id": 0, "libelle": "Faire un inventaire"},
    {"id": 1, "libelle": "Liste des invenatires"},
    {"id": 2, "libelle": "Scanner Qr"},
    {"id": 3, "libelle": "Catalogue"},
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
                            "INVENTAIRE",
                            style: TextStyle(
                                color: Colors.white,
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
                                  return MenuInventaireMatiere(
                                    numero: index,
                                    icon: index==0 ?Icons.post_add_rounded
                                        :index ==1 ?Icons.list_alt_outlined
                                        :index ==2 ?Icons.qr_code
                                        :Icons.document_scanner_outlined
                                        ,
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
