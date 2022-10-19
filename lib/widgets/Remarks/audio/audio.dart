import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:record/record.dart';
import 'package:http/http.dart' as http;

class AudioRecorder extends StatefulWidget {
  @override
  _AudioRecorderState createState() => _AudioRecorderState();
}

class _AudioRecorderState extends State<AudioRecorder> {
  int _recordDuration = 0;
  Timer? _timer;
  final _audioRecorder = Record();
  StreamSubscription<RecordState>? _recordSub;
  RecordState _recordState = RecordState.stop;

  @override
  void initState() {
    _recordSub = _audioRecorder.onStateChanged().listen((recordState) {
      setState(() => _recordState = recordState);
    });
    super.initState();
  }

  Future<void> _start() async {
    try {
      if (await _audioRecorder.hasPermission()) {
        // We don't do anything with this but printing
        final isSupported = await _audioRecorder.isEncoderSupported(
          AudioEncoder.aacLc,
        );
        if (kDebugMode) {
          print('${AudioEncoder.aacLc.name} supported: $isSupported');
        }

        // final devs = await _audioRecorder.listInputDevices();
        // final isRecording = await _audioRecorder.isRecording();

        await _audioRecorder.start();
        _recordDuration = 0;

        _startTimer();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> _stop() async {
    _timer?.cancel();
    _recordDuration = 0;

    final path = await _audioRecorder.stop();

    File audioFile = new File(path!);
    List<int> audioBytes = audioFile.readAsBytesSync();
    String base64audio = base64Encode(audioBytes);

    log("BASE64 $base64audio");
  }

  Future<void> _pause() async {
    _timer?.cancel();
    await _audioRecorder.pause();
  }

  Future<void> _resume() async {
    _startTimer();
    await _audioRecorder.resume();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _buildRecordStopControl(),
                    const SizedBox(width: 20),
                    _buildPauseResumeControl(),
                    const SizedBox(width: 40),
                    _buildTimer(),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _recordSub?.cancel();
    _audioRecorder.dispose();
    super.dispose();
  }

  Widget _buildRecordStopControl() {
    late Icon icon;
    late Color color;

    if (_recordState != RecordState.stop) {
      icon = const Icon(Icons.stop, color: Colors.red, size: 30);
      color = Colors.red.withOpacity(0.1);
    } else {
      final theme = Theme.of(context);
      icon = Icon(Icons.mic, color: theme.primaryColor, size: 30);
      color = theme.primaryColor.withOpacity(0.1);
    }

    return ClipOval(
      child: Material(
        color: color,
        child: InkWell(
          child: SizedBox(width: 56, height: 56, child: icon),
          onTap: () {
            (_recordState != RecordState.stop) ? _stop() : _start();
          },
        ),
      ),
    );
  }

  Widget _buildPauseResumeControl() {
    if (_recordState == RecordState.stop) {
      return const SizedBox.shrink();
    }

    late Icon icon;
    late Color color;

    if (_recordState == RecordState.record) {
      icon = const Icon(Icons.pause, color: Colors.red, size: 30);
      color = Colors.red.withOpacity(0.1);
    } else {
      final theme = Theme.of(context);
      icon = const Icon(Icons.play_arrow, color: Colors.red, size: 30);
      color = theme.primaryColor.withOpacity(0.1);
    }

    return ClipOval(
      child: Material(
        color: color,
        child: InkWell(
          child: SizedBox(width: 56, height: 56, child: icon),
          onTap: () {
            (_recordState == RecordState.pause) ? _resume() : _pause();
          },
        ),
      ),
    );
  }

  Widget _buildTimer() {
    final String minutes = _formatNumber(_recordDuration ~/ 60);
    final String seconds = _formatNumber(_recordDuration % 60);

    return Text(
      '$minutes : $seconds',
      style: const TextStyle(color: Colors.red, fontSize: 58),
    );
  }

  String _formatNumber(int number) {
    String numberStr = number.toString();
    if (number < 10) {
      numberStr = '0' + numberStr;
    }

    return numberStr;
  }

  void _startTimer() {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() => _recordDuration++);
    });
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? audioPath;

  @override
  Widget build(BuildContext context) {
    return AudioRecorder();
  }
}

Future<bool> uploadaudio(String audioJSON) async {
  log('updateDrivers Val: $audioJSON ');
  //log('uploadVideo Called');
  EasyLoading.show(status: "Please Wait...");
  bool hasNetwork = await helper().hasNetwork();
  bool isAuthenticated = false;

  if (hasNetwork) {
    //log('hasNetwork Called ${dotenv.env['Login']}');

    final url = Uri.parse("");
    //log('hasNetwork1 Called');

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "audioJson": audioJSON,
        }),
      );
      //log('hasNetwork2 Called');

      if (response.statusCode == 200) {
        //log('response200 Called');

        //final jsonDecoded = jsonDecode(response.body);
        //String message = jsonDecoded['Message'];
        //log(_token);

        EasyLoading.dismiss();
        EasyLoading.showToast("Uploaded!",
            duration: const Duration(milliseconds: 2000),
            toastPosition: EasyLoadingToastPosition.bottom);
        //log('Data : $message  $token' );
        isAuthenticated = true;
      } else {
        EasyLoading.dismiss();
        //final responseData = json.decode(response.body);
        //String errorMessage = responseData['Message'];
        EasyLoading.showError(
            dismissOnTap: true,
            duration: const Duration(milliseconds: 3500),
            response.statusCode.toString());

        log('!response200 Called}');
      }
    } catch (error) {
      EasyLoading.dismiss();
      EasyLoading.showError(
          duration: const Duration(milliseconds: 3500),
          'Could not update, try again later..\n$error');
      log('Error Called $error');

      isAuthenticated = false;
    }
  } else {
    EasyLoading.showError(
        duration: const Duration(milliseconds: 3500),
        'Network issue, try again later.');
    log('!hasNetwork Called');
  }
  return isAuthenticated;
}

class helper {
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
