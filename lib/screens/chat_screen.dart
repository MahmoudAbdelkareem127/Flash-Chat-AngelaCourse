// ignore_for_file: library_private_types_in_public_api, await_only_futures
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/component/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/component/message_stream.dart';


class ChatScreen extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  ChatScreen({super.key});
   static const String id="chatScreen";
  static late User loggedUser;
  @override
  _ChatScreenState createState() => _ChatScreenState();}
class _ChatScreenState extends State<ChatScreen> {
  final _auth=FirebaseAuth.instance;
  final _fireStore=FirebaseFirestore.instance;
  final messageTextController=TextEditingController();

late  String massageText;
  @override
  void initState() {
    super.initState();

    getCurrentUser();

  }
 void getCurrentUser()async{
    try{
      final user=await _auth.currentUser;
      if(user!=null){
        await Firebase.initializeApp();
        ChatScreen.loggedUser=user;
      }

    // ignore: avoid_print
    }catch(e){print(e);}
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon:const Icon(Icons.close),
              onPressed: () {
              _auth.signOut();
              Navigator.pop(context);
              }),
        ],
        title:const Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(fireStore: _fireStore),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        massageText=value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      messageTextController.clear();
                      _fireStore.collection("massages").add({
                        "text":massageText,
                        "sender":ChatScreen.loggedUser.email
                      });
                    },
                    child:const Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
















