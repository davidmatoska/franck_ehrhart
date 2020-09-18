import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'package:franck_ehrhart/buyer/lovethisplace.dart';
import 'package:franck_ehrhart/buyer/placeinfo.dart';
import 'package:franck_ehrhart/webviews/remaxsearch.dart';

import 'package:page_transition/page_transition.dart';




class Page3  extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OUTILS ACHETEURS"),
        centerTitle: true,
        backgroundColor: Colors.blue.shade900,
      ),
      /// VerticalNavbar - Drawer


      drawer: ClipRRect(
    borderRadius: BorderRadius.only(
    topRight: Radius.circular(35), bottomRight: Radius.circular(35)),
    child: Drawer
      (
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: Container(color: Colors.blue.shade900,
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                // child: Text('OUTILS VENDEUR'),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    image: DecorationImage(
                        image: AssetImage("assets/images/8.jpg"),
                        fit: BoxFit.cover)
                ),
              ),
              Text('OUTILS ACHETEUR',
                style: TextStyle(

                  fontSize: 20.0,
                  fontFamily: 'Source Sans Pro',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20.0,
                width: 150.0,
                child: Divider(
                  color: Colors.white,
                ),
              ),
              ListTile(
                leading: Icon(FontAwesome.check_square,
                  color: Colors.white,
                ),
                title: Text('BIENS DISPONIBLES',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontFamily: 'Source Sans Pro',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.push(context, PageTransition(type: PageTransitionType.upToDown, child: Remaxsearch('https://www.remax.lu/','BIENS DISPONIBLES'),duration: Duration(seconds:2),));
                },
              ),
              ListTile(
                leading: Icon(FontAwesome.heart,
                  color: Colors.white,
                ),
                title: Text("J'AIME CET ENDROIT",
                  style: TextStyle(
                    fontSize: 15.0,
                    fontFamily: 'Source Sans Pro',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.push(context, PageTransition(type: PageTransitionType.upToDown, child: Lovethisplace(),duration: Duration(seconds:2),));
                },
              ),
              ListTile(
                leading: Icon(FontAwesome.map_o,
                  color: Colors.white,
                ),
                title: Text('INFOS QUARTIER',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontFamily: 'Source Sans Pro',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.push(context, PageTransition(type: PageTransitionType.upToDown, child: Placeinfo(),duration: Duration(seconds:2),));
                },
              ),

              ListTile(
                leading: Icon(FontAwesome.long_arrow_left,
                  color: Colors.white,
                ),
                title: Text('RETOUR',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontFamily: 'Source Sans Pro',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    ),

        body:
    Container(
    decoration: BoxDecoration(
    image: DecorationImage(
    image: AssetImage("assets/images/10.jpg"), fit: BoxFit.cover)),
    child:Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: 40,
            top: 150,
            right: 10,
            bottom: 20,
          ),
    child: Center(
    child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            /*Image.asset("assets/images/3.png",
              width: 300.0,
            ),*/


            Text(
              "Vous cherchez un bien?",
              style: TextStyle(
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(1.0, 1.0),
                    blurRadius: 4.0,
                    color: Colors.white,
                  ),
                  Shadow(
                    offset: Offset(1.0, 1.0),
                    blurRadius: 4.0,
                    color: Colors.white,
                  ),
                ],
                fontFamily: 'Source Sans Pro',
                fontSize: 20.0,
                letterSpacing: 2.5,
                color: Colors.blue.shade900,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20.0,
              width: 150.0,
              child: Divider(
                color: Colors.teal.shade100,
              ),
            ),

            Card(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              child: ListTile(

                leading: Icon(
                  FontAwesome.check_square,
                  color: Colors.blue,
                ),

                title: Text(

                  "Consultez les biens disponibles dans le réseau RE/MAX et contactez-moi pour les visites."
                  //  "J'utilise une méthode professionnelle basée sur un diagnostic complet de votre maison/appartement et une analyse du marché et de la concurrence."
                  ,
                  textAlign: TextAlign.justify,
                  style: TextStyle(

                    fontFamily: 'Source Sans Pro',
                    fontSize: 12.0,
                    letterSpacing: 2.0,
                    color: Colors.blue.shade900,
                    fontWeight: FontWeight.bold,

                  ),

                ),
              ),
            ),

            Card(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              child: ListTile(

                leading: Icon(
                  FontAwesome.heart,
                  color: Colors.blue,
                ),

                title: Text(

                  "Prenez en photo les lieux qui vous plaisent avec l'outil J'AIME CET ENDROIT, et organisons ensemble les recherches."
                  //  "J'utilise une méthode professionnelle basée sur un diagnostic complet de votre maison/appartement et une analyse du marché et de la concurrence."
                  ,
                  textAlign: TextAlign.justify,
                  style: TextStyle(

                    fontFamily: 'Source Sans Pro',
                    fontSize: 12.0,
                    letterSpacing: 2.0,
                    color: Colors.blue.shade900,
                    fontWeight: FontWeight.bold,

                  ),

                ),
              ),
            ),

            Card(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              child: ListTile(

                leading: Icon(
                  FontAwesome.map,
                  color: Colors.blue,
                ),

                title: Text(

                  "Utilisez l'outil INFOS QUARTIER pour repérer en temps réel les commodités du quartier: écoles, transports..."
                  //  "J'utilise une méthode professionnelle basée sur un diagnostic complet de votre maison/appartement et une analyse du marché et de la concurrence."
                  ,
                  textAlign: TextAlign.justify,
                  style: TextStyle(

                    fontFamily: 'Source Sans Pro',
                    fontSize: 12.0,
                    letterSpacing: 2.0,
                    color: Colors.blue.shade900,
                    fontWeight: FontWeight.bold,

                  ),

                ),
              ),
            ),



          ],
        ),
      ),
    ),
        ),
    ),
    );
  }
}