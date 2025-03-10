import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import '../../../../../exportationPdf/pages/pdf_page.dart';
import '../../controllers/inventaire_controller.dart';
import '../../models/bien_model.dart';
import 'inventaire_form.dart';
import 'inventaire_view.dart';
import 'widgets/detail_bien.dart';
import 'widgets/widget_pdf.dart';

class MenuInventaireMatiere extends StatefulWidget {
  final Color? backgroundColor;
  final icon;
  final String libelle;
  final int numero;
  MenuInventaireMatiere({
    super.key,
    this.backgroundColor,
    this.icon,
    required this.libelle,
    required this.numero,
  });

  @override
  State<MenuInventaireMatiere> createState() => _MenuInventaireMatiereState();
}

class _MenuInventaireMatiereState extends State<MenuInventaireMatiere> {
  int _currentIndex = 0; // Index de l'élément sélectionné
  InventaireController _inventaireController = Get.put(InventaireController());

   BienModel _getBienParQrCode(String qrCode) {
    return  _inventaireController.listeDesBiens
        .firstWhere((code) => code.numeroSerie == qrCode);
    
  }

  Future<void> _changerPage(int index) async {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        Get.to(() => InventaireForm());
        break;
      case 1:
        Get.to(() => InventaireView());
        break;
      case 3:
        Get.to(() => PdfPage());
        break;
      case 2:
        String barcode = await FlutterBarcodeScanner.scanBarcode(
          "#000000",
          "CANCEL",
          true,
          ScanMode.QR,
        );
        if(_getBienParQrCode(barcode).numeroSerie != ""){
          Get.to(DetailBien(), arguments: {
          'bienId': _getBienParQrCode(barcode).id,
          'libelleBien': _getBienParQrCode(barcode).libelleBien,
          'numeroSerie': _getBienParQrCode(barcode).numeroSerie
        });
        }
        ;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        color: Colors.grey.shade300,
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Icon(
              widget.icon as IconData?,
              size: 65,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "${widget.libelle}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            )
          ],
        ),
      ),
      onTap: () {
        print(widget.numero);
        _changerPage(widget.numero);
      },
    );
  }
}
