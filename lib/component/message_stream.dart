import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';

import 'message_bubble.dart';

class MessageStream extends StatelessWidget {
   const MessageStream({
    Key? key,
    required FirebaseFirestore fireStore,
  }) : _fireStore = fireStore, super(key: key);
  final FirebaseFirestore _fireStore;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _fireStore.collection("massages").snapshots(),
        builder: (context,snapshot) {
          List <MessageBubble> massageBubbles = [];
          if (snapshot.hasData) {
            final massages = snapshot.data?.docs;
            for (var massage in massages!) {
              final massageText = massage.data()["text"];
              final massageSender = massage.data()["sender"];
              final currentUser=ChatScreen.loggedUser.email;
              final massageBubble =MessageBubble(sender: massageSender, text: massageText, isMe: currentUser==massageSender,) ;
              massageBubbles.add(massageBubble);
            }
          }
          if(!snapshot.hasData){
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            );
          }
          return Expanded(
            child: ListView(
              padding:const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              children: massageBubbles,


            ),
          );
        });
  }
}