import 'package:mt_activity_management/model/activity.dart';

class Supplement extends Activity {
  String naziv;
  double kolicina;

  Supplement({super.rb, super.programId, super.activityType, required this.naziv, required this.kolicina});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['naziv'] = this.naziv;
    data['Kolicina'] = this.kolicina;
    return data;
  }

  factory Supplement.fromJson(Map<String, dynamic> json) {
    return Supplement(
      rb: json['rb'],
      programId: json['programId'],
      naziv: json['naziv'],
      kolicina: json['Kolicina'],
    );
  }

  @override
  String toString() {
    return "- $naziv (kolicina $kolicina)";
  }
}