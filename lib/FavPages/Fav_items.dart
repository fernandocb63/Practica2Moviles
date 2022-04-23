import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practica2_f/FavPages/bloc/deleteitem_bloc.dart';
import 'package:practica2_f/FavPages/bloc/favitems_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class FavItems extends StatefulWidget {
  final Map<String, dynamic> mapacancion;
  FavItems({Key? key, required this.mapacancion}) : super(key: key);

  @override
  State<FavItems> createState() => _FavItemsState();
}

class _FavItemsState extends State<FavItems> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeleteitemBloc, DeleteitemState>(
      listener: (context, state) {
        if(state is DeleteSuccess){
          BlocProvider.of<FavitemsBloc>(context).add(GetMyFavorites());
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            GestureDetector(
              onTap: () {
                showAlertDialog(context);
              },
              child: Card(
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  margin: EdgeInsets.all(20),
                  elevation: 10,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Column(
                      children: <Widget>[
                        Image(
                          image: NetworkImage(widget.mapacancion["img"]),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(widget.mapacancion["title"]),
                            Text(widget.mapacancion["autor"]),
                          ],
                        ),
                      ],
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 30, 10, 0),
              child: IconButton(
                  onPressed: () {
                    showAlertDialog2(context);
                  },
                  icon: Icon(Icons.favorite)),
            ),
          ],
        );
      },
    );
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
      onPressed: () async {
        Navigator.of(context).pop();
        await launch(widget.mapacancion["url"]);
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("Info de cancion"),
      content: Text("Quiere ir a ver la cancion?"),
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

  showAlertDialog2(BuildContext context) {
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
      onPressed: () async {
        Navigator.of(context).pop();
        BlocProvider.of<DeleteitemBloc>(context)
            .add(DeleteMyFav(deletemyFav: widget.mapacancion));
        ;
        ;
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("Eliminar"),
      content: Text("Quieres eliminar la cancion de favoritos?"),
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
}
