import 'dart:convert';

import 'package:biocapp/JsonClass.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'main.dart';


///Class Formulaire
class Formulaire extends StatefulWidget {


  Formulaire(GlobalKey key) : super(key: key,);
  @override
  _FormulaireState createState() => _FormulaireState();
}


///State Formulaire
class _FormulaireState extends State<Formulaire> {

  int _indexForm = MyApp.HomePageKey.currentState.indexFormulaire;

  int taille = MyApp.HomePageKey.currentState.service.service[MyApp.HomePageKey.currentState.indexFormulaire].element.length - 1;

  List<Widget> ListWidget = [];

  File jsonFile;
  Directory dir;
  String fileName = "${MyApp.HomePageKey.currentState.service.service[MyApp.HomePageKey.currentState.indexFormulaire].title}.json";
  bool fileExists = false;
  Map<dynamic, dynamic> fileContent;
  List<String> ListEssai = MyApp.HomePageKey.currentState.ListEssai;


  ///Fonction d'ajout de widget dans la list
  addWidget(){
      for( int i = 1 ; i <= taille ; i++){
        ListWidget.add(CreationFormulaire(context, i));
      }
  }



  @override
  void initState(){
    super.initState();
    print("enter initfile");
    getApplicationDocumentsDirectory().then((Directory directory) {
      print("enter directory");
      dir = directory;
      MyApp.HomePageKey.currentState.directory = dir;
      jsonFile = new File(dir.path  + "/" + fileName);
      fileExists = jsonFile.existsSync();
      if (fileExists) this.setState(() => fileContent = json.decode(jsonFile.readAsStringSync()));
    });
  }



  void createFile(Map<dynamic, dynamic> content, String fileName) {
    print("Creating file!");
    File file = new File(dir.path + "/" + fileName);
    file.createSync();
    fileExists = true;
    file.writeAsStringSync(json.encode(content));
  }

  void writeToFile(String key, List<String> value) {
    print("Writing to file!");
    Map<String, dynamic> content = {key : ListEssai};
    if (fileExists) {
      print("File exists");
      Map<String, dynamic> jsonFileContent = json.decode(jsonFile.readAsStringSync());
      jsonFileContent.addAll(content);
      jsonFile.writeAsStringSync(json.encode(jsonFileContent));
    } else {
      print("File does not exist!");
      createFile(content, fileName);
    }
    this.setState(() => fileContent = json.decode(jsonFile.readAsStringSync()));

//    ServiceList servicerecup = ServiceList.fromJson(fileContent['Netflix']);
//    print(servicerecup.service[0].title);
    /*fileContent.forEach(iterateMapEntry);
    print("");*/
  }

  iterateMapEntry(key, value) {
    fileContent[key];
    print('$key:$value');
    return Text("hello");
  }

  @override
  Widget build(BuildContext context) {


    ///Création de la list
    ///Seulement si elle est vide
      if(ListWidget.length == 0){
        addWidget();
      }

      if(MyApp.HomePageKey.currentState.indexFormulaire == null){
        return Container(
          child: ListTile(
            title: Text("Aucun service selectionner\ntry again"),
            trailing: RaisedButton(
                onPressed: () {
                  MyApp.HomePageKey.currentState.tabcontroller.index = 0;
                }
            ),
          ),
        );
      }


    return Scaffold(
      body: new Column(
        children: <Widget>[
          SizedBox(height: 20.0),
          Flexible(
              child: ListView.builder(
                  itemCount: taille,
                  itemBuilder: ( BuildContext context, int index) {
                    return Column(
                      children: <Widget>[
                        ListWidget[index],
                        Divider()
                      ],
                    );
                  }
              )
          ),
          Center(
              child :RaisedButton(
                  child: Text("Submit"),
                  color: Colors.grey,
                  onPressed: (){
                    writeToFile(ListEssai[0], ListEssai);
                    MyApp.HomePageKey.currentState.ListEssai.clear();
                    MyApp.HomePageKey.currentState.tabcontroller.animateTo(MyApp.HomePageKey.currentState.tabcontroller.index + 1);
                  }
              )
          )
        ],
      ),
    );
  }

}


