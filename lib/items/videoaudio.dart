import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_toyota/items/audio/audio.dart';
import 'package:image_picker/image_picker.dart';


File? fil;
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return videoaudio();
  }
}

class videoaudio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Title(
            color: Colors.black,
            child: (Text(
              "Record Video or Audio",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ))),
        Container(
          height: 15,
        ),
        SizedBox(
          height: 40,
          width: 1360,
          child: ElevatedButton(
            child: Text(
              'Video/Audio',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => _buildPopupDialog(context),
              );
            },
          ),
        ), 
      ],
    );
  }
}

Widget _buildPopupDialog(BuildContext context) {
  return AlertDialog(
    insetPadding: EdgeInsets.all(10),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.videocam,
          ),
          onPressed: () async {
            final ImagePicker _picker = ImagePicker();
            final XFile? video =
                await _picker.pickVideo(source: ImageSource.camera);
          },
        ),
        SizedBox(
          height: 12,
        ),
        Title(
          color: Colors.black,
          child: Text('Record Video'),
        ),
        SizedBox(
          height: 2,
        ),
        Divider(
          thickness: 3,
          indent: 20,
          endIndent: 20,
          color: Colors.black,
          height: 30,
        ),
        IconButton(
            icon: Icon(Icons.keyboard_voice),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AudioRecorder()),
              );
            }),
        SizedBox(
          height: 12,
        ),
        Title(color: Colors.white, child: Text('Record Audio')),
      ],
    ),
    actions: <Widget>[
      ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('Close'),
      ),
    ],
  );
}
