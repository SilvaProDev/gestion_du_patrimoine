import 'dart:convert';
import 'dart:io';

import 'package:gestion_patrimoine_dcf/app/constants/constants.dart';
import 'package:gestion_patrimoine_dcf/app/modules/auth/controllers/authentification.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

import '../models/marche_model.dart';

class MarcheController extends GetxController {
  AuthentificationController _authentificationController =
      Get.find<AuthentificationController>();
  final box = GetStorage();
  final isLoading = false.obs;
  String token = '';
  var query = ''.obs;
  var marcheParActivite = <MarcheModel>[].obs; // Modèle Marché observable
  var filterMarche = <MarcheModel>[].obs;

@override
  void onInit() {
    super.onInit();
    filterMarche.value = marcheParActivite; // Initialiser la liste filtrée avec tous les dossiers
  }

//Fontion de recherche des dossiers
  void searchMarche(String query) {
    if (query.isEmpty) {
      filterMarche.value = marcheParActivite;
    } else {
      filterMarche.value = marcheParActivite
          .where((dossier) =>
              dossier.libelleMarche!.toLowerCase().contains(query.toLowerCase())
              ||
              dossier.montantMarche!.toString().contains(query.toLowerCase())
              )
          .toList();
    }
  }
  //
  Future getMarcheParActivite(activiteId) async {
    try {
      isLoading.value = true;
      var uri =
          Uri.parse('$url/listeDesMarcheHorsSigobeParActivite/$activiteId');
      // print(uri);
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
        marcheParActivite.value =
            jsonData.map((data) => MarcheModel.fromJson(data)).toList();
        // for (var item in jsonData) {
        //   marches_par_activite.add(MarcheModel.fromJson(item));
        // }
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

  // Future<String> uploadImage(File pickedImage) async {
  //   try {
  //     var request =
  //         http.MultipartRequest("POST", Uri.http(url, '/api/activity/image'));
  //     request.files.add(
  //       http.MultipartFile.fromBytes(
  //         'activity',
  //         pickedImage.readAsBytesSync(),
  //         filename: basename(pickedImage.path),
  //         contentType: MediaType("multipart", "form-data"),
  //       ),
  //     );
  //     var response = await request.send();
  //     if (response.statusCode == 200) {
  //       var responseData = await response.stream.bytesToString();
  //       return json.decode(responseData);
  //     } else {
  //       throw 'error';
  //     }
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
