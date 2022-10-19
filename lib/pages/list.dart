import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_toyota/items/classJson.dart';
import 'package:flutter_toyota/items/drawer.dart';
import 'package:flutter_toyota/pages/DealearShip.dart';
import 'package:http/http.dart' as http;


Future<List<ToyotaModelClass>> fetchCustomer() async
  {
    //log.d('getDriverListCustomerWise has been called! $customerId $token');
    bool hasNetwork = await helper().hasNetwork();
    EasyLoading.show(status: "Please Wait...");

    if (hasNetwork) {
      final url = Uri.parse('http://192.168.1.163/apps/ratting.php');

      try {
        var response = await http.get(
          url,
          headers: {
            "Content-Type": "application/json",
          },
        );
        log('Data is loading');
        //var data = json.decode(response.body);

        if (response.statusCode == 200) {
          log('customerList: 200');
          log(response.body);
          final List<ToyotaModelClass> customerList = toyotaModelClassFromJson(response.body);
          log('customerList: ${customerList.length}');
          EasyLoading.dismiss();
          
          return customerList;
        }
        else{
          EasyLoading.dismiss();
          EasyLoading.showError(duration: const Duration(milliseconds: 3500), 'Could not Fetch, try again later.\n${response.statusCode}');

          log('customerListResponse: ${response.statusCode}');
        }
      }
      catch (error){
        EasyLoading.dismiss();
        EasyLoading.showError(duration: const Duration(milliseconds: 3500), 'Could not Fetch, try again later.\n$error');
        log('customerListAPI:Error $error');
      }
    }
    return [];
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
        fetchCustomer().then((value) {
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