import 'package:flutter/material.dart';
import 'package:gestion_patrimoine_dcf/app/modules/suivi_matiere/models/bien_model.dart';
import 'package:gestion_patrimoine_dcf/app/modules/suivi_matiere/views/inventaire/widgets/detail_bien.dart';
import 'package:gestion_patrimoine_dcf/app/modules/suivi_matiere/views/inventaire/widgets/qr_code.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

class InfoBien extends StatelessWidget {
  BienModel bien;
  final int nbre;
  InfoBien({super.key, required this.bien, required this.nbre});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Column(
        children: [
          Container(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.grey[200],
                child: Text(
                  '${nbre + 1}',
                  style: TextStyle(fontSize: 16, color: Colors.blue[400]),
                ),
              ),
              title: Text('${bien.libelleBien}',
                  style: GoogleFonts.roboto(fontSize: 12)),
              subtitle: Row(
                children: [
                  Text(
                    'Numéro de série:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('${bien.numeroSerie}',
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          fontSize: 14)),
                  SizedBox(
                    width: 5,
                  ),
                ],
              ),
              trailing: SizedBox(
                width: 60,
                child: Row(
                  children: [
                    InkWell(
                        onTap: () {
                          Get.to(DetailBienCodeQr(),arguments: {
                            'bienId': bien.id,
                            'libelleBien': bien.libelleBien,
                            'numeroSerie': bien.numeroSerie
                          });
                        },
                        child: QrImageView(
                          data: '${bien.numeroSerie}',
                          size: 40,
                          version: QrVersions.auto,
                        )
                        ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.to(DetailBien(), arguments: {
                            'bienId': bien.id,
                            'libelleBien': bien.libelleBien,
                            'numeroSerie': bien.numeroSerie
                          });
                        },
                        child: const Icon(Icons.image),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
