import 'package:firebase/forget_password/resetpassword.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class CheckPasswored extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;




    return Stack(
      children: [
        Image.asset(
          'assets/images_foreget_password/bg (3).jpg',
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Stack(
              children: <Widget>[
                SingleChildScrollView(
                  //scrollDirection: Axis.horizontal,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 40.0),
                            child: Container(
                                width: screenWidth * 0.9, // Adjust the width as needed
                                height: 175, // Fixed height
                                decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 230, 63, 52),
                                    borderRadius: BorderRadius.vertical(
                                        bottom: Radius.circular(100))),
                                //width: 425,
                                //height: 175,
                                child: const Center(
                                  child: Text(
                                    'Verification Code',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 30),
                                  ),
                                )),
                          ),
                        ],
                      ),
                      const CircleAvatar(
                        backgroundImage: AssetImage(
                            'assets/images_foreget_password/email.png'),
                        radius: 100,
                        backgroundColor: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: const Text('Please Enter The Code Diliverd to your Gmail',
                            style: TextStyle(
                                color: Color.fromARGB(255, 230, 63, 52),
                                fontSize: 20)),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      OtpTextField(
                        borderRadius: BorderRadius.circular(15),
                        numberOfFields: 5,
                        borderColor: const Color.fromARGB(255, 230, 63, 52),
                        showFieldAsBox: true,

                        focusedBorderColor: Color.fromARGB(255, 230, 63, 52),

                        //handle validation or checks here
                        onCodeChanged: (String code) {},
                        //runs when every textfield is filled
                        onSubmit: (String verificationCode) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (BuildContext context) {
                            return ResetPassword();

                          }));

                          // showDialog(
                          //     context: context,
                          //     builder: (context) {

                          //        Navigator.push(context, MaterialPageRoute(
                          //         builder: (BuildContext context) {
                          //       return ResetPassword();
                          //     }));

                          //       return AlertDialog(
                          //         title: Text("Verification Code"),
                          //         content:
                          //             Text('Code entered is $verificationCode'),
                          //       );
                          //     });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
