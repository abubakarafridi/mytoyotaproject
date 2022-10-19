import 'dart:developer';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_toyota/items/audio/audio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;


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

            log('VideoPath:  ${video?.readAsBytes()} ');
            String path = video?.path ?? '';

            File imageFile = new File(path);
            List<int> imageBytes = imageFile.readAsBytesSync();
            String base64Image = base64Encode(imageBytes);

            log("BASE64 $base64Image");



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

Future<bool> uploadVideo(String videoJSON) async
  {
    log('updateDrivers Val: $videoJSON ');
    //log('uploadVideo Called');
    EasyLoading.show(status: "Please Wait...");
    bool hasNetwork = await helper().hasNetwork();
    bool isAuthenticated = false;

    if (hasNetwork) {

      final url = Uri.parse("");
      //log('hasNetwork1 Called');

      try {
        final response = await http.post(
          url,
          headers: {
            "Content-Type": "application/json"},
             body: json.encode(        {
            "videoJson": videoJSON,
          
          }),
        );
        //log('hasNetwork2 Called');

        if (response.statusCode == 200) {
          //log('response200 Called');

          //final jsonDecoded = jsonDecode(response.body);
          //String message = jsonDecoded['Message'];
          //log(_token);

          EasyLoading.dismiss();
          EasyLoading.showToast("Uploaded!",duration: const Duration(milliseconds: 2000),toastPosition: EasyLoadingToastPosition.bottom);
          //log('Data : $message  $token' );
          isAuthenticated = true;
        }
        else{
          EasyLoading.dismiss();
          //final responseData = json.decode(response.body);
          //String errorMessage = responseData['Message'];
          EasyLoading.showError(dismissOnTap: true,duration: const Duration(milliseconds: 3500), response.statusCode.toString());

          log('!response200 Called}');
        }
      } catch (error) {
        EasyLoading.dismiss();
        EasyLoading.showError(duration: const Duration(milliseconds: 3500), 'Could not update, try again later..\n$error');
        log('Error Called $error');

        isAuthenticated = false;
      }
    }
    else {
      EasyLoading.showError(duration: const Duration(milliseconds: 3500), 'Network issue, try again later.');
      log('!hasNetwork Called');
    }
    return isAuthenticated;
  }

class helper{
   Future<bool> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      //print('FuncHN+ $result');

      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException {
      //print('FuncHN- $error');
      return false;
    }
  }
}


