import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import '../../../../../exportationPdf/pages/pdf_page.dart';
import '../../controllers/inventaire_controller.dart';
import '../../models/bien_model.dart';
import 'inventaire_form.dart';
import 'inventaire_view.dart';
import 'widgets/detail_bien.dart';
import 'widgets/qr_code.dart';

class MenuInventaireMatiere extends StatefulWidget {
  final Color? backgroundColor;
  final IconData? icon;
  final String libelle;
  final int numero;

  const MenuInventaireMatiere({
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
  int _currentIndex = 0;
  final InventaireController _inventaireController =
      Get.put(InventaireController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _inventaireController.getListeBien();
     
    });
  }

  /// Récupère un bien par son QR Code avec gestion des erreurs
  BienModel? _getBienParQrCode(String qrCode) {
    try {
      return _inventaireController.listeDesBiens
          .firstWhere((code) => code.numeroSerie == qrCode);
    } catch (e) {
      return null; // Retourne `null` si le bien n'existe pas
    }
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
      case 2:
        String barcode = await FlutterBarcodeScanner.scanBarcode(
          "#000000",
          "CANCEL",
          true,
          ScanMode.QR,
        );
        if (barcode == "-1") {
          // L'utilisateur a annulé
          // Traite le QR code
          Get.snackbar("Scan annulé", "Aucun QR Code scanné",
              backgroundColor: Colors.orange, colorText: Colors.white);
          return;
        }
        var bien = _getBienParQrCode(barcode);

        if (bien!.numeroSerie!.isNotEmpty) {
  
         Get.to(DetailBienCodeQr(),arguments: {
            'bienId': bien.id,
            'libelleBien': bien.libelleBien,
            'numeroSerie': bien.numeroSerie
          });
        } else {
          Get.snackbar("Erreur", "Aucun bien trouvé pour ce QR Code",
              backgroundColor: Colors.red, colorText: Colors.white);
        }
        break;

      case 3:
        Get.to(() => PdfPage());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _changerPage(widget.numero);
      },
      child: Container(
        color: widget.backgroundColor ?? Colors.grey.shade300,
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Icon(widget.icon, size: 65),
            const SizedBox(height: 15),
            Text(
              widget.libelle,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
