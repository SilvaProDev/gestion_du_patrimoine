import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class InputFieldWidget extends StatelessWidget {
  const InputFieldWidget({
    super.key, 
    required this.hintext, 
    required this.controller,
    });

  final String hintext;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          labelText: hintext,
          labelStyle: TextStyle(
      color: Colors.blue[700], 
      fontWeight: FontWeight.bold,
      fontSize: 20)
        ),
      );
    
  }
}