///
/// Class de création d'un element du formulaire
///
///



class CreationFormulaire extends StatefulWidget {

  int i;

  CreationFormulaire(BuildContext context, this.i);

  @override
  _CreationFormulaireState createState() => _CreationFormulaireState();
}

class _CreationFormulaireState extends State<CreationFormulaire> {

  ServiceList serviceFormulaire = MyApp.HomePageKey.currentState.service;
  int _indexForm = MyApp.HomePageKey.currentState.indexFormulaire;
  bool _switchvalue = false;
  String _dropvalue;
  bool _buttonvalue = false;

  final text = TextEditingController();

  @override
  void dispose() {
    text.dispose();
    super.dispose();
  }

  @override
  void initState() {
    MyApp.HomePageKey.currentState.ListEssai.add(text.text);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    MyApp.HomePageKey.currentState.formulaireindex ++ ;

    return Container(
      child: creation(),
    );
  }

  Widget creation(){


    switch(serviceFormulaire.service[_indexForm].element[widget.i].type){


    ///
    /// S'il est du type Edit
    ///
      case "edit" :
        String name = serviceFormulaire.service[_indexForm].element[widget.i].value.toString();
        return TextFormField(
          controller: text,
          decoration: InputDecoration(
            border: UnderlineInputBorder(),
            filled: true,
            icon: Icon(Icons.person),
            labelText: serviceFormulaire.service[_indexForm].element[widget.i].value.removeLast(),
          ),
          onEditingComplete: (){
            MyApp.HomePageKey.currentState.ListEssai.add(" $name: ${text.text}");
            //MyApp.HomePageKey.currentState.ListEssai.add(text.text); // On ajoute le text valider dans la list
            SystemChannels.textInput.invokeMethod('TextInput.hide'); // Fonction permettant l'arret du clavier
          },
        );
        break;



    ///
    /// S'il est du type RadioGroup
    ///
      case "radioGroup" :
        List<String> menuItem = serviceFormulaire.service[_indexForm].element[widget.i].value;
        final List<DropdownMenuItem<String>> _dropDownMenuItems = menuItem.map(
                (String value) => DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            )
        ).toList();
        return ListTile(
          title: Text(serviceFormulaire.service[_indexForm].element[widget.i].section),
          trailing: DropdownButton(
            items: _dropDownMenuItems,
            value: _dropvalue,
            hint: Text("Choose"),
            onChanged: ((String value) {
              setState(() {
                _dropvalue = value;
                MyApp.HomePageKey.currentState.ListEssai.add("${serviceFormulaire.service[_indexForm].element[widget.i].section.toString()}: ${_dropvalue.toString()}");
              });
            }),
          ),
        );
        break;



    ///
    /// S'il est du type label
    ///
      case "label":
        return Text(
          serviceFormulaire.service[_indexForm].element[widget.i].section,
          textAlign: TextAlign.center,
        );
        break;


    ///
    /// S'il est du type switch
    ///
      case "switch":
        return ListTile(
          title: Text(serviceFormulaire.service[_indexForm].element[widget.i].section),
          trailing: Switch(
            activeColor: Colors.blue,
            onChanged: (bool value){
              setState(() {
                _switchvalue = value;
                MyApp.HomePageKey.currentState.ListEssai.add("${serviceFormulaire.service[_indexForm].element[widget.i].section.toString()}: ${_switchvalue.toString()}");
              });
            },
            value: _switchvalue,
          ),
        );
        break;


    ///
    /// S'il est du type boutton
    ///
      case "button":

        return ListTile(
          title: Text("${serviceFormulaire.service[_indexForm].element[widget.i].section.toString()}  ${serviceFormulaire.service[_indexForm].element[widget.i].value.toString()}"),
          trailing: Checkbox(
            activeColor: Colors.blue,
            onChanged: (bool value){
              setState(() {
                _buttonvalue = value;
                MyApp.HomePageKey.currentState.ListEssai.add("${serviceFormulaire.service[_indexForm].element[widget.i].value.toString()}: ${_buttonvalue.toString()}");
              });
            },
            value: _buttonvalue,
          ),
        );
        break;

    }
  }



}