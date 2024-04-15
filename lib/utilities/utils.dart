import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mt_activity_management/main.dart';
import 'package:mt_activity_management/model/activity.dart';
import 'package:mt_activity_management/model/member.dart';
import 'package:mt_activity_management/model/program.dart';

class Utils {

  //SHOWING TOAST MESSAGE
  static showToastSnackBar(BuildContext context, String text,
      Color? backgroundColor, String label) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          text,
          style: const TextStyle(
              fontFamily: "Raleway",
              fontSize: 14),
        ),
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        margin: const EdgeInsets.only(
            bottom: 20, left: 40, right: 40),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: label,
          onPressed: () {},
        ),
      ),
    );
  }

  //GET PROGRAMS API CALLING
  static Future<List<Program>> getPrograms(DateTime date, {bool private = true}) async {
    List<Program> listPrograms = [];

    Map<String, String> customHeaders = {
      "content-type": "application/json",
    };
    var data = jsonEncode({
      "datum": "${DateFormat('yyyy-MM-ddTHH:mm:ssZ').format(date)}Z",
    });

    var response = private ? await http.post(Uri.parse("${MyApp.api}/privateprograms"), headers: customHeaders, body: data,) :
        await http.post(Uri.parse("${MyApp.api}/programs"), headers: customHeaders, body: data,);

    List<dynamic> jsonList = json.decode(response.body.toString());

    listPrograms = jsonList.map((json) {
      List<dynamic> jsonActivities = json['listaAktivnosti'];

      List<Activity> activities = jsonActivities.map((activityJson) {
        return Activity(
          rb: activityJson['Rb'],
          programId: activityJson['ProgramId'],
          name: activityJson['Naziv'],
          kcal: activityJson['BrojKalorija'],
          numberOfSeries: activityJson['BrojSerija'],
          weight: double.parse(activityJson['Kilaza'].toString()),
          exerciseId: activityJson['vezbaId'],
          amount: double.parse(activityJson['Kolicina'].toString()),
        );
      }).toList();

      return Program(
          programId: json['programId'],
          naziv: json['naziv'],
          datum: DateTime.parse(json['datum']),
          clan: json['Clan'] != null ? Member.fromJson(json['Clan']) : null,
          listaAktivnosti: activities);
    }).toList();

    return listPrograms;
  }
}