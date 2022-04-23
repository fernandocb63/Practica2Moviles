import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FavPage extends StatefulWidget {
  FavPage({Key? key, required this.mapacancion}) : super(key: key);

  final Map<String, dynamic> mapacancion;
  

  @override
  State<FavPage> createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Pagina Favoritos'),
        ),
        body: Center());
  }
}