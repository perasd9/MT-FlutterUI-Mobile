
import 'package:mt_activity_management/model/activity.dart';
import 'package:mt_activity_management/model/exercise.dart';
import 'package:mt_activity_management/model/food.dart';
import 'package:mt_activity_management/model/member.dart';
import 'package:mt_activity_management/model/supplement.dart';
import 'package:mt_activity_management/model/training.dart';

class Program{
  int? programId;
  String naziv;
  List<Activity> listaAktivnosti;
  DateTime? datum;
  Member? clan;
  bool public;

  Program({this.programId, required this.naziv, required this.listaAktivnosti, this.datum, this.clan, required this.public});

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
      public: json['Public']
    );
  }
  //MAPPING LIST ACTIVITIES TO LIST OF TRAININGS
  List<Training> mapToTraining(){
    return listaAktivnosti.map((element) {
      return Training(rb : element.rb, programId : element.programId, activityType : element.activityType, brojSerija : element.numberOfSeries as int,
          kilaza : element.weight as double, vezbaId : element.exerciseId, vezba : Exercise(naziv: element.name.toString()));
    }).toList();
  }

  //MAPPING LIST ACTIVITIES TO LIST OF FOODS
  List<Food> mapToFood(){
    return listaAktivnosti.map((element) {
      return Food(rb : element.rb, programId : element.programId, activityType : element.activityType, naziv: element.name.toString(), brojKalorija: element.kcal as int);
    }).toList();
  }

  //MAPPING LIST ACTIVITIES TO LIST OF SUPPLEMENTS
  List<Supplement> mapToSupplements(){
    return listaAktivnosti.map((element) {
      return Supplement(rb : element.rb, programId : element.programId, activityType : element.activityType, naziv: element.name.toString(), kolicina: element.amount as double);
    }).toList();
  }
}