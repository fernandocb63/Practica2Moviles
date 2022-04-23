import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practica2_f/blocfav/bloc/favorite_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class CancionPage extends StatefulWidget {
  CancionPage({Key? key, required this.img, required this.cancion, required this.autor, required this.url, required this.album, required this.spotifi, required this.apple, required this.date}) : super(key: key);
  final String img;
  final String cancion;
  final String autor;
  final String url;
  final String album;
  final String spotifi;
  final String apple;
  final String date;
  @override
  State<CancionPage> createState() => _CancionPageState();
}

class _CancionPageState extends State<CancionPage> {
  void DialogFavoritos() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(
            "Agregar a favoritos",
          ),
          content:
              new Text("Se agregará esta canción a tu lista de favoritos."),
          actions: [
            MaterialButton(
              child: new Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            MaterialButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  BlocProvider.of<FavoriteBloc>(context).add(OnCreateSaveDataEvent(cancion: widget.cancion, autor: widget.autor, url: widget.url, img: widget.img));
                  ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Se agrego la cancion a Favoritos"),
              ),
            );
                },
                child: Text('Agregar'))
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text('Cancion'),
          actions: [
            IconButton(
                onPressed: () {
                  DialogFavoritos();
                },
                icon: Icon(Icons.favorite))
          ],
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Image(
                    // Como queremos traer una imagen desde un url usamos NetworkImage
                    image: NetworkImage(widget.img),height: 350,
                  ),
                ),
                Text(widget.cancion,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 10,
                ),
                Text(
                  widget.autor,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(widget.date),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Abrir con:',
                  style: TextStyle(fontSize: 16),
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        launch(widget.spotifi);
                      },
                      child: Image.asset(
                        'assets/icons/spotify.png',
                        color: Colors.white,
                        height: 50,
                        width:50
                      ),
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(60, 60),
                          shape: CircleBorder(),
                          primary: Colors.transparent,
                          onPrimary: Colors.white),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        launch(widget.url);
                      },
                      child: Image.asset(
                        'assets/icons/phone.png',
                        color: Colors.white,
                        height: 50,
                        width:50
                      ),
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(60, 60),
                          shape: CircleBorder(),
                          primary: Colors.transparent,
                          onPrimary: Colors.white),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        launch(widget.apple);
                      },
                      child: Image.asset(
                        'assets/icons/apple.png',
                        color: Colors.white,
                        height: 50,
                        width:50
                      ),
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(60, 60),
                          shape: CircleBorder(),
                          primary: Colors.transparent,
                          onPrimary: Colors.white),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}