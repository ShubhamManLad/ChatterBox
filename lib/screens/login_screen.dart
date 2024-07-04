import 'package:chatterbox/components/sphere.dart';
import 'package:chatterbox/constants/colors.dart';
import 'package:chatterbox/constants/styles.dart';
import 'package:chatterbox/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController name_controller = TextEditingController();
  String emailID = '';
  String password = '';

  bool showPassword = true;

  bool login = true;

  void checkUser() async{
    String id = await FirebaseAuth.instance.currentUser!.uid;
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen(id: id,)));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkUser();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          alignment: Alignment.topCenter,
          children: [

            Image.asset('assets/logo.png', scale: 2,),

            Positioned(
              top: 45,
              left: 75,
              child: Sphere(h: 25, w: 25),
            ),

            Positioned(
              top: 205,
              right: 25,
              child: Sphere(h: 25, w: 25),
            ),


            Positioned(
              bottom: 205,
              left: 25,
              child: Sphere(h: 25, w: 25),
            ),


            Positioned(
              bottom: 50,
              right: 100,
              child: Sphere(h: 25, w: 25),
            ),


            Positioned(
              bottom: 100,
              left: 100,
              child: Container(
                // gray box
                child: Center(
                  child: Transform(
                    child: Container(
                      color: Colors.white30,
                      width: 300,
                      height: 2,
                    ),
                    alignment: FractionalOffset.center,
                    transform: new Matrix4.identity()
                      ..rotateZ(-30 * 3.1415927 / 180),
                  ),
                ),
              ),
            ),

            Positioned(
              bottom: 105,
              child: Container(
                // gray box
                child: Center(
                  child: Transform(
                    child: Container(
                      color: Colors.white30,
                      width: 300,
                      height: 2,
                    ),
                    alignment: FractionalOffset.center,
                    transform: new Matrix4.identity()
                      ..rotateZ(-30 * 3.1415927 / 180),
                  ),
                ),
              ),
            ),



            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: (){
                          setState(() {
                            login = true;
                          });
                        },
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(12), bottomLeft: Radius.circular(12)),
                                    side: BorderSide(color: (login)? primaryColor: Colors.black)
                                )
                            )
                        ),
                        child: Text(
                            'Login',
                            style: TextStyle(
                              color: (login)?Colors.white:primaryColor,
                            )
                        ),
                      ),

                      TextButton(
                        onPressed: (){
                          setState(() {
                            login = false;
                          });
                        },
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(topRight: Radius.circular(12), bottomRight: Radius.circular(12)),
                                  side: BorderSide(color: (!login)? primaryColor: Colors.black),
                              ),
                          )
                        ),
                        child: Text(
                            'Register',
                            style: TextStyle(
                              color: (login)?primaryColor:Colors.white,
                            )
                        ),
                      ),
                    ],
                  ),

                  // Name
                  (!login)?Padding(
                    padding: EdgeInsets.all(16.0),
                    child: TextField(
                      controller: name_controller,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      cursorColor: Colors.orangeAccent,
                      decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                          labelText: 'Name',
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          floatingLabelStyle: TextStyle(
                            color: primaryColor,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: primaryColor),
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: primaryColor),
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          )
                      ),
                    ),
                  ):SizedBox(),

                  // Email ID
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: TextField(
                      onChanged: (value){
                        emailID = value;
                      },
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      cursorColor: Colors.orangeAccent,
                      decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                          labelText: 'Email ID',
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          floatingLabelStyle: TextStyle(
                            color: primaryColor,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: primaryColor),
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: primaryColor),
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          )
                      ),
                    ),
                  ),

                  // Password
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: TextField(
                      onChanged: (value){
                        password = value;
                      },
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      obscureText: showPassword,
                      cursorColor: Colors.orangeAccent,
                      decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          floatingLabelStyle: TextStyle(
                            color: primaryColor,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: primaryColor),
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: primaryColor),
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                          suffix: GestureDetector(
                            onTap: (){
                              setState(() {
                                showPassword = !showPassword;
                              });
                            },
                            child: Icon(
                              showPassword ? Icons.visibility_off_outlined:Icons.visibility_outlined,
                              color: primaryColor,
                            ),
                          )
                      ),
                    ),
                  ),

                  // Submit
                  TextButton(
                    onPressed: ()async{
                      if(!login){
                        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailID, password: password);
                        String id = await FirebaseAuth.instance.currentUser!.uid;
                        Map<String, dynamic> data = {
                          'userId': id,
                          'name': name_controller.text,
                          'email': emailID,
                          'password': password,
                          'status': 'Online',
                        };
                        await FirebaseDatabase.instance
                            .ref("users/$id")
                            .set(data);
                      }
                      await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailID, password: password);
                      String id = await FirebaseAuth.instance.currentUser!.uid;
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen(id: id,)));
                    },
                    child: Text(
                      (login)?'Login': 'Register',
                        style: TextStyle(
                          color: tertiaryColor,
                        )
                    ),
                    style: raisedButtonStyle,
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
