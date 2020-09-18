import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:franck_ehrhart/seller/compasstool.dart';
import 'package:franck_ehrhart/seller/surfaces.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';

import'package:franck_ehrhart/webviews/maxmatch.dart';

class Page2  extends StatelessWidget {

  _launchEmailEstimation() async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: 'franck.ehrhart@remax.lu',
      query: "subject=Estimation&body=Bonjour Franck,%0D%0A%0D%0AJe souhaite faire estimer mon bien.%0D%0A%0D%0AMes coordonnées sont les suivantes:%0D%0APrénom et nom:%0D%0ATéléphone:%0D%0A%0D%0APour un bien situé:%0D%0A%0D%0AJe vous remercie. ", //add subject and body here
    );

    var url = params.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OUTILS VENDEURS"),
        centerTitle: true,
        backgroundColor: Colors.blue.shade900,
      ),
      /// VerticalNavbar - Drawer

      drawer: ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(35), bottomRight: Radius.circular(35)),
        child: Drawer(
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
                        image: AssetImage("assets/images/3.png"),
                        fit: BoxFit.cover)
                ),
              ),
              Text('OUTILS VENDEUR',
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
                leading: Icon(FontAwesome.superpowers,
                  color: Colors.white,
                ),
                title: Text('MAX MATCH',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontFamily: 'Source Sans Pro',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.push(context, PageTransition(type: PageTransitionType.upToDown, child: Maxmatch('https://www.remax.lu/sellersportal.aspx','MAXMATCH'),duration: Duration(seconds:2),));
                },
              ),

              ListTile(
                leading: Icon(FontAwesome.compass,
                  color: Colors.white,
                ),
                title: Text('ORIENTATION PIECES',
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
                  Navigator.push(context, PageTransition(type: PageTransitionType.upToDown, child: CompassTool(),duration: Duration(seconds:2),));
                },
              ),

              ListTile(
                leading: Icon(FontAwesome.map,
                  color: Colors.white,
                ),
                title: Text('CALCUL SURFACES',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontFamily: 'Source Sans Pro',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.push(context, PageTransition(type: PageTransitionType.upToDown, child: Surfaces(),duration: Duration(seconds:2),));
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
    image: AssetImage("assets/images/9.jpg"), fit: BoxFit.cover)),
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

            Text(
              "Besoin d'aide pour vendre?",
              textAlign: TextAlign.center,
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
                  FontAwesome.euro,
                  color: Colors.blue,
                ),

                title: Text(

                  "Déterminer le bon prix  est la première étape d'une transaction réussie. Contactez-moi et déterminons ensemble la valeur de marché de votre bien."
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
              color: Colors.blue,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              child: ListTile(
                leading: Icon(
                  Icons.check,
                  color: Colors.white,
                ),
                title: Text(
                  'Je veux une estimation !',
                  style: TextStyle(
                    fontFamily: 'Source Sans Pro',
                    fontSize: 15.0,
                    letterSpacing: 2.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: _launchEmailEstimation,
              ),
            ),

            Text(
              "Mes outils pour vendre",
              textAlign: TextAlign.center,
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
                  FontAwesome.superpowers,
                  color: Colors.blue,
                ),

                title: Text(

                  "Vous pouvez savoir combien d'acheteurs potentiels cherhcent un bien similaire au vôtre grâce à l'outil MAXMATCH. La force de mon réseau à votre service."
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
                  FontAwesome.compass,
                  color: Colors.blue,
                ),

                title: Text(

                  "Préparez votre dossier de vente! L'outil ORIENTATION PIECES vous permet de vérifier l'orientation de chaque source de lumière."
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

                  "Mesurez la surface de votre jardin ou de votre terrain grâce à l'outil CALCUL SURFACES. Il vous suffit de géolocaliser votre position et d'indiquer au moins 4 points pour connaître la surface. "
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