import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gestion_patrimoine_dcf/app/constants/constants.dart' as apiUrl;
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:path/path.dart' as path;
import 'package:get_storage/get_storage.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants/constants.dart';
import '../../../database/database_helper.dart';
import '../../auth/controllers/authentification.dart';
import '../../marche/models/image_marche.dart';

class ImageControllerHorsLigne extends GetxController {
  final AuthentificationController _authentificationController =
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

  void removeImage(int index) {
    if (index >= 0 && index < listeImagePath!.length) {
      listeImagePath!.removeAt(index);
      selectFileCount.value = listeImagePath!.length;
    }
  }

  Future<void> uploadImageHorsLigne(int? marcheId, String? longitude,
      String? latitude, String? observation) async {
    if (selectFileCount.value > 0) {
      // Afficher un loader
      // Get.dialog(
      //   const Center(child: CircularProgressIndicator()),
      //   barrierDismissible: false,
      // );

      try {
        // Sauvegarde dans SQLite pour synchronisation ultérieure
        for (var path in listeImagePath!) {
          ImageMarcheModel image = ImageMarcheModel(
            longitude: longitude ?? '',
            latitude: latitude ?? '',
            fichier: path, // Stocke le chemin local de l'image
            observation: observation ?? '',
            marcheId: marcheId ?? 0,
          );

          await DatabaseHelper.instance.insertImageMarche(image);
        }
        // Réinitialisation après succès
        images = [];
        listeImagePath = [];
        selectFileCount.value = listeImagePath!.length;
        Get.snackbar(
          'Hors ligne',
          'Images enregistrées localement pour synchronisation ultérieure',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        // Get.back();
      } catch (error) {
        Get.back(); // Fermer le loader en cas d'erreur
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

  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  Future<void> getImagesFromDatabase(int marcheId) async {
    isLoading.value = true;
    try {
      var listeImageMarches = await _dbHelper.getImagesByMarcheId(marcheId);

      if (listeImageMarches.isNotEmpty) {
        imageMarche.value = listeImageMarches;
      } else {
        print(" Aucun marché trouvé pour marcheId = $marcheId");
      }
    } catch (e) {
      print(" Error loading activities from database: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> syncImagesWithServer() async {
  try {
    List<ImageMarcheModel> imagesToSync = await _dbHelper.getUnsyncedImages();

    if (imagesToSync.isEmpty) {
      Get.snackbar(
        'SYNCHRONISATION',
        'Aucune donnée à synchroniser',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.orangeAccent,
        colorText: Colors.white,
      );
      return;
    }

    for (var image in imagesToSync) {
      File imageFile = File(image.fichier);
      var fileName = path.basename(image.fichier);

      if (await imageFile.exists()) {
        int fileSize = await imageFile.length();
        print("📂 Fichier trouvé : ${image.fichier}");
        print("📎 Taille : $fileSize octets");

        var request = http.MultipartRequest('POST', Uri.parse(uploadImageUrl));

        // ✅ Correction : "file" au lieu de "file[]"
        var multipartFile = await http.MultipartFile.fromPath('file', imageFile.path,
        contentType: MediaType('image', 'jpeg'),);
        print("🛠️ Préparation du fichier pour l'upload : ${multipartFile.filename}");
        request.files.add(multipartFile);

        // Ajout des autres champs
        request.fields['marche_id'] = image.marcheId.toString();
        request.fields['longitude'] = image.longitude;
        request.fields['latitude'] = image.latitude;
        request.fields['observation'] = image.observation;

        print("📍 ID marché : ${image.marcheId}");
        print("📝 Observation : ${image.observation}");
        // Ajout des headers (Ne pas forcer Content-Type)
        request.headers['Authorization'] = "Bearer ${_authentificationController.token}";
        request.headers['Accept'] = "application/json";

        var response = await request.send();
        var responseBody = await response.stream.bytesToString();
        print('📡 Réponse du serveur : $responseBody');

        if (response.statusCode == 200) {
          print('✅ Image synchronisée : $fileName');
          await _dbHelper.deleteImage(image.marcheId);
          Get.snackbar(
            'SYNCHRONISATION',
            'Les données ont été synchronisées avec succès',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          imageMarche.value = [];
        } else {
          print('❌ Erreur lors de l\'upload de l\'image: $fileName. Status Code: ${response.statusCode}');
        }
      } else {
        print('🚨 Le fichier $fileName n\'existe pas à l\'emplacement spécifié.');
      }
    }
  } catch (e) {
    print('⚠️ Erreur lors de la synchronisation des images: $e');
  }
}

}
