import 'package:flutter/material.dart';
import 'package:flutter_toyota/items/drawer.dart';
import 'package:flutter_toyota/items/stars.dart';
import 'package:flutter_toyota/pages/advisor.dart';

class DealearShip extends StatelessWidget {
  const DealearShip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Toyoutdrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Dealership',
          style: TextStyle(
            color: Colors.red,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.red),
      ),
      body:
      ListView(

  children: <Widget>[
    Card(
      child: Container(
        height: 180,
        color: Colors.white,
        child:
        Column(
          children: [
            Title(color: Colors.red, child:const Text("Management",style:TextStyle(fontSize: 22,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)),
            SizedBox(height: 30,),
            Expanded(child: stars()),
          ],
        ),  
        ),
    ),
    Card(
      child: Container(
        height: 180,
        color: Colors.white,
        child:
        Column(
          children: [
            Title(color: Colors.red, child:const Text("Services",style:TextStyle(fontSize: 22,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)),
            SizedBox(height: 30,),
            Expanded(child: stars()),
          ],
        ), 
      ),
    ),
    Card(
      child: Container(
        height: 180,
        color: Colors.white,
        child:
        Column(
          children: [
            Title(color: Colors.red, child:const Text("Prices",style:TextStyle(fontSize: 22,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)),
            SizedBox(height: 30,),
            Expanded(child: stars()),
          ],
        ),
        ),
    ),
    Card(
      child: Container(
        height: 180,
        color: Colors.white, 
     child:
        Column(
          children: [
            Title(color: Colors.red, child:const Text("Cleanance",style:TextStyle(fontSize: 22,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)),
            SizedBox(height: 30,),
            Expanded(child: stars()),
          ],
        ),
       ),
    ),
    TextButton.icon(
  label: Text('NEXT'),
  icon: Icon(Icons.navigate_next),
  onPressed: () {
    Navigator.push(  
    context,  
    MaterialPageRoute(builder: (context) => Advisor()),  
  );  
  },
),
 ],
      )
      
);

  }
}