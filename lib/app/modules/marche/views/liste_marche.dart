import 'package:flutter/material.dart';
import 'package:gestion_patrimoine_dcf/app/modules/marche/controllers/marche_controller.dart';
import 'package:gestion_patrimoine_dcf/app/modules/marche/views/widgets/info_marche.dart';
import 'package:gestion_patrimoine_dcf/app/pages/widgets/loader.dart';
import 'package:get/get.dart';

class ListeMarche extends StatefulWidget {
  final int activite_id;
  final int? nbre;
  ListeMarche({super.key, required this.activite_id, this.nbre});

  @override
  State<ListeMarche> createState() => _ListeMarcheState();
}

class _ListeMarcheState extends State<ListeMarche> {
  final MarcheController _marcheController = Get.put(MarcheController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _marcheController.getMarcheParActivite(widget.activite_id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[800],
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Liste des marchés par activité',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 10, top: 20),
              child: Column(
                children: [
                  Obx(() => Column(
                        children: [
                          Text( _marcheController.filterMarche.isNotEmpty?
                             _marcheController.filterMarche.first.libelleActivite!
                              : 'Aucune activité' ,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Total: ${_marcheController.filterMarche.length}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      )),
                  SizedBox(height: 20),
                   Container(
                                height: 40,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: TextField(
                                  onChanged: (value) {
                                      _marcheController.query.value = value;
                                      _marcheController.searchMarche(value);
                                    },
                                  decoration: InputDecoration(
                                      icon: Icon(Icons.search),
                                      contentPadding:
                                          EdgeInsets.fromLTRB(0, 20, 16, 10),
                                      hintStyle: TextStyle(color: Colors.black),
                                      border: InputBorder.none,
                                      hintText: 'Recherche...'),
                                ),
                              ),
                              SizedBox(height: 25),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                color: Colors.grey[200],
                child: Center(
                  child: Obx(() {
                    if (_marcheController.isLoading.value) {
                      return DymaLoader();
                    } else if (_marcheController.filterMarche.isNotEmpty) {
                      return ListView.builder(
                        itemCount: _marcheController.filterMarche.length,
                        itemBuilder: (context, index) {
                          return InfoMarche(
                            nbre: index,
                            marche:
                                _marcheController.filterMarche[index],
                          );
                        },
                      );
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Aucune donnée chargée..."),
                          TextButton(
                            onPressed: () {
                              _marcheController
                                  .getMarcheParActivite(widget.activite_id);
                            },
                            style: TextButton.styleFrom(
                                foregroundColor: Colors.lightBlueAccent,
                                backgroundColor: Colors.grey[100]),
                            child: const Text("Actualiser"),
                          ),
                        ],
                      );
                    }
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
