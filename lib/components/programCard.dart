import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mt_activity_management/components/addProgramDialog.dart';
import 'package:mt_activity_management/model/program.dart';
import 'package:mt_activity_management/utilities/utils.dart';

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
                program.clan?.clanId != 0
                    ? Text(
                        program.clan?.clanId == 0 ? "" : "by ${program.clan}",
                        style: const TextStyle(
                          color: Color(0xFFF89A1C),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Raleway",
                        ),
                      )
                    : Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Color(0xFFF89A1C),
                            ),
                            height: 32,
                            width: 32,
                            child: IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      useRootNavigator: false,
                                      builder: (BuildContext context) {
                                        return AddProgramDialog(program: program,);
                                      });
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  size: 16,
                                  color: Colors.white,
                                )),
                          ),
                          const SizedBox(
                            width: 6.0,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: const Color(0xFFF89A1C),
                            ),
                            height: 32,
                            width: 32,
                            child: IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          backgroundColor:
                                              const Color(0xFF757575),
                                          title: const Text(
                                            "Delete program",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 22,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "Raleway",
                                            ),
                                          ),
                                          content: const Text(
                                            'Are you sure you want to delete this program?',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "Raleway",
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () async {
                                                var response = await Utils.deleteProgram(int.parse(program.programId.toString()));

                                                if(response.statusCode == 200){
                                                  Navigator.pop(context);
                                                  Utils.showToastSnackBar(context, "Program deleted successfully", Colors.green, "Ok");
                                                }
                                                else{
                                                  Navigator.pop(context);
                                                  Utils.showToastSnackBar(context, "Program cannot be deleted", Colors.red[400], "Ok");
                                                }
                                              },
                                              style: TextButton.styleFrom(
                                                foregroundColor: Colors.white,
                                              ),
                                              child: const Text(
                                                "Yes",
                                                style: TextStyle(
                                                  color: Color(0xFFF89A1C),
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w400,
                                                  fontStyle: FontStyle.italic,
                                                  fontFamily: "Raleway",
                                                ),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              style: TextButton.styleFrom(
                                                foregroundColor: Colors.white,
                                              ),
                                              child: const Text(
                                                "Cancel",
                                                style: TextStyle(
                                                  color: Color(0xFFF89A1C),
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w400,
                                                  fontStyle: FontStyle.italic,
                                                  fontFamily: "Raleway",
                                                ),
                                              ),
                                            )
                                          ],
                                        );
                                      });
                                },
                                icon: const Icon(Icons.delete,
                                    size: 16, color: Colors.white)),
                          ),
                          const SizedBox(
                            width: 6.0,
                          ),
                        ],
                      ),
              ],
            ),
            SizedBox(
              height: 120,
              child: SingleChildScrollView(
                child: ListView.builder(
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
