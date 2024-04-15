import 'package:flutter/material.dart';
import 'package:decorated_dropdownbutton/decorated_dropdownbutton.dart';
import 'package:flutter/services.dart';
import 'package:mt_activity_management/model/supplement.dart';

class SupplementForm extends StatefulWidget {
  const SupplementForm({super.key, required this.onChanged});

  final void Function(Supplement?) onChanged;

  @override
  State<SupplementForm> createState() => _SupplementFormState();
}

class _SupplementFormState extends State<SupplementForm> {
  final TextEditingController supplementController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final Supplement supp = Supplement(naziv: "", kolicina: 0);

  String? nameError;
  String? amountError;

  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter a name.';
    }
    return null;
  }

  String? validateAmount(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter an amount.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    nameError = validateName(supplementController.text);
    amountError = validateAmount(amountController.text);

    return Column(
      children: [
        //---------------------------------------------------------------------
        const SizedBox(
          height: 15,
        ),
        const Text("Supplement name",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w600,
                fontFamily: "Raleway")),
        SizedBox(
          height: 55,
          child: TextField(
            onChanged: (value) {
              nameError = validateName(supplementController.text);
              amountError = validateAmount(amountController.text);
              setState(() {
                supp.naziv = supplementController.text.trim();
                supp.activityType = "Suplement";

                if (nameError != null || amountError != null)
                  widget.onChanged(null);
                else
                  widget.onChanged(supp);
              });
            },
            controller: supplementController,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              contentPadding:
              const EdgeInsets.only(
                left: 10.0,),
              filled: true,
              fillColor: Colors.white,
              hintText: "Enter name of supplements.",
              hintStyle: TextStyle(
                fontSize: 16.0,
                color: Colors.black.withOpacity(0.35),
              ),
            ),

          ),
        ),
        Text(
          nameError == null ? "" : nameError.toString(),
          style: const TextStyle(color: Colors.red, fontSize: 13),
        ),
        const SizedBox(
          height: 15,
        ),
        const Text("Amount",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w600,
                fontFamily: "Raleway")),
        SizedBox(
          height: 55,
          child: TextField(
            onChanged: (value) {
              setState(() {
                amountController.text != "" ?  supp.kolicina = (int.parse(amountController.text) as num).toDouble() : "";
                supp.activityType = "Suplement";
                widget.onChanged(supp);

                nameError = validateName(supplementController.text);
                amountError = validateAmount(amountController.text);

                if (nameError != null || amountError != null)
                  widget.onChanged(null);
                else
                  widget.onChanged(supp);
              });
            },
            controller: amountController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              contentPadding:
              const EdgeInsets.only(
                left: 10.0,),
              filled: true,
              fillColor: Colors.white,
              hintText: "Enter an amount of supplements in grams.",
              hintStyle: TextStyle(
                fontSize: 16.0,
                color: Colors.black.withOpacity(0.35),
              ),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
          ),
        ),
        Text(
          amountError == null ? "" : amountError.toString(),
          style: const TextStyle(color: Colors.red, fontSize: 13),
        ),
        //-------------------------------------------------------------------------
      ],
    );
  }
}
