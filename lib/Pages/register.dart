import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flash_chat/Pages/login.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'home.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String _username;
  String _email;
  String _password;

  FirebaseAuth _auth = FirebaseAuth.instance;
  Firestore _cloud = Firestore.instance;
  final _scaffoldkey = GlobalKey<ScaffoldState>();

  _register(username, email, password) async {
    await _auth
        .createUserWithEmailAndPassword(email: _email, password: _password)
        .then((db) {
      _cloud.collection("Users").document(db.user.uid).setData({
        "username": username,
        "email": email,
        "ID": db.user.uid,
        "isActive": false,
      });
    }).whenComplete(() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Home(),
        ),
      );
    });
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
    return  Scaffold(
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
                      onChanged: (val) => _username = val,
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 5.0),
                          child: Icon(
                            Icons.person,
                            color: Colors.grey,
                          ), // icon is 48px widget.
                        ), // icon is 48px widget.
                        hintText: 'Username',
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 24.0),
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
                          ), // icon is 48px widget.
                        ), // icon is 48px widget.
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

                          if(_username!=null&&_password!=null&&_email!=null) {
                            setState(()=> isLoading = true);
                            _register(_username, _email, _password)
                                .whenComplete(() {
                              setState(()=> isLoading = false);
                            });
                          }else{

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
                          'Register',
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
                              builder: (context) => Login(),
                            ),
                          );

                        },
                        padding: EdgeInsets.all(12),
                        color: Colors.black45,
                        child: Text(
                          'Login',
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
