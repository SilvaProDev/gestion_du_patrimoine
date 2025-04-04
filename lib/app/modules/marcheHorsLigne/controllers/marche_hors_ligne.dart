import 'dart:convert';

import 'package:gestion_patrimoine_dcf/app/constants/constants.dart';
import 'package:gestion_patrimoine_dcf/app/modules/auth/controllers/authentification.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

import '../../../database/database_helper.dart';
import '../../marche/models/marche_model.dart';

class MarcheControllerHorsLigne extends GetxController {
  AuthentificationController _authentificationController =
      Get.find<AuthentificationController>();
  final box = GetStorage();
  final isLoading = false.obs;
  String token = '';
  var query = ''.obs;
  var listeMarche = <MarcheModel>[].obs; // Modèle Marché observable
  var filterMarche = <MarcheModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    filterMarche.value =
        listeMarche; // Initialiser la liste filtrée avec tous les dossiers
  }

//Fontion de recherche des dossiers
  void searchMarche(String query) {
    if (query.isEmpty) {
      filterMarche.value = listeMarche;
    } else {
      filterMarche.value = listeMarche
          .where((dossier) =>
              dossier.libelleMarche!
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              dossier.montantMarche!.toString().contains(query.toLowerCase()))
          .toList();
    }
  }

  // Récupérer la liste des marchés en fonction d'un activiteId
  List<MarcheModel> getMarcheParActivite(int activiteId) {
    return listeMarche
        .where((marche) => marche.activiteId == activiteId)
        .toList();
  }

  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  Future<void> loadMarcheFromDatabase(int activiteId) async {
    isLoading.value = true;
    try {
      var listeMarches = await _dbHelper.getMarchesByActiviteId(activiteId);

      if (listeMarches.isNotEmpty) {
        listeMarche.value = listeMarches;
        filterMarche.value = listeMarches;
      } else {
        print(" Aucun marché trouvé pour activiteId = $activiteId");
      }
    } catch (e) {
      print(" Error loading activities from database: $e");
    } finally {
      isLoading.value = false;
    }
  }

  //
  Future<void> getListeMarcheParApi() async {
    try {
      isLoading.value = true;
      var uri = Uri.parse('$url/listeDesMarcheHorsSigobeParApi');
      print(uri);
      final response = await http.get(
        uri,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${_authentificationController.token}'
        },
      );

      //Vérifie la reponse de la requete
      if (response.statusCode == 200) {
        final jsonData =
            (json.decode(response.body))['marches'] as List<dynamic>;
        listeMarche.value =
            jsonData.map((data) => MarcheModel.fromJson(data)).toList();
        print(listeMarche.first.libelleMarche);
      } else {
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
      e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
