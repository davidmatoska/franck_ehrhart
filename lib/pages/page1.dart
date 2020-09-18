import 'package:flutter/material.dart';
import 'package:franck_ehrhart/webviews/mesbiens.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:franck_ehrhart/about/perso.dart';
import 'package:franck_ehrhart/about/vision.dart';
import 'package:franck_ehrhart/about/referal.dart';


class Page1  extends StatelessWidget {

  final String phone = 'tel:+352661585300';

  var whatsapp ="whatsapp://send?phone=+352661585300";

  var facebook = "https://www.facebook.com/FranckREMAX/";

  var linkremax = "https://www.remax.lu/fr-lu/agents/centre/mersch-mersch/franck-ehrhart/280271008";



  _callPhone() async {
    if (await canLaunch(phone)) {
      await launch(phone);
    } else {
      throw 'Could not Call Phone';
    }
  }

  _launchEmail() async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: 'franck.ehrhart@remax.lu',
      query: 'subject=Contact', //add subject and body here
    );

    var url = params.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchWhatsApp() async {
    if (await canLaunch(whatsapp)) {
      await launch(whatsapp);
    } else {
      throw 'Could not open WhatsApp';
    }
  }

  _launchFacebook() async {
    if (await canLaunch(facebook)) {
      await launch(facebook);
    } else {
      throw 'Could not launch $facebook';
    }
  }

  _launchLinkRemax() async {
    if (await canLaunch(linkremax)) {
      await launch(linkremax);
    } else {
      throw 'Could not launch $linkremax';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("VOTRE AGENT"),
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
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      image: DecorationImage(
                          image: AssetImage("assets/images/8.jpg"),
                          fit: BoxFit.cover)
                  ),
                ),
                Text('VOTRE AGENT',
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
                  leading: Icon(FontAwesome.heartbeat,
                    color: Colors.white,
                  ),
                  title: Text('MES VALEURS',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontFamily: 'Source Sans Pro',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context, PageTransition(type: PageTransitionType.upToDown, child: Valeurs(),duration: Duration(seconds:2),));
                  },
                ),

                ListTile(
                  leading: Icon(FontAwesome.camera_retro,
                    color: Colors.white,
                  ),
                  title: Text('A PROPOS DE MOI',
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
                    Navigator.push(context, PageTransition(type: PageTransitionType.upToDown, child: Perso(),duration: Duration(seconds:2),));
                  },
                ),

                ListTile(
                  leading: Icon(FontAwesome.home,
                    color: Colors.white,
                  ),
                  title: Text('MES BIENS',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontFamily: 'Source Sans Pro',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context, PageTransition(type: PageTransitionType.upToDown, child: Mesbiens('https://www.remax.lu/fr-lu/agents/centre/mersch-mersch/franck-ehrhart/280271008','MES BIENS'),duration: Duration(seconds:2),));
                  },
                ),

                ListTile(
                  leading: Icon(FontAwesome.dollar,
                    color: Colors.white,
                  ),
                  title: Text("APPORTEUR D'AFFAIRES",
                    style: TextStyle(
                      fontSize: 15.0,
                      fontFamily: 'Source Sans Pro',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context, PageTransition(type: PageTransitionType.upToDown, child: Referal(),duration: Duration(seconds:2),));
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

        body: Center(
        child: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
    child: Center(
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[

        CircleAvatar(
          radius: 90.0,
          backgroundImage: AssetImage('assets/images/1.jpg'),
        ),
        Text(
          'Franck Ehrhart',
          style: TextStyle(
            //  fontFamily: 'Pacifico',
            fontSize: 30.0,
            letterSpacing: 2.5,
            color: Colors.black,
          ),
        ),
        Text(
          'Mon conseiller immobilier',
          style: TextStyle(
            //   fontFamily: 'Source Sans Pro',
            fontSize: 20.0,
            letterSpacing: 2.5,
            color: Colors.blue.shade800,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 20.0,
          width: 150.0,
          child: Divider(
            color: Colors.blue.shade100,
          ),
        ),
        Card(

          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
          child: ListTile(
            leading: Icon(
              Icons.phone,
              color: Colors.blue.shade900,
            ),
            title: Text(
              '+352 661 585 300',
              style: TextStyle(
                fontSize: 20.0,
                fontFamily: 'Source Sans Pro',
                color: Colors.blue.shade900,
              ),
            ),
            onTap: _callPhone,
          ),
        ),
        Card(

          color: Colors.white,
          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
          child: ListTile(
            leading: Icon(
              Icons.email,
              color: Colors.blue.shade900,
            ),
            title: Text(
              'franck.ehrhart@remax.lu',
              style: TextStyle(
                fontSize: 15.0,
                fontFamily: 'Source Sans Pro',
                color: Colors.blue.shade900,
              ),
            ),
            onTap: _launchEmail,
          ),
        ),

        Container (
          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              InkWell(
                splashColor: Colors.blue,
                highlightColor: Colors.blue.withOpacity(1),
                radius: 50,
                customBorder: CircleBorder(),
                onTap: _launchLinkRemax,
                child: Image.asset(
                  'assets/images/remax.png',
                  height: 50,
                  width: 50,
                ),
              ),

              InkWell(
                splashColor: Colors.red,
                highlightColor: Colors.blue.withOpacity(1),
                radius: 50,
                customBorder: CircleBorder(),
                onTap: _launchWhatsApp,
                child: Image.asset(
                  'assets/images/whatsapp.png',
                  height: 50,
                  width: 50,
                ),
              ),

              InkWell(
                splashColor: Colors.blue,
                highlightColor: Colors.blue.withOpacity(1),
                radius: 50,
                customBorder: CircleBorder(),
                onTap: _launchFacebook,
                child: Image.asset(
                  'assets/images/facebook.png',
                  height: 40,
                  width: 40,
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
    );
  }
}