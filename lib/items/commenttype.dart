import 'package:flutter/material.dart';

String selectedValue = "General";

List<DropdownMenuItem<String>> get dropdownItems {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("General"), value: "General"),
    DropdownMenuItem(child: Text("Suggestion"), value: "Suggestion"),
    DropdownMenuItem(child: Text("Complaint"), value: "Complaint"),
  ];
  return menuItems;
}

class comment extends StatefulWidget {
  const comment({Key? key}) : super(key: key);

  @override
  State<comment> createState() => _commentState();
}

class _commentState extends State<comment> {
  List<DropdownMenuItem> menuItems = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Title(
            color: Colors.black,
            child: (Text(
              "Comment Type",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ))),
        DropdownButtonFormField(
            dropdownColor: Colors.white,
            value: selectedValue,
            onChanged: (String? newValue) {
              setState(() {
                selectedValue = newValue!;
              });
            },
            items: dropdownItems),
      ],
    );
  }
}
