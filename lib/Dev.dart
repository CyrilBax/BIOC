import 'package:flutter/material.dart';

// Page d'information sur les developpeur de l'application

class Dev extends StatelessWidget{

  Dev (GlobalKey key) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Text(""),
            new Text("Application BIOC crée par\n", style: Theme.of(context).textTheme.title),
            new Text(""),
            new Text("Cyril", style: Theme.of(context).textTheme.headline),
            new Text("David", style: Theme.of(context).textTheme.headline),
            new Text("Julien", style: Theme.of(context).textTheme.headline),
            new Text("Ergys", style: Theme.of(context).textTheme.headline),
          ],
        )
      ),
    );
  }


}