import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gestion_patrimoine_dcf/app/modules/marche/views/widgets/comment_field.dart';
import 'package:gestion_patrimoine_dcf/app/modules/marche/views/widgets/image_picker.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../controllers/localisation.dart';
import '../../controllers/image_controller.dart';

class ImageForm extends StatefulWidget {
  final int? marcheId;
  final String? longitude;
  final String? latitude;
  final String? observation;
  ImageForm({super.key,this.marcheId, this.longitude, this.latitude, this.observation});
  @override
  State<ImageForm> createState() => _ImageFormState();
}

class _ImageFormState extends State<ImageForm> {
   File? _deviceImage;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();
  ImageController _imageController = Get.put(ImageController());

  void updateUrlField(String url) {
    setState(() {
      _urlController.text = url;
    });
  }

  @override
  void dispose() {
    _urlController.dispose();
    _textController.dispose();
    super.dispose();
  }
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
        print('url');
        print((url));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors de la sélection de l\'image')),
      );
    }
  }

  void _submitData() {
    String commentaire = _textController.text;
    print("Commentaire saisi : $commentaire");
    // Tu peux maintenant envoyer `commentaire` via une API ou l'utiliser
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
    icon: Icon(Icons.arrow_back_outlined, color: Colors.white,),
    onPressed: () {
      Navigator.of(context).pop(); // Retour à l'écran précédent
    },
  ),
        centerTitle: true,
        elevation: 8.5,
        backgroundColor: Colors.blue[400],
        title: Text(
          'Enregistrement des images',
          style: GoogleFonts.roboto(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CommentField(
              hintText: 'Faites une observation ...',
              controller: _textController,
            ),
            SizedBox(
              height: 20,
            ),
            MarcheImagePicker(
              updateUrl: updateUrlField,
              marcheId: widget.marcheId,
            ),
            Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton.icon(
              icon: const Icon(Icons.photo),
              label: const Text('Galerie'),
              onPressed: () =>   _imageController.selectMultipleImage(),
            ),
            // TextButton.icon(
            //   icon: const Icon(Icons.photo_camera),
            //   label: const Text('Caméra'),
            //   onPressed: () =>  _pickImage(updateUrlField as ImageSource)
            // ),
            
          ],
        ),
            // Row(
            //   children: [
            //     ElevatedButton(
            //         onPressed: () {
            //           _imageController.selectMultipleImage();
            //         },
            //         child: Text("Pick image")
            //         ),
            //     ElevatedButton(
            //         onPressed: () {
            //           _imageController.uploadImages(widget.marcheId);
            //         },
            //         child: Text("Upload")),
            //   ],
            // ),
           Obx(() {
            return _imageController.selectFileCount.value > 0
                ? Container(
                  padding: EdgeInsets.all(20),
                  child: SizedBox(
                  
                      height: 300, // Taille fixe pour éviter les erreurs
                      child: GridView.builder(
                        shrinkWrap: true, 
                        physics: const NeverScrollableScrollPhysics(), 
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: _imageController.selectFileCount.value,
                        itemBuilder: (context, index) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              File(_imageController.listeImagePath![index]),
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      ),
                    ),
                )
                : const SizedBox();
          }),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                _imageController.uploadImages(
                  widget.marcheId,widget.longitude,widget.latitude, _textController.text,
                  );
              },
              style: ElevatedButton.styleFrom(
                  elevation: 3,
                  backgroundColor: Colors.blue[300],
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.0, vertical: 10)),
              child: Text(
                "Enregistrer",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
