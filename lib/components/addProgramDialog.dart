import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:decorated_dropdownbutton/decorated_dropdownbutton.dart';
import 'package:intl/intl.dart';
import 'package:mt_activity_management/components/program_forms/foodForm.dart';
import 'package:mt_activity_management/components/program_forms/supplementForm.dart';
import 'package:mt_activity_management/components/program_forms/trainingForm.dart';
import 'package:mt_activity_management/main.dart';
import 'package:mt_activity_management/model/food.dart';
import 'package:mt_activity_management/model/supplement.dart';
import 'package:mt_activity_management/model/training.dart';
import 'package:http/http.dart' as http;
import 'package:mt_activity_management/utilities/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/activity.dart';

class AddProgramDialog extends StatefulWidget {
  const AddProgramDialog({super.key});

  @override
  State<AddProgramDialog> createState() => _AddProgramDialogState();
}

class _AddProgramDialogState extends State<AddProgramDialog> {
  //set the proper form
  String rightWidgetState = "";

  //generalized object for saving the type of concrete class in specialization
  Activity? activity = null;

  //default value for choosing which program wanna add
  String value = "Training";

  //public indicator
  bool isChecked = false;

  //list of program activities
  List<Activity> listActivities = [];

  GlobalKey addActivityKey = GlobalKey();

  //handle choosing item for adding program
  void handleChangedItem(Object? value) {
    activity = null;
    this.value = value.toString();
    setState(() {
      rightWidgetState = value.toString();
      listActivities.clear();
    });
  }

  //callback from child component to get form data and setting our parent ACTIVITY object on concrete type
  void handleChangeFormFields(Activity? act) {
    activity = act;
  }

  //saving program with list of activities
  void handleSaveProgram() async {
    var response = await http.post(
        Uri.parse("${MyApp.api}/program"),
        headers: {"Content-Type" : "application/json"},
        body: jsonEncode({
          "naziv" : this.value,
          "datum" : "${DateFormat('yyyy-MM-ddTHH:mm:ssZ').format(DateTime.now())}Z",
          "public" : isChecked,
          "clanId" : (await SharedPreferences.getInstance()).getInt("userId"),
          "listaAktivnosti" : listActivities,
        })
    );

    if(response.statusCode == 201){
            listActivities.clear();
            Navigator.pop(context);
            Utils.showToastSnackBar(context, "Program is created successfully.", Colors.green, 'OK');
    }
  }

