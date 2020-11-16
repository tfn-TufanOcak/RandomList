import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'ProfileUser.dart';
import 'globals.dart';

class LoginButton extends StatefulWidget {
  final IconData icon;
  final Function loginMethod;
  const LoginButton({Key key, this.icon, this.loginMethod}) : super(key: key);

  @override
  _LoginButton createState() =>
      _LoginButton(icon: icon, loginMethod: loginMethod);
}

class _LoginButton extends State<LoginButton> {
  final IconData icon;
  final Function loginMethod;
  bool isLoading = false;
  _LoginButton({this.icon, this.loginMethod});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ButtonTheme(
            minWidth: 36.0,
            height: 54.0,
            child: RaisedButton(
              color: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9.0),
              ),
              child: isLoading
                  ? CircularProgressIndicator()
                  : Icon(
                icon,
                size: 28,
                color: Colors.white,
              ),
              onPressed: () async {
                try {
                  setState(() {
                    isLoading = true;
                  });
                  ProfileUser user = await loginMethod();

                  if (user != null) {
                    setState(() {
                      isLoading = false;
                    });

                    Global.currentSessionUser = user;

                    Navigator.pushNamedAndRemoveUntil(
                        context, '/', (Route route) => false);
                  }
                } catch (error, stackTrace) {
                  setState(() {
                    isLoading = false;
                  });

                }
              },
            )));
  }
}