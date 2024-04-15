import 'dart:convert';

import 'package:decorated_dropdownbutton/decorated_dropdownbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mt_activity_management/main.dart';
import 'package:mt_activity_management/model/exercise.dart';
import 'package:http/http.dart' as http;
import 'package:mt_activity_management/model/training.dart';

class TrainingForm extends StatefulWidget {
  const TrainingForm({super.key, required this.onChanged});

  final void Function(Training?) onChanged;

  @override
  State<TrainingForm> createState() => _TrainingFormState();
}

class _TrainingFormState extends State<TrainingForm> {
  List<Exercise> listExercises = [];
  final TextEditingController numberSeriesController = TextEditingController();
  final TextEditingController kilogramsController = TextEditingController();
  Exercise selectedExercise = Exercise(naziv: "");
  final Training training = Training(
      brojSerija: 0, kilaza: 0, vezba: Exercise(naziv: "", exerciseId: 0));

  String? numberSeriesError;
  String? weightError;

  String? validateNumberSeries(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a number.';
    }
    return null;
  }

  String? validateWeight(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a weight.';
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    getExercises().then((value) {
      setState(() {
        List<dynamic> jsonList = json.decode(value.body);
        listExercises = jsonList
            .map((json) => Exercise(
                  exerciseId: json['VezbaId'],
                  naziv: json['Naziv'],
                ))
            .toList();
        selectedExercise = listExercises[0];
      });
    });
  }

  Future<http.Response> getExercises() async {
    return await http.get(Uri.parse("${MyApp.api}/exercises"));
  }

  @override
  Widget build(BuildContext context) {
    numberSeriesError = validateNumberSeries(numberSeriesController.text);
    weightError = validateWeight(kilogramsController.text);

    return Column(
      children: [
        const SizedBox(height: 15),
        const Text(
          "Exercise",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w600,
            fontFamily: "Raleway",
          ),
        ),
        DecoratedDropdownButton(
          value: listExercises.isNotEmpty ? selectedExercise : "",
          items: listExercises.isNotEmpty
              ? buildDropdownItems()
              : [
                  DropdownMenuItem(
                    value: listExercises.isNotEmpty
                        ? selectedExercise.toString()
                        : "",
                    child: const Text(""),
                  )
                ],
          onChanged: (value) {
            numberSeriesError = validateNumberSeries(numberSeriesController.text);
            weightError = validateWeight(kilogramsController.text);

            setState(() {
              selectedExercise = value as Exercise;
              training.vezbaId = selectedExercise.exerciseId;
              training.vezba = selectedExercise;
              training.activityType = "Teretana";
              if (numberSeriesError != null || weightError != null)
                widget.onChanged(null);
              else
                widget.onChanged(training);
            });
          },
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w500,
            fontFamily: "Raleway",
          ),
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          iconEnableColor: Colors.black,
          dropdownColor: Colors.orange,
        ),
        const SizedBox(height: 15),
        const Text(
          "Number of series",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w600,
            fontFamily: "Raleway",
          ),
        ),
        SizedBox(
          height: 55,
          child: TextField(
            onChanged: (value) {
              numberSeriesError = validateNumberSeries(numberSeriesController.text);
              weightError = validateWeight(kilogramsController.text);

              setState(() {
                training.vezbaId = selectedExercise.exerciseId;
                training.vezba = selectedExercise;
                training.brojSerija =
                    int.tryParse(numberSeriesController.text) ?? 0;
                training.activityType = "Teretana";
                if (numberSeriesError != null || weightError != null)
                  widget.onChanged(null);
                else
                  widget.onChanged(training);
              });
            },
            controller: numberSeriesController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              contentPadding:
              const EdgeInsets.only(
                left: 10.0,),
              filled: true,
              fillColor: Colors.white,
              hintText: "Enter a number of your series.",
              hintStyle: TextStyle(
                fontSize: 16.0,
                color: Colors.black.withOpacity(0.35),
              ),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
        ),
        Text(
          numberSeriesError == null ? "" : numberSeriesError.toString(),
          style: const TextStyle(color: Colors.red, fontSize: 13),
        ),
        const SizedBox(height: 15),
        const Text(
          "Kilograms",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w600,
            fontFamily: "Raleway",
          ),
        ),
        SizedBox(
          height: 55,
          child: TextField(
            onChanged: (value) {
              setState(() {
                training.kilaza = (int.parse(kilogramsController.text) as num).toDouble();
                training.activityType = "Teretana";
                if (numberSeriesError != null || weightError != null)
                  widget.onChanged(null);
                else
                  widget.onChanged(training);
              });
            },
            controller: kilogramsController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              contentPadding:
              const EdgeInsets.only(
                left: 10.0,),
              filled: true,
              fillColor: Colors.white,
              hintText: "Enter a weight of your exercise.",
              hintStyle: TextStyle(
                fontSize: 16.0,
                color: Colors.black.withOpacity(0.35),
              ),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
        ),
        Text(
          weightError == null ? "" : weightError.toString(),
          style: const TextStyle(color: Colors.red, fontSize: 13),
        ),
      ],
    );
  }

  List<DropdownMenuItem<Exercise>> buildDropdownItems() {
    return listExercises.map((exercise) {
      return DropdownMenuItem(
        value: exercise,
        child: Text(exercise.naziv),
      );
    }).toList();
  }
}
