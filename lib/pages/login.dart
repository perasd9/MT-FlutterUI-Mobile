import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:mt_activity_management/components/registerDialog.dart';
import 'package:mt_activity_management/main.dart';
import 'package:mt_activity_management/model/member.dart';
import 'package:mt_activity_management/pages/loading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utilities/utils.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  void saveUserData(String clan) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var json = jsonDecode(clan);

    var member = Member(
        clanId: json["ClanId"],
        ime: json["Ime"],
        prezime: json["Prezime"],
        email: json["Email"],
        lozinka: json["Lozinka"]);

    prefs.setInt('userId', member.clanId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF424242),
        //------------------------------------------------------------------- < Body >
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                //---------------------------------------------------------------------- < Main text >
                SizedBox(
                  height: 300,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                          child: Container(
                            margin: const EdgeInsets.only(top: 50),
                            child: const Center(
                              child: Text(
                                "Hi there, \n Let's Get Started",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Raleway"),
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
                //---------------------------------------------------------------------- </ Main text >

                //-------------------------------------------------------------- < Login Form >
                isLoading ? const Padding(padding: EdgeInsets.only(bottom: 150.0), child: Loading()) : Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                color: const Color.fromRGBO(143, 148, 251, 1)),
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromRGBO(143, 148, 251, .2),
                                  blurRadius: 20.0,
                                  offset: Offset(0, 10))
                            ]),
                        //-------------------------------------------------------------- < Login Fields >
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom:
                                      BorderSide(color: Color(0xFFF89A1C)))),
                              child: TextField(
                                controller: emailController,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.emailAddress,
                                style: const TextStyle(
                                    fontFamily: "Raleway",
                                    fontWeight: FontWeight.w500),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    icon: const Icon(Icons.email,
                                        color: Color(0xFFF89A1C)),
                                    hintText: "Email ",
                                    hintStyle: TextStyle(
                                        color: Colors.grey[500],
                                        fontFamily: "Raleway")),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: passwordController,
                                style: const TextStyle(
                                    fontFamily: "Raleway",
                                    fontWeight: FontWeight.w500),
                                obscureText: true,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    icon: const Icon(Icons.key,
                                        color: Color(0xFFF89A1C)),
                                    hintText: "Password",
                                    hintStyle: TextStyle(
                                        color: Colors.grey[500],
                                        fontFamily: "Raleway")),
                              ),
                            )
                          ],
                        ),
                        //-------------------------------------------------------------- </ Login Fields >
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      //-------------------------------------------------------------- < Login Button >
                      GestureDetector(
                        onTap: () async {
                          setState(() {
                            isLoading = true;
                          });
                          Map<String, String> customHeaders = {
                            "content-type": "application/json",
                          };

                          await http
                              .post(
                            Uri.parse("${MyApp.api}/login"),
                            headers: customHeaders,
                            body: jsonEncode({
                              "email": emailController.text,
                              "lozinka": passwordController.text,
                            }),
                          )
                              .then((value) => {
                            if (value.statusCode == 200)
                              {
                                saveUserData(value.body),
                                Navigator.pushNamed(context, "/home"),
                                isLoading = false
                              }
                            else
                              {
                                Utils.showToastSnackBar(
                                    context,
                                    "Email or password is wrong.",
                                    Colors.red[400],
                                    'OK'),
                              isLoading = false
                              },
                            setState(() {

                            })
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: LinearGradient(colors: [
                                const Color(0xFFF89A1C),
                                const Color(0xFFF89A1C).withOpacity(0.7),
                              ])),
                          child: const Center(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Raleway"),
                            ),
                          ),
                        ),
                      ),
                      //-------------------------------------------------------------- </ Login Button >
                    ],
                  ),
                ),
                //-------------------------------------------------------------- </ Login Form >

                //-------------------------------------------------------------- < Register Text >
                Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const RegisterDialog();
                          });
                    },
                    child: const Text(
                      "Don't have an account? \n Register!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xFFF89A1C), fontFamily: "Raleway"),
                    ),
                  ),
                ),
                //-------------------------------------------------------------- </ Register Text >

              ],
            ),
          ),
        )
        //--------------------------------------------------------------------------- </ Body >
        );
  }
}
