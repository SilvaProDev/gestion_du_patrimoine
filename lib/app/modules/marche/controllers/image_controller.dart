import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gestion_patrimoine_dcf/app/constants/constants.dart' as apiUrl;
import 'package:gestion_patrimoine_dcf/app/modules/marche/views/widgets/image_marche.dart';
import 'package:gestion_patrimoine_dcf/app/modules/marche/views/widgets/image_upload.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';

import '../../auth/controllers/authentification.dart';
import '../models/image_marche.dart';

class ImageController extends GetxController {
  AuthentificationController _authentificationController =
      Get.find<AuthentificationController>();
  final box = GetStorage();
  final isLoading = false.obs;
  String token = '';
  var imageMarche = <ImageMarcheModel>[].obs;

  final ImagePicker _picker = ImagePicker();
  List<XFile>? images = [];
  List<String>? listeImagePath = [];
  // var marcheId  = 0.obs;
  var selectFileCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void selectMultipleImage() async {
    images = await _picker.pickMultiImage();
    if (images != null) {
      for (XFile file in images!) {
        listeImagePath?.add(file.path);
      }
    } else {
      Get.snackbar('Fail', 'Pas d image selectionné',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }

    selectFileCount.value = listeImagePath!.length;
  }

  //
  Future<void> uploadImages(int? marcheId, String? longitude, String? latitude,
      String? observation) async {
    if (selectFileCount.value > 0) {
      // Afficher un loader
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      try {
        final resp = await ImageUploadFile().uploadImage(
            listeImagePath!, marcheId, longitude, latitude, observation);

        Get.back(); // Fermer le loader

        if (resp == 'success') {
          Get.snackbar(
            'Succès',
            'Images téléchargées avec succès',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );

          // Réinitialisation après succès
          images = [];
          listeImagePath = [];
          selectFileCount.value = listeImagePath!.length;
        } else {
          throw "Échec de l'upload";
        }
      } catch (error) {
        Get.back;
        print(error); // Fermer le loader en cas d'erreur
        Get.snackbar(
          'Erreur',
          'Une erreur est survenue : $error',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } else {
      Get.snackbar(
        'Erreur',
        'Aucune image sélectionnée',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<String> uploadImage(File pickedImage, int? marcheId) async {
    try {
      var request =
          http.MultipartRequest("POST", Uri.http('/api/activity/image'));
      request.files.add(
        http.MultipartFile.fromBytes(
          'activity',
          pickedImage.readAsBytesSync(),
          filename: basename(pickedImage.path),
          contentType: MediaType("multipart", "form-data"),
        ),
      );
      var response = await request.send();
      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        return json.decode(responseData);
      } else {
        throw 'error';
      }
    } catch (e) {
      rethrow;
    }
  }

//Recupère la liste des images d' un marché
  Future getImageParMarche(int marche_id) async {
    try {
      isLoading.value = true;
      var uri = Uri.parse('${apiUrl.url}/listeImageParMarche/$marche_id');
      print(uri);
      final response = await http.get(
        uri,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${_authentificationController.token}'
        },
      );
      //recupère la reponse de l utilisateur
      if (response.statusCode == 200) {
        final jsonData =
            (json.decode(response.body))['images'] as List<dynamic>;
        imageMarche.value =
            jsonData.map((data) => ImageMarcheModel.fromJson(data)).toList();
        isLoading.value = false;
        print(imageMarche);
      } else {
        isLoading.value = false;
      }
    } catch (e) {
      return e.toString();
    }
  }
}
