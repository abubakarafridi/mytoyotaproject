import 'package:flutter/material.dart';
import 'package:flutter_toyota/widgets/drawer.dart';
import 'package:flutter_toyota/widgets/dealership/stars.dart';
import 'package:flutter_toyota/screens/Remarks.dart';

class Advisor extends StatelessWidget {
  const Advisor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Toyoutdrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Service Advisor',
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
        color: Colors.blueGrey,
        child:
        Column(
          children: [
            Title(color: Colors.red, child:const Text("Behaviour",style:TextStyle(fontSize: 22,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)),
            SizedBox(height: 30,),
            Expanded(child: stars()),
          ],
        ),  
        ),
    ),
    Card(
      child: Container(
        height: 180,
        color: Colors.blueGrey,
        child:
        Column(
          children: [
            Title(color: Colors.red, child:const Text("Professionalism",style:TextStyle(fontSize: 22,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)),
            SizedBox(height: 30,),
            Expanded(child: stars()),
          ],
        ), 
      ),
    ),
    Card(
      child: Container(
        height: 180,
        color: Colors.blueGrey,
        child:
        Column(
          children: [
            Title(color: Colors.red, child:const Text("Technical Expertise",style:TextStyle(fontSize: 22,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)),
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
    MaterialPageRoute(builder: (context) => Remarks()),  
  );  
  },
),
 ],
      )
      
);

  }
}