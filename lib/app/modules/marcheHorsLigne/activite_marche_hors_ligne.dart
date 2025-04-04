import 'package:flutter/material.dart';
import 'package:gestion_patrimoine_dcf/app/modules/dashbord/controllers/info_dossier.dart';
import 'package:gestion_patrimoine_dcf/app/modules/marche/views/marche_hors_sigobe.dart';
import 'package:gestion_patrimoine_dcf/app/modules/marche/views/marche_sigobe.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'controllers/activite_hors_ligne.dart';
import 'views/activite_hors_sig_hors_ligne.dart';

// import '../../../marche/views/marche_sigobe.dart';

class ListeActiviteMarcheHorsLigne extends StatefulWidget {
  const ListeActiviteMarcheHorsLigne({super.key});

  @override
  State<ListeActiviteMarcheHorsLigne> createState() =>
      _ListeActiviteMarcheHorsLigneState();
}

class _ListeActiviteMarcheHorsLigneState
    extends State<ListeActiviteMarcheHorsLigne> {
  final TextEditingController _searchController = TextEditingController();
  final ActiviteHorsLigneController _activiteHorsLigneController =
      Get.put(ActiviteHorsLigneController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _activiteHorsLigneController.loadActivitesFromDatabase();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isSearchCliked = true;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 10),
            child: Container(
              height: 40,
              width: 300,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: TextField(
                onChanged: (value) {
                  _activiteHorsLigneController.query.value = value;
                  _activiteHorsLigneController.searchActivite(value);
                },
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(16, 20, 16, 12),
                    hintStyle: TextStyle(color: Colors.black),
                    border: InputBorder.none,
                    hintText: 'Recherche par code, libellé'),
              ),
            ),
          ),
          backgroundColor: Colors.blue,
          bottom: const TabBar(
            labelColor: Colors.white,
            labelStyle: TextStyle(
              fontSize: 20,
            ),
            tabs: [
              Tab(
                text: 'Sigobe',
              ),
              Tab(
                text: 'hors-Sigobe',
              ),
            ],
          ),
        ),
        // drawer: MyDrawer(),
        body: TabBarView(children: [
          Obx(() {
            return _activiteHorsLigneController.isLoadingSigobe.value
                ? Center(child: CircularProgressIndicator())
                : _activiteHorsLigneController.liste_activite.isNotEmpty
                    ? ListView.builder(
                        itemCount: _activiteHorsLigneController
                            .liste_activite_sigobe.length,
                        itemBuilder: (context, index) {
                          return MarcheSigobe(
                            activites: _activiteHorsLigneController
                                .liste_activite_sigobe[index],
                          );
                        })
                    : Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Aucune donnée chargée..."),
                            TextButton(
                              onPressed: () async {
                                await _activiteHorsLigneController
                                    .loadActivitesFromDatabase();
                                setState(() {});
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.lightBlueAccent,
                              ),
                              child: const Text("Actualiser"),
                            ),
                          ],
                        ),
                      );
          }),
          Obx(() {
            return _activiteHorsLigneController.isLoading.value
                ? Center(child: CircularProgressIndicator())
                : _activiteHorsLigneController.filterActivite.isNotEmpty
                    ? ListView.builder(
                        itemCount:
                            _activiteHorsLigneController.filterActivite.length,
                        itemBuilder: (context, index) {
                          return AfficheActiviteHorsLigne(
                              activites: _activiteHorsLigneController
                                  .filterActivite[index]);
                        })
                    : const Text('Encours ...');
          }),
        ]),
      ),
    );
  }
}
