import 'package:flutter/material.dart';

class commentbox extends StatefulWidget {
  const commentbox({Key? key}) : super(key: key);

  @override
  State<commentbox> createState() => _commentboxState();
}

class _commentboxState extends State<commentbox> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Title(
            color: Colors.black,
            child: (Text(
              "Message",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ))),
        TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Field is required*';
            }
            return null;
          },
          onChanged: (value) {},
          minLines: 4,
          maxLines: 8,
        ),
      ],
    );
  }
}
