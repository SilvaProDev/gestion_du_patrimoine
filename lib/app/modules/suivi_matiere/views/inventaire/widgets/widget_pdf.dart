import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class BarcodeScannerPage extends StatefulWidget {
  @override
  _BarcodeScannerPageState createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  String scannedBarcode = "Aucun code scanné";

  Future<void> scanBarcode() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", // Couleur du bouton "Annuler"
        "Annuler",
        true, // Activer/désactiver le flash
        ScanMode.BARCODE, // Mode BARCODE ou QR_CODE
      );

      if (barcodeScanRes != "-1") {
        setState(() {
          scannedBarcode = barcodeScanRes;
        });
      } else {
        setState(() {
          scannedBarcode = "Scan annulé";
        });
      }
    } catch (e) {
      setState(() {
        scannedBarcode = "Erreur lors du scan : $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Scanner Code-Barres")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Résultat : $scannedBarcode",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: scanBarcode,
              child: Text("Scanner un code-barres"),
            ),
          ],
        ),
      ),
    );
  }
}
