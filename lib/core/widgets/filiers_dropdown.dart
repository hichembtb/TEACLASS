import 'package:flutter/material.dart';

class FilierDropDown extends StatefulWidget {
  const FilierDropDown({Key? key}) : super(key: key);

  @override
  State<FilierDropDown> createState() => _ParcourDropDownState();
}

class _ParcourDropDownState extends State<FilierDropDown> {
  Object? parcour;
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      hint: const Text('Filers'),
      value: parcour,
      items: ["MI", "ST", "SM"]
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
