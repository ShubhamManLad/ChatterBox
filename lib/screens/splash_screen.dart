import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chatterbox/constants/colors.dart';
import 'package:chatterbox/screens/home_screen.dart';
import 'package:chatterbox/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(
        Duration(seconds: 3), (){
      User? user = FirebaseAuth.instance.currentUser;
      if(user!=null) {
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen(id: FirebaseAuth.instance.currentUser!.uid,)));
      }
      else{
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
      }
    }
    );


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText(
                'Chatter Box',
                // textStyle: GoogleFonts.kalam(textStyle: TextStyle()),
                textStyle: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: primaryColor
                ),
                speed: Duration(milliseconds: 100)
            ),
          ],
        ),
      ),
    );
  }
}
