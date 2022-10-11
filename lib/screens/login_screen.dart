// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/component/custom_bottom.dart';
import 'package:flash_chat/component/custom_text_field.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
   const LoginScreen({super.key});
   static  const String id="loginScreen";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  final _auth=FirebaseAuth.instance;
  late String email;
  late String password;
  late User loggedInUser;
  bool shoeSpinner=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(

        inAsyncCall: shoeSpinner,
        child: Padding(
          padding:const EdgeInsets.symmetric(horizontal: 24.0),
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
                password=value;
              },),
              const SizedBox(
                height: 24.0,
              ),
              CustomBottom(text: "Log in",onPressed: ()async{
                setState(() {
                  shoeSpinner=true;
                });

               try {
                 final user = await _auth.signInWithEmailAndPassword(
                     email: email, password: password);
                 // ignore: unnecessary_null_comparison
                 if (user != null) {
                   Navigator.pushNamed(context, ChatScreen.id);
                 }
                 setState(() {
                   shoeSpinner=false;
                 });

               }catch (e){
                   // ignore: avoid_print
                   print(e);


                }

              },color: Colors.lightBlueAccent,),
            ],
          ),
        ),
      ),
    );
  }
}
