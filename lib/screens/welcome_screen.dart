// ignore_for_file: library_private_types_in_public_api, deprecated_member_use

import 'package:flash_chat/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/component/custom_bottom.dart';

class WelcomeScreen extends StatefulWidget {
   const WelcomeScreen({super.key});
static const String id="welcomeScreen";
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}
class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin{

late  AnimationController controller;
late Animation animation;

@override
  void initState() {
    super.initState();
    controller=AnimationController(duration:const Duration(seconds: 1), upperBound: 1, vsync: this);
    animation =ColorTween(begin: Colors.blueGrey,end: Colors.white).animate(controller);
    controller.forward();
    controller.addListener(() {
       setState(() {});
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: SizedBox(
                    height: 60,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
                 TypewriterAnimatedTextKit(
                text: const ['Flash Chat'],
                  textStyle: const TextStyle(color: Colors.grey,
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 48.0,
            ),
            CustomBottom(text: "Log in",onPressed: (){
              Navigator.pushNamed(context, LoginScreen.id);
            },color: Colors.lightBlueAccent,),
            CustomBottom(text: "Register", onPressed: (){
              Navigator.pushNamed(context, RegistrationScreen.id);},color: Colors.blueAccent,),
          ],
        ),
      ),
    );
  }
}



