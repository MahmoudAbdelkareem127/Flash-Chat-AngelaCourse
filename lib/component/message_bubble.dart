import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
const MessageBubble({Key? key, required this.sender, required this.text, required this.isMe}) : super(key: key);
final String  sender;
final String  text;
final bool isMe;
@override
Widget build(BuildContext context) {
  return Padding(
    padding:const EdgeInsets.all(10),
    child: Column(
      crossAxisAlignment:isMe? CrossAxisAlignment.end:CrossAxisAlignment.start,
      children: [
        // ignore: unnecessary_string_interpolations
        Text ("$sender",style:const TextStyle(fontSize: 12,color: Colors.black54)),
        Material(
        elevation: 5,
        borderRadius:isMe? const BorderRadius.only(topLeft: Radius.circular(30),bottomRight: Radius.circular(30),bottomLeft:Radius.circular(30) ):
        const BorderRadius.only(topRight: Radius.circular(30),bottomRight: Radius.circular(30),bottomLeft:Radius.circular(30) ),
        color: isMe? Colors.lightBlueAccent:Colors.white,
        child: Padding(
        padding:const EdgeInsets.symmetric(vertical: 10,horizontal: 10
        ),
        child: Text(
          "$text ",
          style: TextStyle(fontSize: 20,color: isMe? Colors.white:Colors.black54),),
          ),
      ),
    ]),
  );
}
}