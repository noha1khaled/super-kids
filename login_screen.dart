import 'dart:ui';

import 'package:firebase/home_screen.dart';
import 'package:firebase/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:rive/rive.dart';
import 'anim.dart';

//import 'forget_password/forget_Passwored.dart';
import 'core/constants.dart';
import 'forget_password/forget_Passwored.dart';
import 'helper/show_snackbar.dart';
import 'main_of_home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email;
  String? password;
  bool obsecureText = true;
  bool keepMeLogIn = false;

  //key
  GlobalKey<FormState> formkey = GlobalKey();
  bool isLooding = false;

  Artboard? riveArtboard;
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  late RiveAnimationController controllerIdle;
  late RiveAnimationController controllerHandsUp;
  late RiveAnimationController controllerHandsDown;
  late RiveAnimationController controllerLookLeft;
  late RiveAnimationController controllerLookRight;
  late RiveAnimationController controllerSuccess;
  late RiveAnimationController controllerFail;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // String testEmail = "n";
  // String testPassword = "n";
  final passwordFocusNode = FocusNode();

  bool isLookingLeft = false;
  bool isLookingRight = false;

  void removeAllControllers() {
    riveArtboard?.artboard.removeController(controllerIdle);
    riveArtboard?.artboard.removeController(controllerHandsUp);
    riveArtboard?.artboard.removeController(controllerHandsDown);
    riveArtboard?.artboard.removeController(controllerLookLeft);
    riveArtboard?.artboard.removeController(controllerLookRight);
    riveArtboard?.artboard.removeController(controllerSuccess);
    riveArtboard?.artboard.removeController(controllerFail);
    isLookingLeft = false;
    isLookingRight = false;
  }

  void addIdleController() {
    removeAllControllers();
    riveArtboard?.artboard.addController(controllerIdle);
    debugPrint("idleee");
  }

  void addHandsUpController() {
    removeAllControllers();
    riveArtboard?.artboard.addController(controllerHandsUp);
    debugPrint("hands up");
  }

  void addHandsDownController() {
    removeAllControllers();
    riveArtboard?.artboard.addController(controllerHandsDown);
    debugPrint("hands down");
  }

  void addSuccessController() {
    removeAllControllers();
    riveArtboard?.artboard.addController(controllerSuccess);
    debugPrint("Success");
  }

  void addFailController() {
    removeAllControllers();
    riveArtboard?.artboard.addController(controllerFail);
    debugPrint("Faillll");
  }

  void addLookRightController() {
    removeAllControllers();
    isLookingRight = true;
    riveArtboard?.artboard.addController(controllerLookRight);
    debugPrint("Righttt");
  }

  void addLookLeftController() {
    removeAllControllers();
    isLookingLeft = true;
    riveArtboard?.artboard.addController(controllerLookLeft);
    debugPrint("Leftttttt");
  }

  void checkForPasswordFocusNodeToChangeAnimationState() {
    passwordFocusNode.addListener(() {
      if (passwordFocusNode.hasFocus) {
        addHandsUpController();
      } else if (!passwordFocusNode.hasFocus) {
        addHandsDownController();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    controllerIdle = SimpleAnimation(AnimatedEnum.idle.name);
    controllerHandsUp = SimpleAnimation(AnimatedEnum.hands_up.name);
    controllerHandsDown = SimpleAnimation(AnimatedEnum.hands_down.name);
    controllerLookRight = SimpleAnimation(AnimatedEnum.Look_down_right.name);
    controllerLookLeft = SimpleAnimation(AnimatedEnum.Look_down_left.name);
    controllerSuccess = SimpleAnimation(AnimatedEnum.success.name);
    controllerFail = SimpleAnimation(AnimatedEnum.fail.name);

    rootBundle.load('assets/anim/loginn.riv').then((data) {
      final file = RiveFile.import(data);
      final artboard = file.mainArtboard;
      artboard.addController(controllerIdle);
      setState(() {
        riveArtboard = artboard;
      });
    });

    checkForPasswordFocusNodeToChangeAnimationState();
  }

  void validateEmailAndPassword() {
    Future.delayed(const Duration(seconds: 1), () {
      if (formKey.currentState!.validate()) {
        addSuccessController();
        emailController.clear();
        passController.clear();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => (MainHomeScreen()),
          ),
        );
      } else {
        addFailController();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLooding,
      child: Scaffold(
        body: Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/bg (3).jpg"),
                      fit: BoxFit.cover)),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 20,
                    vertical: MediaQuery.of(context).size.height / 10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 3,
                        child: riveArtboard == null
                            ? const SizedBox.shrink()
                            : Rive(
                                artboard: riveArtboard!,
                              ),
                      ),
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              //controller: emailController,
                              validator: (data) {
                                if (data!.isEmpty) {
                                  return 'field is required';
                                }
                              },
                              onChanged: (data) {
                                email = data;
                                if (data.isNotEmpty &&
                                    data.length < 16 &&
                                    !isLookingLeft) {
                                  addLookLeftController();
                                } else if (data.isNotEmpty &&
                                    data.length > 16 &&
                                    !isLookingRight) {
                                  addLookRightController();
                                }
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                labelText: "Email",
                              ),
                              // validator: (value) =>
                              //     value != testEmail ? "Wrong email" : null,
                              // onChanged: (value) {
                              //   if (value.isNotEmpty &&
                              //       value.length < 16 &&
                              //       !isLookingLeft) {
                              //     addLookLeftController();
                              //   } else if (value.isNotEmpty &&
                              //       value.length > 16 &&
                              //       !isLookingRight) {
                              //     addLookRightController();
                              //   }
                              // },
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 25,
                            ),
                            TextFormField(
                              validator: (data) {
                                if (data!.isEmpty) {
                                  return 'field is required';
                                }
                              },
                              onChanged: (data) {
                                password = data;
                              },
                              controller: passController,
                              obscureText: obsecureText,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      obsecureText = !obsecureText;
                                    });
                                  },
                                  icon: Icon(
                                    obsecureText
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                  ),
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                labelText: "Password",
                              ),
                              focusNode: passwordFocusNode,
                              // validator: (value) =>
                              //     value != testPassword ? "Wrong password" : null,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 170.0),
                              child: TextButton(
                                onPressed: () {
                                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>(ResetPasswordScreen()),),);
                                },
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) {
                                        return Forget_Passwored();
                                      }),
                                    );
                                  },
                                  child: Text(
                                    "Forgot Password?",
                                    style: TextStyle(
                                      color: Colors.black38,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 70,
                            ),
                            InkWell(
                              onTap: () async {
                                if (keepMeLogIn == true) {
                                  keepUserLogeIn();
                                }
                                // passwordFocusNode.unfocus();
                                // validateEmailAndPassword();
                                if (formKey.currentState!.validate()) {
                                  isLooding = true;
                                  setState(() {});
                                  try {
                                    await loginUser();
                                    //await signInWithGoogle(context);
                                    showSnackBar(context, ' success');
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            (MainHomeScreen()),
                                      ),
                                    );

                                    //Navigator.pushNamed(context, 'MainHomeScreen');
                                    //     arguments: email);
                                  } on FirebaseAuthException catch (e) {
                                    if (e.code == 'user-not-found') {
                                      showSnackBar(context, 'user not found');
                                    } else if (e.code == 'wrong-password') {
                                      showSnackBar(context, 'wrong password');
                                    } else {
                                      showSnackBar(context,
                                          'check your email and password');
                                    }
                                  } catch (e) {
                                    print(e);
                                    showSnackBar(context, 'there was an error');
                                  }

                                  isLooding = false;
                                  setState(() {});
                                } else {
                                  showSnackBar(
                                      context, 'check your email and password');
                                }
                              },
                              child: Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: Color(0xffB04863),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(7),
                                        topRight: Radius.circular(7))),
                                child: Center(
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: keepMeLogIn,
                                  onChanged: (value) {
                                    setState(() {
                                      keepMeLogIn = value!;

                                      //rememberMe = value ?? false;
                                    });
                                  },
                                ),
                                Text('Remember me'),
                              ],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
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
                                          builder: (context) =>
                                              (SignupScreen()),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "Signup",
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

  Future<void> loginUser() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);

  }

  void keepUserLogeIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(keepMeLogedIN, keepMeLogIn);
  }
}

// Function to create a new user with email and password
// Future<void> signUpWithEmailPassword(String email, String password) async {
//   try {
//     UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
//       email: email,
//       password: password,
//     );
//     // User signed up successfully
//     // You can navigate to another screen or perform other actions
//   } catch (e) {
//     print("Error signing up: $e");
//     // Handle sign-up errors
//   }
// }

// Function to sign in with email and password

// Function to sign in with Google

Future<UserCredential?> signInWithGoogle() async {
  try {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      // Handle when user cancels Google Sign-In
      return null;
    }

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Sign in to Firebase with the Google Auth credentials
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    return userCredential;
  } catch (e) {
    print('Error signing in with Google: $e');
    return null;
  }
}
