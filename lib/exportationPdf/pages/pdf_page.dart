import 'package:flutter/material.dart';
import 'package:gestion_patrimoine_dcf/app/modules/suivi_matiere/controllers/inventaire_controller.dart';
import 'package:gestion_patrimoine_dcf/app/modules/suivi_matiere/models/bien_model.dart';
import 'package:get/get.dart';

import '../api/pdf_api.dart';
import '../api/pdf_article_api.dart';
import '../../model/customer.dart';
import '../../model/invoice.dart';
import '../../model/supplier.dart';
import '../widgets/button_widget.dart';
import '../widgets/title_widget.dart';

class PdfPage extends StatefulWidget {
  @override
  _PdfPageState createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
    final InventaireController _inventaireController = Get.put(InventaireController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _inventaireController.getListeBien();
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text('LISTE DES INVENTAIRES EN PDF'),
          centerTitle: true,
        ),
        body: Container(
          color: Colors.blue[50],
          padding: EdgeInsets.all(32),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TitleWidget(
                  icon: Icons.picture_as_pdf,
                  text: 'Exporter en pdf',
                ),
                const SizedBox(height: 48),
                ButtonWidget(
                  text: 'Exporter en PDF',
                  onClicked: () async {
                    _inventaireController.getListeBien();
                    final pdfFile = await PdfInvoiceApi.generate();

                    PdfApi.openFile(pdfFile);
                  },
                ),
              ],
            ),
          ),
        ),
      );
}
