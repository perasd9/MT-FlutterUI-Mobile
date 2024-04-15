import 'package:flutter/material.dart';
import 'package:mt_activity_management/model/program.dart';

class ProgramCard extends StatelessWidget {
  const ProgramCard({required this.program, super.key});

  final Program program;

  AssetImage setBackgroundPicture() {
    switch (program.naziv) {
      case "Training":
        return const AssetImage("assets/images/trainingpicture.png");
      case "Food":
        return const AssetImage("assets/images/foodpicture.png");
      case "Supplements":
        return const AssetImage("assets/images/supplementspicture.png");
      default:
        return const AssetImage("assetName");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: 320,
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        image:
            DecorationImage(image: setBackgroundPicture(), fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(30.0),
        border: Border.all(
            width: 4, style: BorderStyle.solid, color: const Color(0xFFF89A1C)),
        // boxShadow: [BoxShadow(color: Colors.black, blurRadius: 4,offset: Offset(4, 8))]
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(13, 7, 5, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  program.naziv,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.italic,
                    fontFamily: "Raleway",
                  ),
                ),
                Text(
                  program.clan?.clanId == 0 ? "" : "by ${program.clan}",
                  style: const TextStyle(
                    color: Color(0xFFF89A1C),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Raleway",
                  ),
                ),
              ],
            ),
            ListView.builder(
              itemCount: program.listaAktivnosti?.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Text(
                    program.listaAktivnosti[index].toString(),
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontFamily: "Raleway",
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
