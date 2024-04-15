import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mt_activity_management/model/food.dart';

class FoodForm extends StatefulWidget {
  const FoodForm({super.key, required this.onChanged});

  final void Function(Food?) onChanged;

  @override
  State<FoodForm> createState() => _FoodFormState();
}

class _FoodFormState extends State<FoodForm> {
  final TextEditingController mealController = TextEditingController();
  final TextEditingController kcalController = TextEditingController();

  final Food food = Food(naziv: "", brojKalorija: 0);
  String? mealError;
  String? kcalError;

  String? validateMeal(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a name of your meal.';
    }
    return null;
  }

  String? validateKcal(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an amount.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    mealError = validateMeal(mealController.text);
    kcalError = validateKcal(kcalController.text);

    return Column(
      children: [
        const SizedBox(height: 15),
        const Text(
          "Meal",
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
          child: Stack(
            children: [
              TextFormField(
                controller: mealController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  contentPadding:
                  const EdgeInsets.only(
                      left: 10.0,),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Enter a name of your meal.",
                  hintStyle: TextStyle(
                      fontSize: 16.0, color: Colors.black.withOpacity(0.35)),
                ),
                validator: validateMeal,
                onChanged: (value) {
                  setState(() {
                    food.naziv = value;
                    food.activityType = "Hrana";
                    if(kcalError != null || mealError != null) widget.onChanged(null);
                    else
                      widget.onChanged(food);
                  });
                },
              ),
              Positioned(
                right: 0,
                bottom: 6,
                child: mealError != null
                    ? Tooltip(
                        message: mealError!,
                        child: IconButton(
                          icon: const Icon(Icons.error, color: Colors.red),
                          onPressed: () {},
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
        Text(
          mealError == null ? "" : mealError.toString(),
          style: const TextStyle(color: Colors.red, fontSize: 13),
        ),
        const SizedBox(height: 15),
        const Text(
          "KCal",
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
          child: Stack(children: [
            TextFormField(
              controller: kcalController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                contentPadding:
                const EdgeInsets.only(
                    left: 10.0,),
                filled: true,
                fillColor: Colors.white,
                hintText: "Enter an amount of calories.",
                hintStyle: TextStyle(
                    fontSize: 16.0, color: Colors.black.withOpacity(0.35)),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              validator: validateKcal,
              onChanged: (value) {
                setState(() {
                  food.brojKalorija = int.tryParse(value) ?? 0;
                  food.activityType = "Hrana";
                  if(kcalError != null && mealError != null) widget.onChanged(null);
                  else
                    widget.onChanged(food);
                });
              },
            ),
            Positioned(
              right: 0,
              bottom: 6,
              child: kcalError != null
                  ? Tooltip(
                      message: kcalError!,
                      child: IconButton(
                        icon: const Icon(Icons.error, color: Colors.red),
                        onPressed: () {},
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ]),
        ),
        Text(
          kcalError == null ? "" : kcalError.toString(),
          style: const TextStyle(
              color: Colors.red, fontSize: 13, fontFamily: "Raleway"),
        ),
      ],
    );
  }
}
