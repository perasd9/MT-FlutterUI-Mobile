
import 'package:mt_activity_management/model/activity.dart';
import 'package:mt_activity_management/model/member.dart';

class Program{
  int? programId;
  String naziv;
  List<Activity> listaAktivnosti;
  DateTime? datum;
  Member? clan;

  Program({this.programId, required this.naziv, required this.listaAktivnosti, this.datum, this.clan});

  Map<String, dynamic> toJson() {
    return {
      'programId': programId,
      'naziv': naziv,
      'listaAktivnosti': listaAktivnosti?.map((activity) => activity.toJson()).toList(),
      'datum': datum?.millisecondsSinceEpoch,
    };
  }

  factory Program.fromJson(Map<String, dynamic> json) {
    return Program(
      programId: json['programId'],
      naziv: json['naziv'],
      listaAktivnosti: (json['listaAktivnosti'] as List<dynamic>?)!.map((activityJson) => Activity.fromJson(activityJson)).toList(),
      datum: json['datum'] != null ? DateTime.fromMillisecondsSinceEpoch(json['datum']) : null,
      clan: Member.fromJson(json['clan']),
    );
  }


}