import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FilePickerDemo extends StatefulWidget {
  @override
  _FilePickerDemoState createState() => _FilePickerDemoState();
}

class _FilePickerDemoState extends State<FilePickerDemo> {
  String? _fileName;
  List<PlatformFile>? _paths;
  String? _directoryPath;
  String? _extension;
  bool _loadingPath = false;
  bool _multiPick = false;
  FileType _pickingType = FileType.any;
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => _extension = _controller.text);
  }

  void _openFileExplorer() async {
    setState(() => _loadingPath = true);
    try {
      _directoryPath = null;
      _paths = (await FilePicker.platform.pickFiles(
        type: _pickingType,
        allowMultiple: _multiPick,
        allowedExtensions: (_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll(' ', '').split(',')
            : null,
      ))
          ?.files;
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    } catch (ex) {
      print(ex);
    }
    if (!mounted) return;
    setState(() {
      _loadingPath = false;
      print(_paths!.first.extension);
      _fileName =
          _paths != null ? _paths!.map((e) => e.name).toString() : '...';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Title(color: Colors.black,
            child: (Text(
              "Record Video or Audio",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ))),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: DropdownButton<FileType>(
                  value: _pickingType,
                  items: <DropdownMenuItem<FileType>>[
                    DropdownMenuItem(
                      child: const Text('FROM AUDIO'),
                      value: FileType.audio,
                    ),
                    DropdownMenuItem(
                      child: const Text('FROM IMAGE'),
                      value: FileType.image,
                    ),
                    DropdownMenuItem(
                      child: const Text('FROM VIDEO'),
                      value: FileType.video,
                    ),
                    DropdownMenuItem(
                      child: const Text('FROM ANY'),
                      value: FileType.any,
                    ),
                  ],
                  onChanged: (value) => setState(() {
                        _pickingType = value!;
                      })),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Column(
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () => _openFileExplorer(),
                    child: const Text("Pick Files"),
                  ),
                ],
              ),
            ),
            Builder(
              builder: (BuildContext context) => _loadingPath
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: const CircularProgressIndicator(),
                    )
                  : _directoryPath != null
                      ? ListTile(
                          title: const Text('Directory path'),
                          subtitle: Text(_directoryPath!),
                        )
                      : _paths != null
                          ? Container(
                              padding: const EdgeInsets.only(bottom: 30.0),
                              height: MediaQuery.of(context).size.height * 0.50,
                              child: Scrollbar(
                                  child: ListView.separated(
                                itemCount: _paths != null && _paths!.isNotEmpty
                                    ? _paths!.length
                                    : 1,
                                itemBuilder: (BuildContext context, int index) {
                                  final bool isMultiPath =
                                      _paths != null && _paths!.isNotEmpty;
                                  final String name = 'File $index: ' +
                                      (isMultiPath
                                          ? _paths!
                                              .map((e) => e.name)
                                              .toList()[index]
                                          : _fileName ?? '...');
                                  final path = _paths!
                                      .map((e) => e.path)
                                      .toList()[index]
                                      .toString();

                                  return ListTile(
                                    title: Text(
                                      name,
                                    ),
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        const Divider(),
                              )),
                            )
                          : const SizedBox(),
            ),
          ],
        ),
      ),
    ));
  }
}
