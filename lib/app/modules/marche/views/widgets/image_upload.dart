import 'dart:io';
import 'package:get/get.dart';
import 'package:get/get_connect/connect.dart';
import 'package:http_parser/http_parser.dart';

import '../../../../constants/constants.dart';
import '../../../auth/controllers/authentification.dart';

class ImageUploadFile extends GetConnect {
  AuthentificationController _authentificationController =
      Get.find<AuthentificationController>();

  Future<String> uploadImage(List<String> list, int? marcheId,
      String? longitude, String? latitude, String? observation) async {
    try {
      final form = FormData({});

      for (String path in list) {
        form.files.add(MapEntry(
          "file[]",
          MultipartFile(File(path),
              filename:
                  "${DateTime.now().millisecondsSinceEpoch}.${path.split('.').last}"),
        ));
        form.fields.addAll([
        MapEntry("marche_id", marcheId.toString()),
        MapEntry("longitude", longitude ?? ""),
        MapEntry("latitude", latitude ?? ""),
        MapEntry("observation", observation ?? ""),
      ]);
      print(observation);
      }
      // Ajout des champs supplémentaires
      
      final response = await post(
       uploadImageUrl,
        form,
        headers: {
          "Authorization":
              "Bearer ${_authentificationController.token}", // Ajouter le token ici
          "Accept": "application/json",
        },
      );

      if (response.status.hasError) {
        return Future.error(response.body);
      } else {
        return response.body['result'];
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
