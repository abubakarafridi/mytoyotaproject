import 'package:flutter/material.dart';
import 'package:flutter_toyota/items/Commentbox.dart';
import 'package:flutter_toyota/items/commenttype.dart';
import 'package:flutter_toyota/items/drawer.dart';
import 'package:flutter_toyota/items/file.dart';

class Remarks extends StatelessWidget {
  const Remarks({Key? key}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const Toyoutdrawer(),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'Remarks',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.red),
        ),
        body: SingleChildScrollView(child: Column(children: [comment(),commentbox(),FilePickerDemo()])),
          
            );
  }
}
