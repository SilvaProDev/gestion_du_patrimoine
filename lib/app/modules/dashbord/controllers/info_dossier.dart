import 'dart:convert';
import 'package:gestion_patrimoine_dcf/app/modules/auth/controllers/authentification.dart';
import 'package:gestion_patrimoine_dcf/app/modules/marche/models/activite_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

import '../../../constants/constants.dart';
import '../models/type_dossier_model.dart';

class InfoDossierController extends GetxController {
  final AuthentificationController _authentificationController =
      Get.put(AuthentificationController());
  var dossiers = <TypeDossierModel>[].obs;
  var filterDossiers = <TypeDossierModel>[].obs;

  var filterActivite = <ActiviteModel>[].obs;
  var liste_activite_sigobe = <ActiviteModel>[].obs;
  var liste_activite = <ActiviteModel>[].obs;

  final box = GetStorage();
  final isLoadingSigobe = false.obs;
  final isLoading = false.obs;
  var query = ''.obs;
  var codeEthique = ''.obs;

  @override
  void onInit() {
    super.onInit();
    filterDossiers.value =
        dossiers; // Initialiser la liste filtrée avec tous les dossiers
    filterActivite.value =
        liste_activite; // Initialiser la liste filtrée avec toutes les activités
  }

//Fontion de recherche des dossiers
  void searchDossier(String query) {
    if (query.isEmpty) {
      filterDossiers.value = dossiers;
    } else {
      filterDossiers.value = dossiers
          .where((dossier) =>
              dossier.libelle!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

//Fontion de recherche des activités
  void searchActivite(String query) {
    if (query.isEmpty) {
      filterActivite.value = liste_activite;
    } else {
      filterActivite.value = liste_activite
          .where((activite) => activite.libelleActivite!
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    }
  }

//Récupère la liste des types de dossiers
  Future<void> getValeur() async {
    try {
      isLoading.value = true;
      //envoie une requete au back
      final uri = Uri.parse('$baseCodeEthique/valeur-semaine/?format=json');
      print(uri);
      var response = await http.get(
        uri,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${_authentificationController.token}'
        },
      );
      //Vérifie la reponse de la requete
      if (response.statusCode == 200) {
        isLoading.value = false;
        String jsonData = (json.decode(response.body))['valeur'];
        codeEthique.value = jsonData;
        print(jsonData);
      }
    } catch (e) {
      isLoading.value = false;
    }
  }

//Récupère la liste des types de dossiers
  Future<void> getAllTypeDossier() async {
    try {
      isLoading.value = true;
      //envoie une requete au back
      var response = await http.get(
        Uri.parse('$url/listeTypeDossier'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${_authentificationController.token}'
        },
      );
      //Vérifie la reponse de la requete
      if (response.statusCode == 200) {
        isLoading.value = false;
        List<dynamic> jsonData = (json.decode(response.body))['dossiers'];
        dossiers.value =
            jsonData.map((data) => TypeDossierModel.fromJson(data)).toList();
      }
    } catch (e) {
      isLoading.value = false;
    }
  }

  //Recupère la liste des activités des marchés sigobe
  Future<void> getActiviteMarcheSigobe() async {
    try {
      isLoadingSigobe.value = true;
      final uri = Uri.parse('$url/listeDesActiviteDuMarcheSigobe');
      // Envoyer la requête GET
      final response = await http.get(
        uri,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${_authentificationController.token}'
        },
      );
      //verifie la reponse
      if (response.statusCode == 200) {
        isLoadingSigobe.value = false;
        List<dynamic> jsonData = (json.decode(response.body))['activites'];
        liste_activite_sigobe.value =
            jsonData.map((data) => ActiviteModel.fromJson(data)).toList();
      } else {
        throw ("Message error");
      }
    } catch (e) {
      isLoadingSigobe.value = false;
    }
  }

  //Recupère la liste des activités des marchés hors sigobe
  Future<void> getActiviteMarcheHorsSigobe() async {
    try {
      isLoading.value = true;
      final uri = Uri.parse('$url/listeDesActiviteDuMarcheHorsSigobe');
      // Envoyer la requête GET
      final response = await http.get(
        uri,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${_authentificationController.token}'
        },
      );
      //verifie la reponse
      if (response.statusCode == 200) {
        isLoading.value = false;
        List<dynamic> jsonData = (json.decode(response.body))['activites'];
        liste_activite.value =
            jsonData.map((data) => ActiviteModel.fromJson(data)).toList();
      } else {
        throw ("Message error");
      }
    } catch (e) {
      isLoading.value = false;
    }
  }
}