  //putting right form depending on choosed program in list box
  Widget putRightWidget() {
    switch (rightWidgetState) {
      case "Training":
        return TrainingForm(onChanged: handleChangeFormFields);
      case "Food":
        return FoodForm(onChanged: handleChangeFormFields);
      case "Supplements":
        return SupplementForm(onChanged: handleChangeFormFields);
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      title: const Text("Adding Program",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.w600,
              fontFamily: "Raleway")),
      content: SizedBox(
        height: MediaQuery.of(context).size.height - 100,
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            children: [
              //------------------Choosing program
              const Text(
                "Choose program",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Raleway"),
              ),
              const SizedBox(
                height: 15,
              ),
              //--------------------List box for programs and public indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /*

                  List box
                   */
                  Container(
                    margin: const EdgeInsets.only(right: 15.0),
                    width: MediaQuery.of(context).size.width - 250,
                    child: DecoratedDropdownButton(
                      value: this.value,
                      items: const [
                        DropdownMenuItem(
                          value: "Training",
                          child: Text("Training"),
                        ),
                        DropdownMenuItem(
                          value: "Food",
                          child: Text("Food"),
                        ),
                        DropdownMenuItem(
                          value: "Supplements",
                          child: Text("Supplements"),
                        )
                      ],
                      onChanged: handleChangedItem,
                      color: const Color(0xFFF89A1C),
                      //background color
                      borderRadius: BorderRadius.circular(25),
                      //border radius
                      style: const TextStyle(
                          //text style
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Raleway"),
                      icon: const Icon(Icons.keyboard_arrow_down_rounded),
                      //icon
                      iconEnableColor: Colors.white,
                      //icon enable color
                      dropdownColor: Colors.orange,
                    ),
                  ),
                  /*

                  Check box
                  */
                  Flexible(
                    child: Transform.scale(
                      scale: 1.3,
                      child: CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        controlAffinity: ListTileControlAffinity.leading,
                        checkColor: Colors.black,
                        activeColor: const Color(0xFFF89A1C),
                        side: const BorderSide(
                          color: Colors.white,
                          width: 1.2,
                        ),
                        title: Transform.translate(
                          offset: const Offset(-20, 0),
                          child: const Text(
                            "Public",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 11,
                                fontFamily: "Raleway"),
                          ),
                        ),
                        value: isChecked,
                        onChanged: (bool? value) {

                          setState(() {
                            isChecked = value!;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              //---------------------------------------

              /*

              Form fields
               */
              putRightWidget(),

              const SizedBox(
                height: 20,
              ),

              /*

              Add activity button
               */
              GestureDetector(
                onTap: () {
                  setState(() {
                    if(activity == null){
                      Utils.showToastSnackBar(context, "Values are not correct.", Colors.red[400], 'OK');
                    }else {
                      if (activity.runtimeType.toString() == "Training") {
                        listActivities.add(Training(
                          vezba: (activity as Training).vezba,
                          vezbaId: (activity as Training).vezba.exerciseId,
                          brojSerija: (activity as Training).brojSerija,
                          kilaza: (activity as Training).kilaza,
                          activityType: activity?.activityType,
                        ));
                      } else if (activity.runtimeType.toString() == "Food") {
                        listActivities.add(Food(
                          naziv: (activity as Food).naziv,
                          brojKalorija: (activity as Food).brojKalorija,
                          activityType: activity?.activityType,
                        ));
                      } else if (activity.runtimeType.toString() ==
                          "Supplement") {
                        listActivities.add(Supplement(
                          naziv: (activity as Supplement).naziv,
                          activityType: activity?.activityType,
                          kolicina: (activity as Supplement).kolicina,
                        ));
                      }
                    }

                  });
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    height: 35,
                    width: 120,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white),
                    child: const Center(
                      child: Text(
                        "Add activity",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Raleway"),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 30,
                child: Divider(
                  color: Color(0xFFF89A1C),
                  thickness: 2,
                ),
              ),

              /*

              Listing activities
               */
              ListView.builder(
                itemCount: listActivities.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: ExpansionTile(
                      title: Text(
                        listActivities[index].runtimeType.toString() == "Training"
                            ? (listActivities[index] as Training).vezba.naziv
                            : listActivities[index].runtimeType.toString() == "Food"
                                ? (listActivities[index] as Food).naziv
                                : (listActivities[index] as Supplement).naziv,
                        style: const TextStyle(
                            fontFamily: "Raleway",
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFF89A1C)),
                      ),
                      leading: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: const Color(0xFFF89A1C),
                        ),
                        child: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Color(0xFF424242),
                        ),
                      ),
                      collapsedShape: const ContinuousRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      shape: const ContinuousRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      collapsedBackgroundColor: const Color(0xFF757575),
                      backgroundColor: const Color(0xFF656565),
                      controlAffinity: ListTileControlAffinity.leading,
                      children: <Widget>[
                        listActivities[index].runtimeType.toString() == "Training"
                            ? Column(
                                children: [
                                  ListTile(
                                      title: Text(
                                    "- Number of series : ${(listActivities[index] as Training).brojSerija}",
                                    style: const TextStyle(color: Colors.white),
                                  )),
                                  ListTile(
                                      title: Text(
                                    "- Kilograms : ${(listActivities[index] as Training).kilaza} kg",
                                    style: const TextStyle(color: Colors.white),
                                  ))
                                ],
                              )
                            : listActivities[index].runtimeType.toString() == "Food"
                                ? ListTile(
                                    title: Text(
                                    "- Kcal : ${(listActivities[index] as Food).brojKalorija}",
                                    style: const TextStyle(color: Colors.white),
                                  ))
                                : ListTile(
                                    title: Text(
                                    "- Amount : ${(listActivities[index] as Supplement).kolicina} g",
                                    style: const TextStyle(color: Colors.white),
                                  )),
                      ],
                    ),
                  );
                },
              ),

              const SizedBox(
                height: 35,
              ),

              /*

              Save program button
               */
              GestureDetector(
                onTap: handleSaveProgram,
                child: listActivities.isEmpty ? Container() : Container(
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
                      "Save",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Raleway"),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xFF424242),
    );
  }
}
