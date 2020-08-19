import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flash_chat/Pages/login.dart';

import 'explore.dart';
import 'inbox.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

String myID;
String myName;

Firestore cloud = Firestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;

class _HomeState extends State<Home> with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  TabController _tabController;

  void getCurrentUser() async {
    try {
      final user = await auth.currentUser();
      if (user != null) {
        myID = user.uid;
        var db = await cloud.collection("Users").document(myID).get();
        myName = db.data["username"];
        print(myID);
        print(myName);
      }else{

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return Login();
        }));

      }
    } catch (e) {
      print(e);
    }
  }

  setIsActive() async {
    await cloud.collection("Users").document(myID).updateData({
      "isActive": true,
    });
  }
  setUnActive() async {
    await cloud.collection("Users").document(myID).updateData({
      "isActive": false,
    });
  }
  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
    getCurrentUser();

    WidgetsBinding.instance.addObserver(this);
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed)
      setIsActive();
    else
      setUnActive();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _tabController.dispose();
    super.dispose();
  }

  logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => Login()
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(leading: Text("Flash Chat"),
            trailing: IconButton(
              icon: Icon(Icons.exit_to_app,color: Colors.black,size: 30,),

              onPressed: logout,

            )

        ),
        elevation: 0.7,
        backgroundColor: Theme.of(context).primaryColor,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Theme.of(context).primaryColor.withOpacity(.5),
          tabs: <Widget>[
            Tab(text: "Inbox"),
            Tab(text: "Explore"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Inbox(),
          Explore(),
        ],
      ),
    );
  }
}
