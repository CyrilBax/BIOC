import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'main.dart';

/// Page de reference pour les resultats

class Resultat extends StatefulWidget {

  Resultat(GlobalKey key) : super(key: key,);
  @override
  _ResultatState createState() => _ResultatState();
}

class _ResultatState extends State<Resultat> {

  File jsonFile;
  Directory dir = MyApp.HomePageKey.currentState.directory;
  String fileName = "${MyApp.HomePageKey.currentState.service.service[MyApp.HomePageKey.currentState.indexFormulaire].title}.json";
  bool fileExists = false;
  Map<String, dynamic> fileContent;
  List<dynamic> contenuMap =[];


  @override
  initState(){
      super.initState();
      jsonFile = new File(dir.path  + "/" + fileName);
      fileExists = jsonFile.existsSync();
      if (fileExists) this.setState(() {
        fileContent = json.decode(jsonFile.readAsStringSync());
        affichage();
      } );
  }

  affichage(){
    if(fileExists == true){print("file exist");}
    print("longeur de file content :${fileContent.length}");
    fileContent.forEach(addWidget);
    print("file content : ${fileContent.toString()}");
  }

  ///Ajout de widget corespondant au clef valeur de la map
  ///Pour chaque couple clef valeur => ajouter un widget Text avec les informations relative a l'utilisateur
  addWidget(key, value){
    String clef = key.toString();
    List<dynamic> values = value;
    contenuMap.add(value);
  }

  @override
  Widget build(BuildContext context) {

    print("entrer dans le scafold principal");
    print("longeur de la liste de widget : ${contenuMap.length}");

    if(MyApp.HomePageKey.currentState.indexFormulaire != null){
      MyApp.HomePageKey.currentState.indexFormulaire = null;
    }

    return Scaffold(
      body: Center(
          child: Column(
              children: <Widget>[
                Card(
                  elevation: 8.0,
                  margin: EdgeInsets.all(20.0),
                  child: Text(contenuMap.toString(), style: Theme.of(context).textTheme.title),
                )
              ]
          )
      )
    );
  }

  Widget content(int index){
    return Card(
        child: Text("${contenuMap[index]}")
    );
  }
}

class Users extends StatefulWidget {

  String clef;
  List<dynamic> value;

  Users(  this.clef, this.value): super();

  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {

/*  CreateTextResultat(){
    for(int i = 0; i<= widget.value.length; i ++){
      return new Text("${widget.value[i].toString()}");
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Text("${widget.clef} ${widget.value}")
    );
  }
}


