import 'dart:convert';

import 'package:biocapp/JsonClass.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Alert.dart';
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

  ///Fonction d'ajout de widget dans la list
  addWidget(){
    ListWidget.add(CreationFormulaire());
  }

  affichage(){
    for(int i= 0; i<=taille; i++){
      return ListWidget[i];
    }
  }


  @override
  Widget build(BuildContext context) {

    ///Création de la list
    for(int i = 0; i< taille; i++){
      addWidget();
    }

    return Scaffold(
      body: new Column(
        children: <Widget>[
          SizedBox(height: 20.0),
          Flexible(
                /*child: ListView.builder(
                    itemCount: taille,
                    itemBuilder: ( BuildContext context, int index) => ListWidget[index]
                )*/
                child: ListView(
                  children: ListWidget,
                ),
            ),
        ],
      ),
    );
  }

}


///
/// Creation d'un element du formulaire
///


class CreationFormulaire extends StatefulWidget {
  @override
  _CreationFormulaireState createState() => _CreationFormulaireState();
}

class _CreationFormulaireState extends State<CreationFormulaire> {

  ServiceList serviceFormulaire = MyApp.HomePageKey.currentState.service;
  int _indexForm = MyApp.HomePageKey.currentState.indexFormulaire;
  int _index = MyApp.HomePageKey.currentState.formulaireindex;
  bool _switchvalue = false;
  String _dropvalue;
  bool _buttonvalue = false;
  String _textvalue;

  @override
  Widget build(BuildContext context) {

    MyApp.HomePageKey.currentState.formulaireindex ++ ;
    return Container(
      child: creation(),
    );
  }

  Widget creation(){


    switch(serviceFormulaire.service[_indexForm].element[_index].type){


    ///
    /// S'il est du type Edit
    ///
      case "edit" :
        return TextFormField(
          decoration: InputDecoration(
            border: UnderlineInputBorder(),
            filled: true,
            icon: Icon(Icons.person),
            labelText: serviceFormulaire.service[_indexForm].element[_index].value.removeLast(),
          ),
          onSaved: (String value) {
              this._textvalue = value;
          },
        );
        break;



    ///
    /// S'il est du type RadioGroup
    ///
      case "radioGroup" :
        List<String> menuItem = serviceFormulaire.service[_indexForm].element[_index].value;
        final List<DropdownMenuItem<String>> _dropDownMenuItems = menuItem.map(
            (String value) => DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            )
        ).toList();
        return ListTile(
          title: Text(serviceFormulaire.service[_indexForm].element[_index].section),
          trailing: DropdownButton(
              items: _dropDownMenuItems,
              value: _dropvalue,
              hint: Text("Choose"),
              onChanged: ((String value) {
                setState(() {
                  _dropvalue = value;
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
            serviceFormulaire.service[_indexForm].element[_index].section,
            textAlign: TextAlign.center,
        );
        break;


    ///
    /// S'il est du type switch
    ///
      case "switch":
        return ListTile(
          title: Text(serviceFormulaire.service[_indexForm].element[_index].section),
          trailing: Switch(
            activeColor: Colors.blue,
            onChanged: (bool value){
              setState(() {
                _switchvalue = value;
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
          title: Text(serviceFormulaire.service[_indexForm].element[_index].section),
          trailing: Checkbox(
            activeColor: Colors.blue,
            onChanged: (bool value){
              setState(() {
                _buttonvalue = value;
              });
            },
            value: _buttonvalue,
          ),
        );
        break;

    }
  }
}