import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../layout/layout.dart';

class InputWidget extends StatelessWidget {
  const InputWidget({super.key, required this.hintext, required this.controller, required this.obscureText, required this.icon});

  final String hintext;
  final TextEditingController controller;
  final bool obscureText;
  final Icon icon;
  @override
  Widget build(BuildContext context) {
    return  Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[600]!.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16)
      ),
      child: TextField(
        cursorColor: Colors.white,
        obscureText:obscureText,
        controller: controller,
        decoration: InputDecoration(
          
          contentPadding: EdgeInsets.symmetric(vertical: 16),
          border: InputBorder.none,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: icon,
          ),
          hintText: hintext,
          
          hintStyle: inputTextStyle
        ),
        style: inputTextStyle,
        textInputAction: TextInputAction.none,
      ),
    );
  }
}
