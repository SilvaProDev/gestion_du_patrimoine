import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gestion_patrimoine_dcf/app/modules/marche/controllers/image_controller.dart';
import 'package:gestion_patrimoine_dcf/app/modules/marche/views/widgets/comment_field.dart';
import 'package:gestion_patrimoine_dcf/app/modules/marche/views/widgets/image_picker.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../controllers/image_marche_hors_ligne.dart';


class ImgeFormHorsLigne extends StatefulWidget {
  final int? marcheId;
  final String? longitude;
  final String? latitude;
  final String? observation;
  const ImgeFormHorsLigne({super.key,this.marcheId, this.longitude, this.latitude, this.observation});
  @override
  State<ImgeFormHorsLigne> createState() => _ImgeFormHorsLigneState();
}

class _ImgeFormHorsLigneState extends State<ImgeFormHorsLigne> {
   File? _deviceImage;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();
  final ImageControllerHorsLigne _imageControllerHorsLigne = Get.put(ImageControllerHorsLigne());
 final  ImageControllerHorsLigne _imageMarcheController = Get.put(ImageControllerHorsLigne());

  void updateUrlField(String url) {
    setState(() {
      _urlController.text = url;
    });
  }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _imageMarcheController.getImagesFromDatabase(widget.marcheId!);
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
        final String url = await _imageControllerHorsLigne.uploadImage(_deviceImage!,
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
          'Enregistrement des images hors ligne',
          style: GoogleFonts.roboto(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
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
              onPressed: () =>   _imageControllerHorsLigne.selectMultipleImage(),
            ),
            // TextButton.icon(
            //   icon: const Icon(Icons.photo_camera),
            //   label: const Text('Caméra'),
            //   onPressed: () =>  _pickImage(updateUrlField as ImageSource)
            // ),
            
          ],
        ),
           
           Obx(() {
            return _imageControllerHorsLigne.selectFileCount.value > 0
                ?Container(
  padding: EdgeInsets.all(20),
  child: SizedBox(
    height: 200, // Taille fixe pour éviter les erreurs
    child: GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: _imageControllerHorsLigne.selectFileCount.value,
      itemBuilder: (context, index) {
        return Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(
                File(_imageControllerHorsLigne.listeImagePath![index]),
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: -10,
              right: 3,
              child: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  _imageControllerHorsLigne.removeImage(index); // Supprimer l'image
                },
              ),
            ),
          ],
        );
      },
    ),
  ),
)

                : const SizedBox();
          }),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () async {
                _imageControllerHorsLigne.uploadImageHorsLigne(
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
