// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practica2_f/FavPages/bloc/favitems_bloc.dart';
import 'package:practica2_f/FavPages/item_fav.dart';
import 'package:practica2_f/auth/bloc/auth_bloc.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:practica2_f/cancion_page.dart';
import 'package:practica2_f/FavPages/fav_page.dart';
import 'package:record/record.dart';

import 'bloclistening/bloc/listen_bloc.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool sh = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FindTrackApp'),
      ),
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children: [
            SizedBox(
              height: 50,
            ),
            Text("Toque para escuchar!"),
            SizedBox(
              height: 75,
            ),
            AvatarGlow(
              animate: sh,
              endRadius: 100.0,
              glowColor: Colors.white,
              child: BlocConsumer<ListenBloc, ListenState>(
                listener: (context, state) {
                  if(state is ListenSelected){
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => CancionPage(cancion: state.cancion, album: state.album, img: state.img, autor: state.autor, url: state.url, spotifi: state.spotifi, apple: state.apple, date: state.date)));
                    sh = false;
                    setState(() {
                      
                    });
                  }

                  else{
                    sh=false;
                    setState(() {
                      
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("No se reconocio la cancion"),
                    ),
                  );
                  }
                },
                builder: (context, state) {
                  return IconButton(
                    icon: Image.asset("assets/icons/audiow.png",
                        width: 200, height: 100),
                    iconSize: 100,
                    onPressed: () async {
                      sh = true;
                      setState(() {
                        
                      });
                      BlocProvider.of<ListenBloc>(context).add(ListenCambiar());

                    },
                  );
                },
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      BlocProvider.of<FavitemsBloc>(context).add(GetMyFavorites());
                        Navigator.push(context,MaterialPageRoute(
                            builder: (context) => FavItem()));
                    },
                    icon: Icon(Icons.favorite)),
                IconButton(
                    icon: Icon(Icons.power_settings_new),
                    onPressed: () {
                      showAlertDialog(context);
                    })
              ],
            ),
          ],
        ),
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
  Widget cancelButton = TextButton(
    child: Text(
      "Cancelar",
      style: TextStyle(
          fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
    ),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = TextButton(
    child: Text(
      "OK",
      style: TextStyle(
          fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
    ),
    onPressed: () {
      BlocProvider.of<AuthBloc>(context).add(SignOutEvent());
    },
  );
  AlertDialog alert = AlertDialog(
    title: Text("Cerra Sesion"),
    content: Text("Seguro que quieres cerrrar sesion?"),
    actions: [cancelButton, continueButton],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
