import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../helper/show_snackbar.dart';
import 'Check.dart';
//import 'package:forget_passowred/Check.dart';

class Forget_Passwored extends StatelessWidget {






  @override
  Widget build(BuildContext context) {
    String? email;

    return Stack(
      children: [
        Image.asset(
          'assets/images_foreget_password/bg (3).jpg',
          height: MediaQuery
              .of(context)
              .size
              .height,
          width: MediaQuery
              .of(context)
              .size
              .width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title: const Text(
                'Forgrt Password',
                style: TextStyle(
                  color: Color.fromARGB(255, 164, 90, 84),
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              )),
          body: ListView(children: [
            SafeArea(
              child: Stack(
                children: <Widget>[
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(75.0),
                        child: CircleAvatar(
                          backgroundImage: AssetImage(
                              'assets/images_foreget_password/forget.png'),
                          radius: 100,
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 250,
                      ),
                      const Text(
                        'Check Email',
                        style: TextStyle(
                          color: Color.fromARGB(255, 127, 10, 2),
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      const Text(
                        'Please Enter your Email Address',
                        style: TextStyle(
                          color: Color.fromARGB(255, 128, 41, 35),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          validator: (data) {
                            if (data!.isEmpty) {
                              return 'field is required';
                            }
                          },
                          onChanged: (data) {
                            email = data;
                          },
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: const TextStyle(
                              color: Colors.red,
                            ),
                            contentPadding: const EdgeInsets.all(20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: const BorderSide(
                                color: Colors.red,
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red,
                                )),
                            hintText: 'Enter Your Email',
                            suffixIcon: const Icon(
                              Icons.email_outlined,
                              color: Color.fromARGB(255, 230, 63, 52),
                            ),
                          ),
                          obscureText: false,
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () async {
                            // await FirebaseAuth.instance.sendPasswordResetEmail(email: email!);
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (BuildContext context) {
                            //     return CheckPasswored();
                            //   }),
                            // );
                          if(email ==null){
                            return;
                          }
// Function to send a password reset email
                              try {

                                showSnackBar(context, ' see your gmail');

                                await FirebaseAuth.instance.sendPasswordResetEmail(email: email!);
                                // Password reset email sent successfully
                                // You can display a message to the user indicating that the reset email has been sent
                              } catch (e) {
                                showSnackBar(context, 'there exist problem');

                                print('Error sending password reset email: $e');
                                // Handle errors, such as invalid email or network issues
                                // You can display an error message to the user
                              }


                          },
                          child: Container(
                            width: 100,
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 230, 63, 52),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Check',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),

                      )
                    ],
                  )
                ],
              ),
            ),
          ]),
        ),
      ],
    );
  }
}
