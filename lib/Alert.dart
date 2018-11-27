import 'package:flutter/material.dart';
import 'package:device_info/device_info.dart';
import 'PageServiceList.dart';
import 'Resultat.dart';
import 'Dev.dart';
import 'Formulaire.dart';

// Page de test de nos widgets


class alert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            flexibleSpace: FlexibleSpaceBar(
              title: Text("BIOC app"),
              background: Image.network("https://img3.telestar.fr/var/telestar/storage/images/3/0/5/6/3056045/netflix-annonce-des-projets-france_width1024.png"),
            ),
          )
        ],
      ),
    );
  }
}

