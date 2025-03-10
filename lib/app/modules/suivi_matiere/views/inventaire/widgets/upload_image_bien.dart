import 'dart:io';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';

import '../../../../auth/controllers/authentification.dart';

class ImageBienUploadFile extends GetConnect {
 final AuthentificationController _authentificationController =
      Get.find<AuthentificationController>();

  Future<String> uploadImage(List<String> list, int? articleId, int? stockArticleId) async {
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
        MapEntry("article_id", articleId.toString()),
        MapEntry("stockarticle_id", stockArticleId.toString()),
      ]);
      }
      // Ajout des champs supplémentaires
      
      final response = await post(
        'http://192.168.11.1:51/back-end/public/index.php/api/imageBienUpload',
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
