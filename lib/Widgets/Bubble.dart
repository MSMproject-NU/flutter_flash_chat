import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flash_chat/Controllers/utils.dart';

import '../fullPhoto.dart';

class Bubble extends StatelessWidget {
  Bubble({this.message, this.time, this.delivered, this.type, this.isMe});

  final String message, type;
  final int time;
  final delivered, isMe;

  @override
  Widget build(BuildContext context) {
    final bg = isMe ? Colors.white : Colors.deepPurple.withOpacity(.3);
    final icon = delivered ? Icons.done_all : Icons.done;
    final align = isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end;

    final radius = isMe
        ? BorderRadius.only(
            topRight: Radius.circular(5.0),
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(5.0),
          )
        : BorderRadius.only(
            topLeft: Radius.circular(5.0),
            bottomLeft: Radius.circular(5.0),
            bottomRight: Radius.circular(10.0),
          );
    return Column(
      crossAxisAlignment: align,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(3.0),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: .5,
                  spreadRadius: 1.0,
                  color: Colors.black.withOpacity(.12))
            ],
            color: bg,
            borderRadius: radius,
          ),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 48.0),
                child: type == "text"
                    ? Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text("$message"),
                    )
                    : Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                          width: 160,
                          height: 160,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FullPhoto(url: message),
                                ),
                              );
                            },
                            //^2.1.0+1
                          ),
                        ),
                    ),
              ),
              Positioned(
                bottom: 0.0,
                right: 0.0,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Text(
                        bubbleTime(time),
                        style: TextStyle(
                          color: isMe?Colors.black45:Colors.white,
                          fontSize: 9,
                        ),
                      ),
                    ),
                    SizedBox(width: 3.0),
                    Icon(icon,
                        size: 12.0,
                        color: delivered ? Colors.blue : Colors.black38)
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
