import 'dart:convert';

import 'package:gestion_patrimoine_dcf/app/constants/constants.dart';
import 'package:gestion_patrimoine_dcf/app/modules/auth/controllers/authentification.dart';
import 'package:gestion_patrimoine_dcf/app/modules/cartographie/models/departement.dart';
import 'package:gestion_patrimoine_dcf/app/modules/cartographie/models/image_marche_carto.dart';
import 'package:gestion_patrimoine_dcf/app/modules/cartographie/models/unite_operationnelle.dart';
import 'package:gestion_patrimoine_dcf/app/modules/suivi_matiere/models/bien_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

import '../models/activite.dart';
import '../models/district.dart';
import '../models/marche_cartographie.dart';
import '../models/region.dart';
import '../models/sections.dart';
import '../models/sous_prefecture.dart';
import '../models/village.dart';

class CartographieController extends GetxController {
  final AuthentificationController _authentificationController =
      Get.find<AuthentificationController>();
  final box = GetStorage();
  final isLoading = false.obs;
  String token = '';
  var query = ''.obs;
  var listeSections = <SectionModel>[].obs;
  var listeUniteOperationnelle = <UniteOperationnelleModel>[].obs;
  var listeActivite = <ActiviteModel>[].obs;
  var listeDistrict = <DistrictModel>[].obs;
  var listeRegion = <RegionModel>[].obs;
  var listeDepartement = <DepartementModel>[].obs;
  var listeSousPrefecture = <SousPrefectureModel>[].obs;
  var listeVillage = <VillageModel>[].obs;
  var listeMarches = <MarcheCartographieModel>[].obs;
  var listeImagesMarche = <ImageMarcheCartoModel>[].obs;
  var listeImagesMarches = <ImageMarcheCartoModel>[].obs;

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

  Future getListeSection() async {
    try {
      isLoading.value = true;
      var uri = Uri.parse('$url/listeSection');
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
            (json.decode(response.body))['sections'] as List<dynamic>;
        listeSections.value =
            jsonData.map((data) => SectionModel.fromJson(data)).toList();
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

  Future getUoParSection(sectionId) async {
    try {
      isLoading.value = true;
      var uri = Uri.parse('$url/listeUniteOperationnelle/$sectionId');
      final response = await http.get(
        uri,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${_authentificationController.token}'
        },
      );

      //Vérifie la reponse de la requete
      if (response.statusCode == 200) {
        final jsonData = (json.decode(response.body))['unite_operationnelle']
            as List<dynamic>;
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

  Future getActiviteParUo(uoId) async {
    try {
      isLoading.value = true;
      var uri = Uri.parse('$url/listeActivite/$uoId');
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
            (json.decode(response.body))['activites'] as List<dynamic>;
        listeActivite.value =
            jsonData.map((data) => ActiviteModel.fromJson(data)).toList();
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

  Future getDistrictParActivite(activiteId) async {
    try {
      isLoading.value = true;
      var uri = Uri.parse('$url/listeDistrict/$activiteId');
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
            (json.decode(response.body))['districts'] as List<dynamic>;
        listeDistrict.value =
            jsonData.map((data) => DistrictModel.fromJson(data)).toList();
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

  Future getRegionParDistrict(districtId) async {
    try {
      isLoading.value = true;
      var uri = Uri.parse('$url/listeRegion/$districtId');
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
            (json.decode(response.body))['regions'] as List<dynamic>;
        listeRegion.value =
            jsonData.map((data) => RegionModel.fromJson(data)).toList();
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

  Future getDepartementParRegion(regionId) async {
    try {
      isLoading.value = true;
      var uri = Uri.parse('$url/listeDepartement/$regionId');
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
            (json.decode(response.body))['departements'] as List<dynamic>;
        listeDepartement.value =
            jsonData.map((data) => DepartementModel.fromJson(data)).toList();
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

  Future getSousPrefectureParDepartement(departementId) async {
    try {
      isLoading.value = true;
      var uri = Uri.parse('$url/listeSousPrefecture/$departementId');
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
            (json.decode(response.body))['sous_prefectures'] as List<dynamic>;
        listeSousPrefecture.value =
            jsonData.map((data) => SousPrefectureModel.fromJson(data)).toList();
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

  Future getVillageParSousPrefecture(sousPrefectureId) async {
    try {
      isLoading.value = true;
      var uri = Uri.parse('$url/listeVillages/$sousPrefectureId');
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
            (json.decode(response.body))['villages'] as List<dynamic>;
        listeVillage.value =
            jsonData.map((data) => VillageModel.fromJson(data)).toList();
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

  Future getListeMarche(sousPrefectureId) async {
    try {
      isLoading.value = true;
      var uri = Uri.parse('$url/listeDesMarches/$sousPrefectureId');
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
        listeMarches.value = jsonData
            .map((data) => MarcheCartographieModel.fromJson(data))
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

  Future getImagesParMarche(marcheId) async {
    try {
      isLoading.value = true;
      var uri = Uri.parse('$url/imagesMarche/$marcheId');
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
            (json.decode(response.body))['images'] as List<dynamic>;
        listeImagesMarche.value = jsonData
            .map((data) => ImageMarcheCartoModel.fromJson(data))
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

  Future getListeImagesParMarche() async {
    try {
      isLoading.value = true;
      var uri = Uri.parse('$url/listeimagesMarche');
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
            (json.decode(response.body))['images'] as List<dynamic>;
        listeImagesMarches.value = jsonData
            .map((data) => ImageMarcheCartoModel.fromJson(data))
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
}
