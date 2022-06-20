import 'package:flutter/material.dart';

class GroupesDropdown extends StatefulWidget {
  const GroupesDropdown({
    Key? key,
    this.value,
    this.items,
    this.onChanged,
  }) : super(key: key);
  final Object? value;
  final List<DropdownMenuItem<Object>>? items;
  final void Function(Object?)? onChanged;
  @override
  State<GroupesDropdown> createState() => _GroupesDropdownState();
}

class _GroupesDropdownState extends State<GroupesDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      hint: const Text('Groupe'),
      value: widget.value,
      items: widget.items,
      onChanged: widget.onChanged,
    );
  }
}
