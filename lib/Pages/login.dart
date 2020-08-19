import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter_flash_chat/Pages/register.dart';

import 'home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _email;
  String _password;

  FirebaseAuth _auth = FirebaseAuth.instance;

  final _scaffoldkey = GlobalKey<ScaffoldState>();

  _login(email, password) async {
    await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .whenComplete(
      () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Home(),
          ),
        );
      },
    );
  }


  bool _obscureText = true;

  bool isLoading = false;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      body: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Center(
              child: isLoading?SpinKitChasingDots(
                color: Colors.white,
                size: 100.0,
              ):SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    FlutterLogo(
                      size: 120.0,
                      colors: Colors.deepPurple,
                    ),
                    SizedBox(height: 48.0),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      autofocus: false,
                      onChanged: (val) => _email = val,
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 5.0),
                          child: Icon(
                            Icons.email,
                            color: Colors.grey,
                          ),
                        ),
                        hintText: 'E-mail',
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 24.0),
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      autofocus: false,
                      obscureText: _obscureText,
                      onChanged: (val) => _password = val,
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 5.0),
                          child: Icon(
                            Icons.lock,
                            color: Colors.grey,
                          ),
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: IconButton(
                            onPressed: _toggle,
                            icon: Icon(Icons.remove_red_eye,size: 20,),
                            color: _obscureText?Colors.black:Colors.blue,
                            //child: new Text(_obscureText ? "Show" : "Hide")),
                          ),
                        ),
                        hintText: 'Password',
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 12.0),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        onPressed: () {

                          if(_email!=null && _password!=null){
                          //setState(() => _call = true);
                          _login(_email, _password).whenComplete(() {
                            //setState(() => _call = false);
                          });
                          }
                          else{

                            _scaffoldkey.currentState.showSnackBar(
                                SnackBar(content: Text("Please fill out all fields",
                                  textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0, fontWeight:
                                  FontWeight.bold),), duration: Duration(seconds: 2), backgroundColor: Colors.red,)
                            );

                          }
                        },
                        padding: EdgeInsets.all(12),
                        color: Theme.of(context).primaryColor,
                        child: Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Register(),
                            ),
                          );
                        },
                        padding: EdgeInsets.all(12),
                        color: Colors.black45,
                        child: Text(
                          'Register',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

    );
  }
}
