import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class FilePickerApp extends StatefulWidget {
  @override
  FilePickerAppState createState() => new FilePickerAppState();
}

class FilePickerAppState extends State<FilePickerApp> {
  late String fileName;
  late String path;
  late Map<String, String> paths;
  late List<String> extensions;
  bool isLoadingPath = false;
  bool isMultiPick = false;
  late FileType fileType;

  void _openFileExplorer() async {
    setState(() => isLoadingPath = true);
    try {
      if (isMultiPick) {
        path == null;
        paths = await FilePicker.GetMultiFilePath(
            fileType : FileType.any,
            allowedExtensions: extensions);
aklj      } else {
        path = await FilePicker.getFilePath(
            fileType : FileType.any,
            allowedExtensions: extensions);
        paths == null;
      }
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }
    if (!mounted) return;
    setState(() {
      isLoadingPath = false;
      fileName = path != null
          ? path.split('/').last
          : paths != null
              ? paths.keys.toString()
              : '...';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('File Picker example app'),
        ),
        body:  Center(
            child:  Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child:  SingleChildScrollView(
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                 Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child:  DropdownButton<dynamic>(
                      hint:  Text('Select file type'),
                      value: fileType,
                      items: <DropdownMenuItem>[
                        DropdownMenuItem(
                          child:  Text('Audio'),
                          value: FileType.audio,
                        ),
                         DropdownMenuItem(
                          child: new Text('Image'),
                          value: FileType.image,
                        ),
                        DropdownMenuItem(
                          child: new Text('Video'),
                          value: FileType.video,
                        ),
                         DropdownMenuItem(
                          child: new Text('Any'),
                          value: FileType.any,
                        ),
                      ],
                      onChanged: (value) => setState(() {
                            fileType = value;
                          })),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints.tightFor(width: 200.0),
                  child: SwitchListTile.adaptive(
                    title: Text('Pick multiple files',
                        textAlign: TextAlign.right),
                    onChanged: (bool value) =>
                        setState(() => isMultiPick = value),
                    value: isMultiPick,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50.0, bottom: 20.0),
                  child:  RaisedButton(
                    onPressed: () => _openFileExplorer(),
                    child: Text("Open file picker"),
                  ),
                ),
                Builder(
                  builder: (BuildContext context) => isLoadingPath
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: const CircularProgressIndicator())
                      : path != null || paths != null
                          ? Container(
                              padding: const EdgeInsets.only(bottom: 30.0),
                              height: MediaQuery.of(context).size.height * 0.50,
                              child: Scrollbar(
                                  child:  ListView.separated(
                                itemCount: paths != null && paths.isNotEmpty
                                    ? paths.length
                                    : 1,
                                itemBuilder: (BuildContext context, int index) {
                                  final bool isMultiPath =
                                      paths != null && paths.isNotEmpty;
                                  final int fileNo = index + 1;
                                  final String name = 'File $fileNo : ' +
                                      (isMultiPath
                                          ? paths.keys.toList()[index]
                                          : fileName);
                                  final filePath = isMultiPath
                                      ? paths.values.toList()[index].toString()
                                      : path;
                                  return ListTile(
                                    title: Text(
                                      name,
                                    ),
                                    subtitle: Text(filePath),
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        Divider(),
                              )),
                            )
                          : Container(),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
