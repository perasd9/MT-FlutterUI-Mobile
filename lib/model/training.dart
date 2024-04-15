import 'package:mt_activity_management/model/activity.dart';
import 'package:mt_activity_management/model/exercise.dart';

class Training extends Activity {
  int brojSerija;
  double kilaza;
  int? vezbaId;
  Exercise vezba;

  Training({super.rb, super.programId, super.activityType, required this.brojSerija,
    required this.kilaza, this.vezbaId, required this.vezba});


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['brojSerija'] = this.brojSerija;
    data['kilaza'] = this.kilaza;
    data['vezbaId'] = this.vezbaId;
    data['vezba'] = this.vezba.toJson();
    return data;
  }

  factory Training.fromJson(Map<String, dynamic> json) {
    return Training(
      rb: json['rb'],
      programId: json['programId'],
      brojSerija: json['brojSerija'],
      kilaza: json['kilaza'],
      vezbaId: json['vezbaId'],
      vezba: Exercise.fromJson(json['vezba']),
    );
  }

  @override
  String toString() {
    return "-$vezba (kilaza $kilaza, broj serija $brojSerija)";
  }
}