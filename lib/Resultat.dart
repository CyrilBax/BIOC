import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'main.dart';

///**************************************************///
///******Page de reference pour les resultats*******///
///************************************************///

class Resultat extends StatefulWidget {

  Resultat(GlobalKey key) : super(key: key,);
  @override
  _ResultatState createState() => _ResultatState();
}


class _ResultatState extends State<Resultat> {

  ///Variable permettant la lecture du fichier Json local et l'affichage des résultats
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

  ///Fonction d'appel à la création de la liste des utilisateurs
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


    if(MyApp.HomePageKey.currentState.indexFormulaire != null){
      MyApp.HomePageKey.currentState.indexFormulaire = null;
    }

    return Scaffold(
      body: Center(
          child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                ///Card contenant les informations des utilisateurs
                Card(
                  elevation: 8.0,
                  margin: EdgeInsets.all(20.0),
                  child: Text(contenuMap.toString(), style: Theme.of(context).textTheme.title),
                ),
                SizedBox(height: 20.0),
                ///Button permetant de retourner sur la pages d'acceuil
                Center(
                    child :RaisedButton(
                        child: Text("Return"),
                        color: Colors.grey,
                        onPressed: (){
                          MyApp.HomePageKey.currentState.tabcontroller.animateTo(MyApp.HomePageKey.currentState.tabcontroller.index = 0);
                        }
                    )
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

///Classe permettant de créer un widget avec l'enssemble des informations d'un utilisateur ayant choisi le service courant


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


