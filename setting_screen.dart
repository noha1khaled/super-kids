import 'package:firebase/login_screen.dart';
import 'package:firebase/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();

}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Container(
        //height: MediaQuery.of(context).size.height / 0.8,
        color: Color(0xffe9967a),
        child: Padding(
          padding: EdgeInsets.only(top: 50, left: 40, bottom: 70),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/user.jpg'),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'sondos',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100.0, bottom: 260),
                child: Column(
                  children: <Widget>[
                    // NewRow(
                    //
                    //   text: 'Settings',
                    //   icon: Icons.error_outline,
                    // ),
                    SizedBox(
                      height: 20,
                    ),
                    NewRow(
                      text: 'Profile',
                      icon: Icons.person_outline,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    NewRow(text: 'Youtube kids', icon: Icons.video_collection),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    // NewRow(
                    //   text: 'Saved',
                    //   icon: Icons.bookmark_border,
                    // ),
                    SizedBox(
                      height: 20,
                    ),
                    NewRow(
                      text: 'Favorites',
                      icon: Icons.favorite_border,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.cancel,
                    color: Colors.white.withOpacity(0.5),
                  ),
                  SizedBox(
                    width: 10,
                  ),

                  ElevatedButton (
                    onPressed: () async {
                      GoogleSignIn googleSignIn=GoogleSignIn();
                      googleSignIn.disconnect();
                      await FirebaseAuth.instance.signOut();
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginScreen()));
                      SharedPreferences pref = await SharedPreferences.getInstance();
                      pref.clear();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red, // Change the color as needed
                      onPrimary: Colors.white, // Text color
                    ),
                    child: Text('Log out'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class NewRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const NewRow({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(
          icon,
          color: Colors.white,
        ),
        SizedBox(
          width: 20,
        ),
        Text(
          text,
          style: TextStyle(color: Colors.white),
        )
      ],
    );
  }
}
