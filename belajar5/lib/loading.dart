import 'package:belajar5/admin/homeAdmin.dart';
import 'package:belajar5/login.dart';
import 'package:belajar5/user/homeUser.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:drop_shadow/drop_shadow.dart';
import 'package:shared_preferences/shared_preferences.dart';

class loading extends StatefulWidget {
  _loading createState() => _loading();
}

class _loading extends State<loading> {
  void initState() {
    super.initState();
    splashStart();
  }

  Future splashStart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? conditionValue = prefs.getInt('_conditionValue') ?? 0;

    if (conditionValue == 0) {
      var duration = const Duration(seconds: 3);
      return Timer(duration, () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Login()),
        );
      });
    } else if (conditionValue == 1) {
      var duration = const Duration(seconds: 3);
      return Timer(duration, () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeAdmin()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/Logo_DriveR.png',
              width: 200,
              height: 200,
            ),
            SizedBox(
              height: 24.0,
            ),
            Align(
              alignment: FractionalOffset.topCenter,
              child: Container(
                width: 130,
                margin: const EdgeInsets.fromLTRB(0, 30.0, 0, 0),
                decoration: const BoxDecoration(
                  color: Colors.white12,
                ),
                child: const DropShadow(
                  blurRadius: 2,
                  offset: Offset(0, 4),
                  spread: 0,
                  child: Text(
                    'DriveR',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Outfit',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
