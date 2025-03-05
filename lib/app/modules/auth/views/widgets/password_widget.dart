import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../layout/layout.dart';

class PasswordInput extends StatefulWidget {
  const PasswordInput({
    super.key,
    required this.hintext,
    required this.controller,
    required this.obscureText,
    required this.icon,
    required this.suffixIcon,
  });

  final String hintext;
  final TextEditingController controller;
  final bool obscureText;
  final Icon icon;
  final IconButton suffixIcon;

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.grey[600]!.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16)),
      child: TextField(
        cursorColor: Colors.white,
        obscureText: widget.obscureText,
        controller: widget.controller,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 16),
            border: InputBorder.none,
            prefixIcon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: widget.icon,
            ),
            hintText: widget.hintext,
            hintStyle: inputTextStyle,
            suffix: widget.suffixIcon),
        style: inputTextStyle,
        textInputAction: TextInputAction.none,
      ),
    );
  }
}
