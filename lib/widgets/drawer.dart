import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Toyoutdrawer extends StatelessWidget {
  const Toyoutdrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.red,
      child: ListView(
        children: const [
          ListTile(
            leading: Icon(CupertinoIcons.car_detailed),
            title: Text(
              'Toyota WorkShop',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            textColor: Colors.white,
            iconColor: Colors.white,
          ),
        ],
      ),
    );
  }
}