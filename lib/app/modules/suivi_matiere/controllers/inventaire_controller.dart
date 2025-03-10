import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gestion_patrimoine_dcf/app/constants/constants.dart';
import 'package:gestion_patrimoine_dcf/app/modules/auth/controllers/authentification.dart';
import 'package:gestion_patrimoine_dcf/app/modules/suivi_matiere/models/article_model.dart';
import 'package:gestion_patrimoine_dcf/app/modules/suivi_matiere/models/bien_model.dart';
import 'package:gestion_patrimoine_dcf/app/modules/suivi_matiere/models/nature_model.dart';
import 'package:gestion_patrimoine_dcf/app/modules/suivi_matiere/models/uo_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

import '../models/modele_model.dart';
import '../models/servicecf_model.dart';

class InventaireController extends GetxController {
  final AuthentificationController _authentificationController =
      Get.find<AuthentificationController>();
  final box = GetStorage();
  final isLoading = false.obs;
  String token = '';
  var query = ''.obs;
  var listeUniteOperationnelle =
      <UniteOperationnelleModel>[].obs; // Modèle Marché observable
  var listeNatureEconomique = <NatureEconomiqueModel>[].obs;
  var listeArticle = <ArticleModel>[].obs;
  var listeModeleArticle = <ModeleArticleModel>[].obs;
  var listeServiceCf = <SeriviceCfModel>[].obs;
  var listeDesBiens = <BienModel>[].obs;
  var filterBien = <BienModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    filterBien.value =
        listeDesBiens; // Initialiser la liste filtrée avec tous les dossiers
  }

//Fontion de recherche des dossiers
  void searchBien(String query) {
    if (query.isEmpty) {
      filterBien.value = listeDesBiens;
    } else {
      filterBien.value = listeDesBiens
          .where((dossier) =>
              dossier.libelleBien!
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              dossier.numeroSerie!.toString().contains(query.toLowerCase()))
          .toList();
    }
  }

//Fonction qui permet d enregistrer un inventaire
  Future registerInventor({
    required int uaId,
    required int economiqueId,
    required int articleId,
    required int modeleId,
    required int serviceId,
    required String quantite,
    required String couleur,
    required String numeroSerie,
    required String infoComplementaire,
  }) async {
    try {
      isLoading.value = true;
      var data = {
        'uaId': uaId,
        'economiqueId': economiqueId,
        'couleur': couleur,
        'quantite': quantite,
        'articleId': articleId,
        'modeleId': modeleId,
        'serviceId': serviceId,
        'numeroSerie': numeroSerie,
        'infoComplementaire': infoComplementaire,
      };
      final uri = Uri.parse('$url/register_inventor');
      var response = await http.post(uri,
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${_authentificationController.token}'
          },
          body: jsonEncode(data));
      if (response.statusCode == 201) {
        isLoading.value = false;
        Get.snackbar("Enregistrer", "Enregistrement effectué avec succès",
            colorText: Colors.white,
            backgroundColor: Colors.green,
            snackPosition: SnackPosition.TOP,
            borderRadius: 20,
            margin: EdgeInsets.all(5));
        Duration(seconds: 3);
      } else {
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }

  Future getListeService() async {
    try {
      isLoading.value = true;
      var uri = Uri.parse('$url/listeServiceCf');
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
            (json.decode(response.body))['services'] as List<dynamic>;
        listeServiceCf.value =
            jsonData.map((data) => SeriviceCfModel.fromJson(data)).toList();
      } else {
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
      e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future getListeBien() async {
    try {
      isLoading.value = true;
      var uri = Uri.parse('$url/listeArticleInventaire');
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
            (json.decode(response.body))['listeInventaire'] as List<dynamic>;
        listeDesBiens.value =
            jsonData.map((data) => BienModel.fromJson(data)).toList();
        print(listeDesBiens[0].couleur);
      } else {
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
      e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future getListeUoParService() async {
    try {
      isLoading.value = true;
      var uri = Uri.parse('$url/listeUoParService');
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
            (json.decode(response.body))['listeUo'] as List<dynamic>;
        listeUniteOperationnelle.value = jsonData
            .map((data) => UniteOperationnelleModel.fromJson(data))
            .toList();
      } else {
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
      e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future getLigneEconomiqueClasse2() async {
    try {
      isLoading.value = true;
      var uri = Uri.parse('$url/ligneEconomiqueClasse2');
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
            (json.decode(response.body))['natureEconomique'] as List<dynamic>;
        listeNatureEconomique.value = jsonData
            .map((data) => NatureEconomiqueModel.fromJson(data))
            .toList();
      } else {
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
      e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future getArticle() async {
    try {
      isLoading.value = true;
      var uri = Uri.parse('$url/listeArticles');
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
            (json.decode(response.body))['articles'] as List<dynamic>;
        listeArticle.value =
            jsonData.map((data) => ArticleModel.fromJson(data)).toList();
      } else {
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
      e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future getModeles() async {
    try {
      isLoading.value = true;
      var uri = Uri.parse('$url/listeDesModeles');
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
            (json.decode(response.body))['modeles'] as List<dynamic>;
        listeModeleArticle.value =
            jsonData.map((data) => ModeleArticleModel.fromJson(data)).toList();
        // print(jsonData);
      } else {
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
      e.toString();
    } finally {
      isLoading.value = false;
    }
  }

 
}
