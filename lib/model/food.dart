import 'package:mt_activity_management/model/activity.dart';

class Food extends Activity {
  String naziv;
  int brojKalorija;

  Food({super.rb, super.programId, super.activityType, required this.naziv, required this.brojKalorija});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['naziv'] = this.naziv;
    data['brojKalorija'] = this.brojKalorija;
    return data;
  }

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      rb: json['rb'],
      programId: json['programId'],
      naziv: json['naziv'],
      brojKalorija: json['brojKalorija'],
    );
  }
  @override
  String toString() {
    return "- $naziv (broj kalorija $brojKalorija)";
  }
}