import 'package:flutter/material.dart';

class BrancheDropdown extends StatefulWidget {
  const BrancheDropdown({Key? key}) : super(key: key);

  @override
  State<BrancheDropdown> createState() => _BrancheDropdownState();
}

class _BrancheDropdownState extends State<BrancheDropdown> {
  Object? branche;
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      hint: const Text('Branche'),
      value: branche,
      items: ["MI", "Info"]
          .map(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(e),
            ),
          )
          .toList(),
      onChanged: (value) {
        setState(() {
          branche = value;
        });
      },
    );
  }
}
