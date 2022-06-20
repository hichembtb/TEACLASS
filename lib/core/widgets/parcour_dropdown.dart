import 'package:flutter/material.dart';

class ParcourDropDown extends StatefulWidget {
  const ParcourDropDown({Key? key}) : super(key: key);

  @override
  State<ParcourDropDown> createState() => _ParcourDropDownState();
}

class _ParcourDropDownState extends State<ParcourDropDown> {
  Object? parcour;
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      hint: const Text('Parcour'),
      value: parcour,
      items: ["L1", "L2", "L3"]
          .map(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(e),
            ),
          )
          .toList(),
      onChanged: (value) {
        setState(() {
          parcour = value;
        });
      },
    );
  }
}
