import 'dart:convert';
import 'package:biocapp/JsonClass.dart';
import 'PageServiceList.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:device_info/device_info.dart';
import 'dart:async';


//import des pages
import 'Alert.dart';
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
      //routes: <String, WidgetBuilder>{
      //  '/Form' : (BuildContext context) => new Formulaire(),
      //},
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

  TabController _tabcontroller;

  FutureBuilder _futureBuilder;

  int _indexFormulaire;

  int get indexFormulaire => _indexFormulaire;

  set indexFormulaire(int value) {
    _indexFormulaire = value;
  }

  TabController get tabcontroller => _tabcontroller;

  FutureBuilder get futurBuilder => _futureBuilder;

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

  @override
  Widget build(BuildContext context) {

    _tabcontroller = new TabController( vsync: this, length: myTabs.length);

    var _futurBuilder = new  FutureBuilder(
      future: loadService(),
      builder: (context,snapshot){

        if(snapshot.hasData){
          //return snapshot.data;
          return Text("Ok");
        } else if (snapshot.hasError){
          print("nop");
          return Text("${snapshot.error}");
        }
      },
    );

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
                        title: Text("Alert dialog"),
                        content: Text("info application"), // créer une collumn pour afficher plus clairement toute les informations
                        actions: <Widget>[
                          FlatButton(
                            child: Text("OK", style: Theme.of(context).textTheme.button), // style pour ne pas qu'il soit transparent
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