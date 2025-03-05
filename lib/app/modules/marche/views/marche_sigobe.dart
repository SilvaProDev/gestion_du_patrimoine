import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/activite_model.dart';

class MarcheSigobe extends StatefulWidget {
  ActiviteModel activites;
  MarcheSigobe({super.key, required this.activites});

  @override
  State<MarcheSigobe> createState() => _MarcheSigobeState();
}

class _MarcheSigobeState extends State<MarcheSigobe> {
  
  @override
  Widget build(BuildContext context) {
    return Column(
          children: [
            ListTile(
              leading: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 30,
                  minHeight: 30,
                  maxWidth: 35,
                  maxHeight: 35,
                ),
                child: Image.asset("assets/images/image_sidcf.jpg",
                    fit: BoxFit.cover,
                    height: 280,),
              ),
              title: Text('${widget.activites.libelleActivite}',
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),),
              subtitle: Text('Marchés: ${widget.activites.nbreMarche}',
              style: GoogleFonts.poppins(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              fontSize: 14)
              ),
              onTap: () {
                print("Me!!!");
              },
            ),
            Divider(
              color: Colors.black,
            ),
          ],
        );
  }
}
