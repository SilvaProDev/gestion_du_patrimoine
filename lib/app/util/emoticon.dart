
import 'package:flutter/material.dart';

class EmoticonPage extends StatelessWidget {
  final String  EmoticonFace;
   EmoticonPage({super.key, required this.EmoticonFace});

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          color:Colors.blue[600],
          borderRadius: BorderRadius.circular(12.0)
      ),
      child: Center(
          child: Text(
            EmoticonFace,
            style: TextStyle(fontSize: 18),
          )
      )
    );
  }
}
