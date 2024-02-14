import 'package:firebase/home_screen.dart';
import 'package:firebase/main_of_home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helper/show_snackbar.dart';
import 'login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignupScreen extends StatefulWidget {
  // VoidCallback?onTap() {
  //   // TODO: implement onTap
  //   throw UnimplementedError();
  // }

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  Function(String)? onChanged;
  String? email;
  String? password;
  String? name;
  bool obsecureText=true;


  //key
  GlobalKey<FormState> formkey = GlobalKey();
  bool isLooding = false;

  @override

  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    // if(googleUser==null){
    //   return;
    // }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    print ("sucsses");
    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);
    Navigator.push(context,MaterialPageRoute(builder: (context)=>MainHomeScreen()));
  }
  //final FirebaseAuth _auth = FirebaseAuth.instance;
  //final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Future<User?> signInWithGoogle() async {
  //   try {
  //     //print("111111111111111111111111111111111111111");
  //     final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
  //     final GoogleSignInAuthentication googleAuth = await googleSignInAccount!.authentication;
  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );
  //     final UserCredential authResult = await _auth.signInWithCredential(credential);
  //     //print("222222222222222222222222222222222222");
  //     final User? user = authResult.user;
  //     return user;
  //   } catch (e) {
  //     //print('Error signing in with Google: $e');
  //     return null;
  //   }
  // }








  @override
  Widget build(BuildContext context) {

    return ModalProgressHUD(
      inAsyncCall: isLooding,
      child: Scaffold(
        body: Form(
          //access for all form (البيانات اللي هعملها  validation)تقدر من خلال ال key تقول هل البيانات دي سليمه ولا لا
          key: formkey,
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height / 0.8,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        "assets/images/bg (3).jpg",
                      ),
                      fit: BoxFit.cover)),
              child: Padding(
                padding: const EdgeInsets.only(top: 100),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'SignUp',
                        style: TextStyle(
                          color: Colors.black38,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: TextFormField(
                          //firebase
                          validator: (data) {
                            if (data!.isEmpty) {
                              return 'field is required';
                            }
                          },
                          onChanged: (data) {
                            email = data;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            label: Text(
                              'Email Address',
                              style: TextStyle(fontSize: 20),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: TextFormField(
                          validator: (data) {
                            if (data!.isEmpty) {
                              return 'field is required';
                            }
                          },
                          onChanged: (data) {
                            name = data;
                          },
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            label: Text(
                              'UserName',
                              style: TextStyle(fontSize: 20),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: TextFormField(
                          validator: (data) {
                            if (data!.isEmpty) {
                              return 'field is required';
                            }
                          },
                          onChanged: (data) {
                            password = data;
                          },
                          obscureText: obsecureText,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            label: Text(
                              'Password',
                              style: TextStyle(fontSize: 20),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  obsecureText = !obsecureText;
                                });
                              },
                              icon: Icon(
                                obsecureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                              ),
                            ),

                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () async {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => (MainHomeScreen()),
                          //   ),
                          // );
                          //////firebase//////

                          if (formkey.currentState!.validate()) {
                            isLooding = true;
                            setState(() {});
                            try {
                             var result= await registeruser();
                             if (result != null) {

                               User? user = result.user; // Retrieve the User object
                               if (user != null) {
                                 FirebaseFirestore.instance.collection('users').doc(user.uid).set({
                                   'email': email,
                                   'name': name,
                                 });
                               }
                             }
                             showSnackBar(context, ' success');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => (LoginScreen()),
                                ),
                              );
                              //Navigator.pushNamed(context, 'HomeScreen');
                            } on FirebaseAuthException catch (e) {
                              //write message for user
                              if (e.code == 'weak-password') {
                                showSnackBar(context, 'weak password');
                                //print('The password provided is too weak.');
                              } else if (e.code == 'email-already-in-use') {
                                showSnackBar(context, 'email already exist');
                              }
                            }
                            //value is null
                            catch (e) {
                              showSnackBar(context, 'there was an error');
                            }
                            isLooding = false;
                            setState(() {});
                            //case is no problem
                          } else {}
                        },
                        child: Container(
                          height: 50,
                          width: 350,
                          decoration: BoxDecoration(
                              color: Color(0xffffa07a),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(7),
                                  topRight: Radius.circular(7))),
                          child: Center(
                            child: Text(
                              'SignUp',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Or SignUP With',
                              style: TextStyle(
                                  color: Colors.black38,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return MainHomeScreen();
                                    }),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: 10.0,
                                  right: 20.0,
                                  left: 20.0,
                                  bottom: 5.0),
                              width: 60.0,
                              height: 60.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: Color(0xffD2EBE7),
                                  width: 1,
                                ),
                              ),
                              child: Image.asset("assets/images/apple.png"),
                            ),
                          ),
                          InkWell(
                            onTap: ()async {
                              User? user = await signInWithGoogle();
                              if (user != null) {
                                Navigator.push(context,MaterialPageRoute(builder: (context)=>MainHomeScreen()));
                              } else {
                                print("Errrrrrrrrrrrrrrrrrrrrrrrrrrrrr");
                              }
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: 10.0,
                                  right: 20.0,
                                  left: 20.0,
                                  bottom: 5.0),
                              width: 60.0,
                              height: 60.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: Color(0xffD2EBE7),
                                  width: 1,
                                ),
                              ),
                              child: Image.asset("assets/images/gmail.png"),
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: 10.0,
                                  right: 20.0,
                                  left: 20.0,
                                  bottom: 5.0),
                              width: 60.0,
                              height: 60.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: Color(0xffD2EBE7),
                                  width: 1,
                                ),
                              ),
                              child: Image.asset("assets/images/facebook.png"),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "already have an account ?",
                              style: TextStyle(
                                color: Colors.black38,
                                fontSize: 15,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => (LoginScreen()),
                                  ),
                                );
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // void showSnackBar(BuildContext context, String message) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text('message'),
  //     ),
  //   );
  // }

  Future<UserCredential> registeruser() {
    return FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
