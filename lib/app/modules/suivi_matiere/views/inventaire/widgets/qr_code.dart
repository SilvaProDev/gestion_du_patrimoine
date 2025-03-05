import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

class DetailBienCodeQr extends StatefulWidget {
  DetailBienCodeQr({super.key});

  @override
  State<DetailBienCodeQr> createState() => _DetailBienCodeQrState();
}

class _DetailBienCodeQrState extends State<DetailBienCodeQr> {
  final String websit = '1234';

  ScreenshotController _screenshotController = ScreenshotController();

  final args = Get.arguments;

  Future<void> captureAndSaveImage() async {
    // final Uint8List uint8list = await _screenshotController.capture();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("INFORMATION SUR LE BIEN"),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 120,
                width: 120,
                child: QrImageView(
                  data: args['numeroSerie'],
                  version: QrVersions.auto,
                ),
              ),
            ],
          ),
          SizedBox(height: 30,),
            Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Libellé',
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue, 
                      fontSize: 16),
                  ),
                ),
                Text(
                  args['libelleBien'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20,),
            Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Numéro de serie',
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue, 
                      fontSize: 16),
                  ),
                ),
                Text(
                  args['numeroSerie'],
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
