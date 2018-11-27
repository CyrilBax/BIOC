import 'package:flutter/material.dart';

// Page de reference pour les resultats

class Resultat extends StatelessWidget{
  Resultat (GlobalKey key) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: Text("vous etes sur la page des resultats"),
      ),

    );
  }


}