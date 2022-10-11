// ignore_for_file: library_private_types_in_public_api, must_be_immutable, use_build_context_synchronously

import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/component/custom_bottom.dart';
import 'package:flash_chat/component/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});
 static const String id="registrationScreen";
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}
class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth=FirebaseAuth.instance;
  late String email;
  late String password;
 bool shoeSpinner=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: shoeSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: "logo",
                  child: SizedBox(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              CustomTextField(textInputType:TextInputType.emailAddress,obscure:false,textAlign:TextAlign.center,hintText: 'Enter your email',onPressed: (value){
                email=value;
              },),
              const SizedBox(
                height: 8.0,
              ),
              CustomTextField(textInputType:TextInputType.text,obscure:true,textAlign:TextAlign.center,hintText: 'Enter your password',onPressed: (value){
                password =value;

              },),
              const SizedBox(
                height: 24.0,
              ),
              CustomBottom(text: "Register", onPressed: ()async{
                setState(() {
                  shoeSpinner=true;
                });
                try{
                final newUser=await _auth.createUserWithEmailAndPassword(email: email, password: password);
                // ignore: unnecessary_null_comparison
                if(newUser!=null){
                  await Firebase.initializeApp();
                  Navigator.pushNamed(context, ChatScreen.id);
                }
                setState(() {
                  shoeSpinner=false;
                });
                }
                catch(e){
                  // ignore: avoid_print
                  print(e);
                }
              },color: Colors.blueAccent,),
            ],
          ),
        ),
      ),
    );
  }
}


