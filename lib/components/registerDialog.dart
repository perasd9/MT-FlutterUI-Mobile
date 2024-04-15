import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mt_activity_management/main.dart';
import 'package:mt_activity_management/utilities/utils.dart';

class RegisterDialog extends StatefulWidget {
  const RegisterDialog({super.key});

  @override
  State<RegisterDialog> createState() => _RegisterDialogState();
}

class _RegisterDialogState extends State<RegisterDialog> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? nameError;
  String? surnameError;
  String? emailError;
  String? passwordError;

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a name.';
    }
    return null;
  }

  String? validateSurname(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a surname.';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email.';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    nameError = validateName(nameController.text);
    surnameError = validateSurname(surnameController.text);
    emailError = validateEmail(emailController.text);
    passwordError = validatePassword(passwordController.text);

        return Scaffold(
          backgroundColor: Colors.transparent,
          body: AlertDialog(
            backgroundColor: const Color(0xFF424242),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Create Account",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Raleway",
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Icon(
                      Icons.close,
                      color: Colors.red[400],
                    ),
                  ),
                ),
              ],
            ),
            content: Container(
              height: 450,
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              margin: const EdgeInsets.symmetric(vertical: 13.0),
              width: MediaQuery.of(context).size.width - 100,
              child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                        child: TextField(
                          controller: nameController,
                          onChanged: (value) {
                            setState(() {});
                          },
                          style: const TextStyle(
                              fontFamily: "Raleway", fontWeight: FontWeight.w500),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            prefixIcon: const Icon(Icons.text_format_rounded,
                                color: Color(0xFFF89A1C)),
                            hintText: "Name ",
                            hintStyle:
                            TextStyle(color: Colors.grey[500], fontFamily: "Raleway"),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                      Text(
                        nameError == null ? "" : nameError.toString(),
                        style: const TextStyle(
                            color: Colors.red, fontSize: 13, fontFamily: "Raleway"),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 50,
                        child: TextField(
                          controller: surnameController,
                          onChanged: (value) {
                            setState(() {});
                          },
                          style: const TextStyle(
                              fontFamily: "Raleway", fontWeight: FontWeight.w500),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            prefixIcon:
                            const Icon(Icons.text_format, color: Color(0xFFF89A1C)),
                            hintText: "Surname",
                            hintStyle:
                            TextStyle(color: Colors.grey[500], fontFamily: "Raleway"),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                      Text(
                        surnameError == null ? "" : surnameError.toString(),
                        style: const TextStyle(
                            color: Colors.red, fontSize: 13, fontFamily: "Raleway"),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 50,
                        child: TextField(
                          controller: emailController,
                          onChanged: (value) {
                            setState(() {});
                          },
                          style: const TextStyle(
                              fontFamily: "Raleway", fontWeight: FontWeight.w500),
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            prefixIcon: const Icon(Icons.email, color: Color(0xFFF89A1C)),
                            hintText: "Email ",
                            hintStyle:
                            TextStyle(color: Colors.grey[500], fontFamily: "Raleway"),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                      Text(
                        emailError == null ? "" : emailError.toString(),
                        style: const TextStyle(
                            color: Colors.red, fontSize: 13, fontFamily: "Raleway"),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 50,
                        child: TextField(
                          controller: passwordController,
                          onChanged: (value) {
                            setState(() {});
                          },
                          style: const TextStyle(
                              fontFamily: "Raleway", fontWeight: FontWeight.w500),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            prefixIcon: const Icon(Icons.key, color: Color(0xFFF89A1C)),
                            hintText: "Password ",
                            hintStyle:
                            TextStyle(color: Colors.grey[500], fontFamily: "Raleway"),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          obscureText: true,
                        ),
                      ),
                      Text(
                        passwordError == null ? "" : passwordError.toString(),
                        style: const TextStyle(
                            color: Colors.red, fontSize: 13, fontFamily: "Raleway"),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      GestureDetector(

                        //fUNCTION HAS TO BE CALLED HERE CAUSE OF CONTEXT REFERENCE AND VOD CALLBACK (ONTAP)
                        onTap: () async{
                          if (nameError != null ||
                              surnameError != null ||
                              emailError != null ||
                              passwordError != null) {
                            Utils.showToastSnackBar(
                                context, "Values are not correct.", Colors.red[400], 'OK');
                          } else {
                            Map<String, String> customHeaders = {
                              "content-type": "application/json",
                            };

                            await http
                                .post(
                              Uri.parse("${MyApp.api}/member"),
                              headers: customHeaders,
                              body: jsonEncode({
                                "ime": nameController.text,
                                "prezime": surnameController.text,
                                "email": emailController.text,
                                "lozinka": passwordController.text,
                              }),
                            )
                                .then((value) => {
                              if (value.statusCode == 201)
                                {
                                  Utils.showToastSnackBar(
                                      context, "Member is created", Colors.green, 'OK'),
                                  Navigator.pop(context)
                                }else{
                                Utils.showToastSnackBar(
                                    context, "Member cannot be created", Colors.red[400], 'OK'),
                              }
                            });
                          }
                        },
                        child: Container(
                          height: 50,
                          width: 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: LinearGradient(colors: [
                                const Color(0xFFF89A1C),
                                const Color(0xFFF89A1C).withOpacity(0.7),
                              ])),
                          child: const Center(
                            child: Text(
                              "Register",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Raleway"),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ),
        );

  }
}
