import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderDetail extends StatelessWidget {
  final String libelleMarche;
  final int montantMarche;
  final int? marcheId;
  const HeaderDetail({super.key, 
  required this.libelleMarche, 
  required this.montantMarche,
   this.marcheId});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    libelleMarche,
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[400], 
                      fontSize: 16),
                  ),
                ),
               
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Montant marché',
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue, 
                      fontSize: 14),
                  ),
                ),
                Text(
                  '${montantMarche}',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
    
  }
}
