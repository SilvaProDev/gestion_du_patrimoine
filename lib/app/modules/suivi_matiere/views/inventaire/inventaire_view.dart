import 'package:flutter/material.dart';
import 'package:gestion_patrimoine_dcf/app/modules/suivi_matiere/controllers/inventaire_controller.dart';
// import 'package:gestion_patrimoine_dcf/app/modules/suivi_matiere/views/iventaire/inventaire_form.dart';
import 'package:gestion_patrimoine_dcf/app/modules/suivi_matiere/views/inventaire/widgets/liste_bien.dart';
import 'package:gestion_patrimoine_dcf/app/pages/widgets/loader.dart';
import 'package:get/get.dart';

class InventaireView extends StatefulWidget {
 
  InventaireView({super.key});

  @override
  State<InventaireView> createState() => _InventaireViewState();
}

class _InventaireViewState extends State<InventaireView> {
  final InventaireController _inventaireController = Get.put(InventaireController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _inventaireController.getListeBien();
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
        centerTitle: true,
        title: Text(
          'Liste des biens',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        // actions: <Widget>[
        //   IconButton(
        //       icon: const Icon(
        //         Icons.add,
        //         color: Colors.white,
        //       ),
        //       onPressed: () {
        //         Get.to(InventaireForm());
        //       })
        // ],
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
                          
                          Text(
                            'Total: ${_inventaireController.filterBien.length}',
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
                                      _inventaireController.query.value = value;
                                      _inventaireController.searchBien(value);
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
                    if (_inventaireController.isLoading.value) {
                      return DymaLoader();
                    } else if (_inventaireController.filterBien.isNotEmpty) {
                      return ListView.builder(
                        itemCount: _inventaireController.filterBien.length,
                        itemBuilder: (context, index) {
                          return InfoBien(
                            nbre: index,
                            bien:
                                _inventaireController.filterBien[index],
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
                              // _inventaireController
                              //     .getMarcheParActivite(widget.activite_id);
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
