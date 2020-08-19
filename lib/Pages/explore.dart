import 'package:flutter/cupertino.dart';

import 'chat.dart';
import 'package:flutter/material.dart';

import '../Controllers/utils.dart';

import 'home.dart';

class Explore extends StatefulWidget {
  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder(
                stream: cloud.collection('Users').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (BuildContext context, int index) {
                        var db = snapshot.data.documents[index];
                        if(db["ID"] == myID) return Container();
                        return Column(
                          children: <Widget>[
                            SizedBox(height: 8.0),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(20.0,5,20.0,5),
                                      child: GestureDetector(
                                        onTap: () {
                                          String chatID = makeChatId(myID, db["ID"]);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Chat(
                                                  myID,myName,db["ID"],chatID,db["username"]
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          child: ListTile(
                                            leading: new CircleAvatar(
                                              backgroundImage: new NetworkImage("https://picsum.photos/200/300"),
                                              radius: 25.0,
                                              child: db["isActive"] != null? Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(color: db["isActive"]?Colors.green:Colors.red,width: 2,),
                                                    borderRadius: BorderRadius.circular(100.0)
                                                ),
                                              ):Container(),
                                            ),
                                            title: new Text(db["username"]),
                                            trailing: Icon(Icons.chat,color: Colors.black45),

                                          ),
                                            decoration: new BoxDecoration(
                                              color: Colors.transparent,
                                              border: Border.all(
                                                  color: Colors.black12,
                                                  width: 2.0
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20.0)  //                 <--- border radius here
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.white.withOpacity(0.5),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0, 3), // changes position of shadow
                                                ),
                                              ],

                                            )
                                        ),
                                      ),
                                    ),

                          ],
                        );
                      },
                    );
                  }
                },
            ),
          ),
        ],
      ),
    );
  }
}
