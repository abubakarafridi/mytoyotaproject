import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_toyota/items/classJson.dart';
import 'package:flutter_toyota/items/drawer.dart';
import 'package:flutter_toyota/pages/DealearShip.dart';
import 'package:http/http.dart' as http;

Future<List<ToyotaModelClass>> fetchData() async {
  final response =
      await http.get(Uri.parse('http://192.168.1.163/apps/ratting.php'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => ToyotaModelClass.fromJson(data)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}

class index extends StatefulWidget {
  const index({Key? key}) : super(key: key);

  @override
  State<index> createState() => _indexState();
}

class _indexState extends State<index> {
  List<ToyotaModelClass> futureData = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) {
      setState(() {
        fetchData().then((value) {
          setState(() {
            futureData = value;
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Toyoutdrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Panding Rating ',
          style: TextStyle(
            color: Colors.red,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.red),
      ),
      body: Center(
        child: futureData.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: futureData.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 75,
                    color: Colors.white,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Card(
                          child: InkWell(
                            onTap: () {  
  Navigator.push(  
    context,  
    MaterialPageRoute(builder: (context) => DealearShip()),  
  );  
}, 
                            child: ListTile( 
                              leading: const Icon(
                                Icons.account_circle,
                                size: 30,
                                color: Colors.blue,
                              ),
                              title: Text(
                                futureData[index].customerName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                              subtitle: Text(
                                futureData[index].vehRegNo,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                              trailing: Text(
                                futureData[index].sa,
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                })
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
