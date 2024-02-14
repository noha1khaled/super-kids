import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase/setting_screen.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class MainHomeScreen extends StatelessWidget {
  const MainHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        children: [
          DrawerScreen(),
          HomeScreen(),

        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Color(0xffe9967a),
        color:Colors.red.shade300,
        animationDuration: Duration(milliseconds: 300),
        onTap: (index) {
          // if(index==1) Navigator.push(context, MaterialPageRoute(builder: (context)=>(FavouriteScreen()),),);
          if(index==0)  Navigator.push(context, MaterialPageRoute(builder: (context)=>(MainHomeScreen()),),);

        } ,


        items: [
          Icon(Icons.home_filled,color: Colors.white,),
          Icon(Icons.favorite,color: Colors.white,),
          Icon(Icons.person,color: Colors.white,),

        ],),

    );
  }
}


