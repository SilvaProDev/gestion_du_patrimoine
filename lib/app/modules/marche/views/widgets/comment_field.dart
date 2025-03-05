import 'package:flutter/material.dart';
import 'package:gestion_patrimoine_dcf/app/controllers/localisation.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

class CommentField extends StatefulWidget {
  const CommentField({
    super.key,
    required this.hintText,
    required this.controller,
  });

  final String hintText;
  final TextEditingController controller;

  @override
  State<CommentField> createState() => _CommentFieldState();
}

class _CommentFieldState extends State<CommentField> {
  LocalisationController _localisation = Get.put(LocalisationController());
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Obx(() => Container(
                    margin: EdgeInsets.symmetric(vertical: 30),
                    padding: EdgeInsets.all(14),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.grey[300]),
                    child: Text(
                      "Longitude: ${_localisation.longitude.value}",
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 16),
                    ),
                  )),
              Obx(() => Container(
                    margin: EdgeInsets.symmetric(vertical: 30),
                    padding: EdgeInsets.all(14),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.grey[300]),
                    child: Text(
                      "Latitude: ${_localisation.latitude.value}",
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 16),
                    ),
                  )),
            ],
          ),
          SizedBox(height: 10),
          Container(
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10)),
            child: TextField(
              maxLines: null,
              controller: widget.controller,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: widget.hintText,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
            ),
          ),
        ],
      ),
    );
  }
}
