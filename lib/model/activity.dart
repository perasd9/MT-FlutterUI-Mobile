import 'package:mt_activity_management/model/program.dart';
import 'package:mt_activity_management/model/exercise.dart';

class Activity {
  int? rb;
  int? programId;
  Program? program;
  String? activityType;
  //food
  String? name;
  int? kcal;
  //training
  int? numberOfSeries;
  double? weight;
  int? exerciseId;
  Exercise? exercise;
  //supplement
  double? amount;

  //STATE OF ACTIVITY
  bool? isDeleted = false;
  bool? isAdded = false;

  Activity({this.rb, this.programId, this.program, this.activityType, this.name,
  this.kcal, this.numberOfSeries, this.weight, this.exerciseId, this.exercise, this.amount, this.isDeleted, this.isAdded});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (rb != null) data['rb'] = rb;
    if (programId != null) data['programId'] = programId;
    if (program != null) data['program'] = program!.toJson();
    if (activityType != null) data['activityType'] = activityType;
    data['isDeleted'] = isDeleted;
    data['isAdded'] = isAdded;
    return data;
  }

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      rb: json['rb'],
      programId: json['programId'],
      program: json['program'] != null ? Program.fromJson(json['program']) : null,
      activityType: json['activityType'],
    );
  }

  @override
  String toString() {
    return kcal != 0 ? "- $name (broj kalorija $kcal)" : amount != 0 ? "- $name (kolicina $amount g)"
        : "- $name (kilaza $weight kg, broj serija $numberOfSeries)";
  }

}