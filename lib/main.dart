import 'package:franck_ehrhart/pages/page1.dart';
import 'package:franck_ehrhart/pages/page2.dart';
import 'package:franck_ehrhart/pages/page3.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}



class _MyHomePageState extends State<MyHomePage> {
  static int _currentPage = 0; // this will move the navigation bar to the current index

  static final PageController _pageController = PageController(
    initialPage: _currentPage,
    keepPage: true,
  );

  Widget buildPageView() {
    return PageView(
      controller: _pageController,
      onPageChanged: (index) {
        setState(() {
          _currentPage = index; // update index when swap
        });
      },
      children: <Widget>[
        // Your pages
      ],
    );
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(

      body: PageView(

          controller: _pageController,
          children: <Widget>[

            Page1(),
            Page2(),
            Page3(),

          ],
          onPageChanged: (int index) {
            setState(() {

              _pageController.jumpToPage(index); // move page when you press a button
              _currentPage = index; // and update the index
            });
          }
      ),

        bottomNavigationBar: CurvedNavigationBar(
          index: _currentPage, // update bottom bar index
          // initialIndex: pageIndex,
          items: <Widget>[
            Column(
                children: <Widget>[
                  Image.asset(
                    'assets/images/icon1.png',height: 60, width: 60,
                  ),
                  Text('AGENT',
                    style: TextStyle(
                      fontSize: 8.0,
                      fontFamily: 'Source Sans Pro',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),

            Column(
                children: <Widget>[
                  Image.asset(
                    'assets/images/icon2.png',height: 60, width: 60,
                  ),
                  Text('VENDEUR',
                    style: TextStyle(
                      fontSize: 8.0,
                      fontFamily: 'Source Sans Pro',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),

            Column(
                children: <Widget>[
                  Image.asset(
                    'assets/images/icon3.png',height: 60, width: 60,
                  ),
                  Text('ACHETEUR',
                    style: TextStyle(
                      fontSize: 8.0,
                      fontFamily: 'Source Sans Pro',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),

          ],
          color: Colors.blue.shade900,
          buttonBackgroundColor: Colors.red.shade800,
          backgroundColor: Colors.white,
          animationCurve: Curves.easeIn,
          animationDuration: Duration(milliseconds: 1000),
          height: 65.0,
          onTap: (index) {
            setState(() {
              _pageController.jumpToPage(index); // move page when you press a button
              _currentPage = index; // and update the index
            });
          },
        ),

      );
  }
}
