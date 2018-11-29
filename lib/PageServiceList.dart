import 'dart:convert';

import 'package:biocapp/JsonClass.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'PageServiceList.dart';

// Import des pages nescessaires
import 'Formulaire.dart';
import 'Alert.dart'; // Page de test de nos widgets
import 'main.dart'; // Import pour la global key

class PageServiceList extends StatelessWidget {


  PageServiceList (GlobalKey key) : super(key: key);

  int _ind;


  int get ind => _ind;

  @override
  Widget build(BuildContext context) {



  var futureBuilder = new FutureBuilder(
  future: MyApp.HomePageKey.currentState.loadService(),
  builder: (context,snapshot){
    if(snapshot.hashCode!= null){
      return CreateCard(context, snapshot);
    }else if ( snapshot.hasError){
      return Text("${snapshot.error}");
    }
    }
  );


    return new Scaffold(
      body: futureBuilder,
    );

  }

  ///Future qui nous permet de lire et récuperer nos information du fichier Json


  Widget CreateCard (BuildContext context, AsyncSnapshot snapshot){

    ServiceList service = snapshot.data;
    //ServiceList service = MyApp.HomePageKey.currentState.futurBuilder.future as ServiceList;
    //print(service.service[1].title);
    return new ListView.builder(
      itemCount: service.service.length,
      itemBuilder:(BuildContext context, int index){
        return Container(
          child: Center(
            child: Column(
              children: <Widget>[
                Card(
                    margin: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
                    child: Column(
                      children: <Widget>[
                        InkWell(
                          onTap: (){

                            MyApp.HomePageKey.currentState.indexFormulaire = index;

                            MyApp.HomePageKey.currentState.service = service;

                            MyApp.HomePageKey.currentState.formulaireindex = 1;

                            MyApp.HomePageKey.currentState.tabcontroller.animateTo(MyApp.HomePageKey.currentState.tabcontroller.index + 1);
                          },

                          // ** Chercher le titre de chaque service ( tant qu'ils existe ) et cherche l'element avec un titre et prendre son value

                          child: Image.network('${service.service[index].element[0].value.removeLast()}'),
                        ),
                        ButtonTheme.bar(
                          child: Text("${service.service[index].title}"),
                        )
                      ],
                    )
                ),
              ],
            ),
          ),
        );
      },
    );

  }
}