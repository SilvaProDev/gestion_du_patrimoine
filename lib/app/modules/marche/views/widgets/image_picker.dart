import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gestion_patrimoine_dcf/app/modules/marche/controllers/image_controller.dart';
import 'package:gestion_patrimoine_dcf/app/modules/marche/controllers/marche_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class MarcheImagePicker extends StatefulWidget {
  final Function(String) updateUrl;
  final int? marcheId;

  const MarcheImagePicker({super.key, required this.updateUrl, this.marcheId});

  @override
  State<MarcheImagePicker> createState() => _MarcheImagePickerState();
}

class _MarcheImagePickerState extends State<MarcheImagePicker> {
  File? _deviceImage;
  final ImagePicker _picker = ImagePicker();
  ImageController _imageController = Get.put(ImageController());

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);

      if (pickedFile != null) {
        setState(() {
          _deviceImage = File(pickedFile.path);
        });

        // Simuler l'upload et récupérer une URL
        final String url = await _imageController.uploadImage(_deviceImage!,
            widget.marcheId); // Remplace par l'URL réelle après upload
        widget.updateUrl(url);
       
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors de la sélection de l\'image')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: TextButton.icon(
            icon: const Icon(Icons.photo_camera),
            label: const Text('Caméra'),
            onPressed: () => _pickImage(ImageSource.camera),
          ),
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: <Widget>[
        //     TextButton.icon(
        //       icon: const Icon(Icons.photo),
        //       label: const Text('Galerie'),
        //       onPressed: () => _pickImage(ImageSource.gallery),
        //     ),
        //     TextButton.icon(
        //       icon: const Icon(Icons.photo_camera),
        //       label: const Text('Caméra'),
        //       onPressed: () => _pickImage(ImageSource.camera),
        //     ),
        //   ],
        // ),
        // const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(16),
          child: _deviceImage != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    _deviceImage!,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                )
              : Text(''),
        ),
      ],
    );
  }
}
