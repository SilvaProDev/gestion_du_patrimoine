import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gestion_patrimoine_dcf/app/modules/auth/controllers/authentification.dart';
import 'package:gestion_patrimoine_dcf/app/modules/auth/views/login/login_page.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../layout/background_image.dart';
import '../../../../layout/layout.dart';
import '../widgets/input_widget.dart';
import '../widgets/password_widget.dart';
import '../widgets/reset_password.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordNouveauController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();
  AuthentificationController _authentificationController =
      Get.put(AuthentificationController());
  bool _isObscured = true; //rend le mot de passe visible ou invisible
  String? _passwordError;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BackgroundImage(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                            children: [
                Container(
                  height: 80,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      child: Icon(Icons.arrow_back, color: Colors.white),
                      onTap: () {
                        Get.to(() => LoginPage()); // Remplace avec ta page de connexion
                
                      },
                    ),
                    SizedBox(width: 5),
                    Text("Réinitialisation du mot de passe", style: kHeading),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      InputWidget(
                        hintext: 'Email',
                        controller: _emailController,
                        obscureText: false,
                        icon: Icon(
                          FontAwesomeIcons.solidEnvelope,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      PasswordInput(
                        hintext: 'Ancien mot de passe',
                        controller: _passwordController,
                        obscureText: _isObscured ? true : false,
                        icon: Icon(
                          FontAwesomeIcons.lock,
                          color: Colors.white,
                          size: 20,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObscured ? Icons.visibility : Icons.visibility_off,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              _isObscured = !_isObscured; // Toggle the state
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      PasswordInput(
                        hintext: 'Nouveau',
                        controller: _passwordNouveauController,
                        obscureText: _isObscured ? true : false,
                        icon: Icon(
                          FontAwesomeIcons.lock,
                          color: Colors.white,
                          size: 20,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObscured ? Icons.visibility : Icons.visibility_off,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              _isObscured = !_isObscured; // Toggle the state
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      PasswordInput(
                        hintext: 'Confirmé',
                        controller: _passwordConfirmController,
                        obscureText: _isObscured ? true : false,
                        icon: Icon(
                          FontAwesomeIcons.lock,
                          color: Colors.white,
                          size: 20,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObscured ? Icons.visibility : Icons.visibility_off,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              _isObscured = !_isObscured; // Toggle the state
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(16)),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10)),
                              child: Obx(() {
                                return _authentificationController.isLoading.value
                                    ? Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : Text('Réinitialiser',
                                        style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16));
                              }),
                              onPressed: () {
                      setState(() { 
                        if (_passwordNouveauController.text.trim() != _passwordConfirmController.text.trim()) {
                            Get.snackbar("Erreur", "Le nouveau et l ancien mots de passe ne correspondent pas",
                                backgroundColor: Colors.red, colorText: Colors.white);
                            return; // Stoppe l'exécution
                          }
                      });

                      if (_passwordError == null) {
                        _authentificationController.login(
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim(),
                        );
                      }
                    },
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
                            ],
                          ),
              )),
        )
      ],
    );
  }
}
