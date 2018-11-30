import 'package:flutter/material.dart';
import 'main.dart';

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
            new Divider(),
            new SizedBox(height: 20.0),
            new Text("Application BIOC crée par\n", style: Theme.of(context).textTheme.title),
            new SizedBox(height: 20.0),
            new Divider(),
            new SizedBox(height: 20.0),
            new Text("Cyril", style: Theme.of(context).textTheme.headline),
            new SizedBox(height: 20.0),
            new Text("David", style: Theme.of(context).textTheme.headline),
            new SizedBox(height: 20.0),
            new Text("Julien", style: Theme.of(context).textTheme.headline),
            new SizedBox(height: 20.0),
            new Text("Ergys", style: Theme.of(context).textTheme.headline),
            new SizedBox(height: 20.0),
            new ButtonBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                    child :RaisedButton(
                        child: Text("Return"),
                        color: Colors.grey,
                        onPressed: (){
                          MyApp.HomePageKey.currentState.tabcontroller.animateTo(MyApp.HomePageKey.currentState.tabcontroller.index = 0);
                        }
                    )
                ),
              ],
            )
          ],
        )
      )
    );
  }


}