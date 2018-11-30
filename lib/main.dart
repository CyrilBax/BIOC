import 'dart:convert';
import 'dart:io';
import 'package:biocapp/JsonClass.dart';
import 'PageServiceList.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import "package:system_info/system_info.dart";


//import des pages
import 'Formulaire.dart';
import 'Resultat.dart';
import 'Dev.dart';

//Lancement de l'application
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  static final HomePageKey = new GlobalKey<_HomePageState>();

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'BIOC',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      debugShowCheckedModeBanner: false,
      //On appel notre page principal
      home: new HomePage( key: HomePageKey),
    );
  }

}

//*************//
//Page d'acceuil
//*************//


class HomePage extends StatefulWidget {

  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => new  _HomePageState();
}

//---------------------//
//---------------------//

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {

  final List<Tab> myTabs = <Tab>[
    new Tab(
      text: "Service",
      icon: Icon(Icons.android),
    ),
    new Tab(
      text: "Formulaire",
      icon: Icon(Icons.format_align_justify),
    ),
    new Tab(
      text: "Resultat",
      icon: Icon(Icons.done),
    ),
    new Tab(
      text: "A propos",
      icon: Icon(Icons.info),
    ),
  ];

  ///Controller de la tabbar
  TabController _tabcontroller;

  FutureBuilder _futureBuilder;

  int _indexFormulaire;

  int get indexFormulaire => _indexFormulaire;

  set indexFormulaire(int value) {
    _indexFormulaire = value;
  }

  TabController get tabcontroller => _tabcontroller;

  FutureBuilder get futurBuilder => _futureBuilder;

  ///List des service
  ///Accès dans toutes les pages
  ServiceList _service;

  ServiceList get service => _service;

  set service(ServiceList value) {
    _service = value;
  }

  int _formulaireindex;

  int get formulaireindex => _formulaireindex;

  set formulaireindex(int value) {
    _formulaireindex = value;
  }

  /// Creation de la directory de notre fichier
  Directory _directory;

  Directory get directory => _directory;

  set directory(Directory value) {
    _directory = value;
  }

  ///List des valeurs rentrer par l'utilisateur
  List<String> _ListEssai = [];

  List<String> get ListEssai => _ListEssai;

  set ListEssai(List<String> value) {
    _ListEssai = value;
  }

  List<String> _controlleur =[];

  List<String> get controlleur => _controlleur;

  set controlleur(List<String> value) {
    _controlleur = value;
  }

  int MEGABYTE = 1024 * 1024;
  var processors = SysInfo.processors;

  @override

  Widget build(BuildContext context) {

    _tabcontroller = new TabController( vsync: this, length: myTabs.length);



    return new DefaultTabController(
      length: 4, // Nombre d'onglet
      child: Scaffold(
        appBar: AppBar(
            title: Text("bioc app flutter"),

            // Icon nous permettant d'afficher une alert dialog avec les informations de l'application ainsi que celles du telephone

            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.help_outline),
                onPressed:(){

                  showDialog<String>(
                      context: context,
                      barrierDismissible: false, // L'utilisateur doit cliquer sur le bouton pour quitter l'alert dialog
                      builder: (BuildContext context) => AlertDialog(
                        title: Text("Information système", textAlign: TextAlign.center),
                        content: Text("Number of processors: ${processors.length}\nTot physical memory:  ${SysInfo.getTotalPhysicalMemory()~/MEGABYTE} MB\nFree physical memory: ${SysInfo.getFreePhysicalMemory() ~/ MEGABYTE} MB\nFree virtual memory : ${SysInfo.getFreeVirtualMemory() ~/ MEGABYTE} MB"),
                        actions: <Widget>[
                          FlatButton(
                            child: Text("Bon chance", style: Theme.of(context).textTheme.button), // style pour ne pas qu'il soit transparent
                            color: Colors.grey, // couleur du bouton
                            onPressed: () => Navigator.pop(context), // Retourner a la page precedente
                          )
                        ],
                      )
                  );
                },
              )
            ],
            bottom: new TabBar(
                controller: tabcontroller,
                tabs: myTabs
            )
        ),
        body: TabBarView( // Contenue des page. Il faudra créer des conditions pour avoir le service en cours et ne pas afficher le reste
          controller: _tabcontroller,
          children: [  // Le contenue des pages que nous avons créer
            Container( child: PageServiceList(GlobalKey())),
            Container(child: Formulaire(GlobalKey())),
            Container(child: Resultat(GlobalKey())),
            Container(child: Dev(GlobalKey())),
          ],

        ),
      ),
    );
  }


  Future<String> _loadServiceAsset() async {
    return await rootBundle.loadString('JsonFile/exemple.json');
  }

  Future <ServiceList> loadService() async {
    String jsonService = await _loadServiceAsset();
    final jsonResponse = json.decode(jsonService);
    return ServiceList.fromJson(jsonResponse['services']);
  }

}