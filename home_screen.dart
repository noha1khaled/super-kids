import 'package:firebase/homepage_animal/home.dart';
import 'package:firebase/login_screen.dart';
import 'package:flutter/material.dart';

import 'draw/drawp.dart';
import 'home_lettter/homeLetter.dart';
import 'homepage_animal/animalCard.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double xOffset = 0;
  double yOffset = 0;

  bool isDrawerOpen = false;
  static String id = 'HomeScreen';
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: MediaQuery.of(context).size.height,
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..scale(isDrawerOpen ? 0.85 : 1.00)
        ..rotateZ(isDrawerOpen ? -50 : 0),
      duration: Duration(milliseconds: 200),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/bg (3).jpg"), fit: BoxFit.cover),
        borderRadius:
            isDrawerOpen ? BorderRadius.circular(40) : BorderRadius.circular(0),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    isDrawerOpen
                        ? GestureDetector(
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 60,
                            ),
                            onTap: () {
                              setState(() {
                                xOffset = 0;
                                yOffset = 0;
                                isDrawerOpen = false;
                              });
                            },
                          )
                        : GestureDetector(
                            child: Icon(
                              Icons.menu,
                              size: 30,
                            ),
                            onTap: () {
                              setState(() {
                                xOffset = 290;
                                yOffset = 80;
                                isDrawerOpen = true;
                              });
                            },
                          ),
                    Text(
                      'play AND learn',
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                          decoration: TextDecoration.none),
                    ),
                    Container(),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Column(
                children: <Widget>[
                  NewPadding(
                    y: 0xff000000,
                    x: 0xffFF545B,
                    page: Homepage_Letter(),
                    image1: 'assets/gifs/letter.gif',
                    text1: 'ELetters',
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  NewPadding(
                    x: 0xff212121,
                    y: 0xffff4500,
                    page: Drawp(),
                    image1: 'assets/gifs/colors.gif',
                    text1: 'Drawing',
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  NewPadding(
                    y: 0xff008080,
                    x: 0xfff9f906,
                    page: LoginScreen(),
                    image1: 'assets/gifs/number.gif',
                    text1: 'Numbers',
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  NewPadding(
                    y: 0xff191970,
                    x: 0xff24A6CA,
                    page: LoginScreen(),
                    image1: 'assets/gifs/vegetables.gif',
                    text1: 'vegetables',
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  NewPadding(
                    y: 0xffe3f988,
                    x: 0xff556b2f,
                    page: LoginScreen(),
                    image1: 'assets/gifs/family.gif',
                    text1: 'Family Members',
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  NewPadding(
                    y: 0xff480607,
                    x: 0xffffffff,
                    page: Homepage_Animal(),
                    image1: 'assets/gifs/R.gif',
                    text1: 'Animals',
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  NewPadding(
                    y: 0xffe3f988,
                    x: 0xffe9967a,
                    page: LoginScreen(),
                    image1: 'assets/gifs/fruits.gif',
                    text1: 'Fruits',
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  NewPadding(
                    y: 0xff00ffff,
                    x: 0xff262938,
                    page: LoginScreen(),
                    image1: 'assets/gifs/shape.gif',
                    text1: 'Shapes',
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  NewPadding(
                    y: 0xff800080,
                    x: 0xffc46210,
                    page: LoginScreen(),
                    image1: 'assets/gifs/dayes.gif',
                    text1: 'Days',
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  NewPadding(
                    y: 0xff98777b,
                    x: 0xffd8bfd8,
                    page: LoginScreen(),
                    image1: 'assets/gifs/ALetter.gif',
                    text1: 'ALetters',
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

class NewPadding extends StatelessWidget {
  final String image1;
  final String text1;
  final Widget page;

  final int x, y;

  const NewPadding({
    Key? key,
    required this.image1,
    required this.text1,
    required this.page,
    required this.x,
    required this.y,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 35),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => (page),
                ),
              );
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              //width: 250,
              height: 380,
              decoration: BoxDecoration(
                color: Color(x),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Column(
                  children: <Widget>[
                    Image(
                      height: 300,
                      width: 400,
                      image: AssetImage(image1),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text(
                        text1,
                        style: TextStyle(
                          color: Color(y),
                          fontSize: 20,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          // InkWell(
          //   hoverColor: Colors.blue,
          // onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>(page),),);},
          //   child: Container(
          //
          //
          //     width: 150,
          //     height: 200,
          //     decoration: BoxDecoration(
          //       color: Colors.white,
          //       borderRadius: BorderRadius.circular(15),
          //       boxShadow: [
          //         BoxShadow(
          //           color: Colors.grey.withOpacity(0.1),
          //           spreadRadius: 2,
          //           blurRadius: 5,
          //           offset: Offset(0, 0),
          //         ),
          //       ],
          //     ),
          //     child: Column(
          //       children: <Widget>[
          //         Padding(
          //           padding: EdgeInsets.symmetric(vertical: 8),
          //           child: Image(
          //             height: 150,
          //             width: 200,
          //             image: AssetImage(image2),
          //           ),
          //         ),
          //         Text(
          //           text2,
          //           style: TextStyle(
          //               color: Colors.black87,
          //               fontSize: 15,
          //               decoration: TextDecoration.none),
          //         )
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
