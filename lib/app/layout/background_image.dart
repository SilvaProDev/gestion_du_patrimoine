import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({super.key});

  @override
  Widget build(BuildContext context) {
    return  ShaderMask(
       /* Le widget ShaderMask dans Flutter est utilisé pour appliquer un shader personnalisé à ses enfants, comme un dégradé ou un masque de couleurs.  Il permet de modifier l'apparence des widgets de manière créative,
       par exemple en appliquant un effet de texte dégradé ou en masquant  un widget avec une forme spécifique. */
        shaderCallback: (bounds)=>LinearGradient(
            colors: [Colors.transparent, Colors.transparent],
          begin: Alignment.bottomCenter,
          end: Alignment.center
          ).createShader(bounds),
      blendMode: BlendMode.darken,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/image_sidcf.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken)
          )
        ),
      ),
    );
  }
}
