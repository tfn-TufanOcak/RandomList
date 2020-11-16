import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:random_list/sociallogin.dart';

class LoginScreen extends StatefulWidget {
  createState() => LoginScreenState();
}


class LoginScreenState extends State<LoginScreen> {
  final _scaffoldKeyLogin = GlobalKey<ScaffoldState>();



  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKeyLogin,
      body: Stack(
        children: [

          SingleChildScrollView(
              padding: EdgeInsets.only(top: 200),
              child: SocialLogin()
          ),

        ],
      ),
    );
  }
}
