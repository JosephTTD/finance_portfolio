import 'package:finance_portfolio/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({ Key? key }) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {

    double h = MediaQuery.of(context).size.height;
    
    return Container(
      color: const Color(0xff272a34),
      child: Padding(
          // ignore: prefer_const_constructors
          padding: EdgeInsets.fromLTRB(20, h * 0.04, 20, h * 0.04),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navItem(UniconsLine.home, const HomeScreen()),
              _navItem(UniconsLine.chart, const HomeScreen()),
              _navItem(UniconsLine.arrow_growth, const HomeScreen()),
              _navItem(UniconsLine.shopping_cart, const HomeScreen()),
              _navItem(UniconsLine.user_circle, const HomeScreen())
            ],
          )),
    );
  }

  Widget _navItem(icon, destination) {
    return Builder(builder: (context) {
      return InkWell(
        child: Icon(icon, size: 25, color: Colors.white,),
        onTap: () {
          setState(() {
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) => destination,
                transitionDuration: const Duration(seconds: 0),
              ),
            );
          });
        },
      );
    });
  }
}
