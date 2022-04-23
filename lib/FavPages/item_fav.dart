import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:practica2_f/FavPages/Fav_items.dart';
import 'package:practica2_f/FavPages/bloc/favitems_bloc.dart';
import 'package:practica2_f/FavPages/fav_page.dart';

class FavItem extends StatefulWidget {
  FavItem({Key? key}) : super(key: key);

  @override
  State<FavItem> createState() => _FavItemState();
}

class _FavItemState extends State<FavItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Favoritos")),
      body: BlocConsumer<FavitemsBloc, FavitemsState>(
        listener: (context, state) {
          //Show snackbar
        },
        builder: (context, state) {
          if(state is FavpageLoading){
            return ListView.builder(
              itemCount: 25,
              itemBuilder: (BuildContext context, int index){
                return YoutubeShimmer();
              },
            );
          } else if(state is FavpageVacio){
            return Center(
              child: Text("No hay datos por mostrar"),
            );
          } else if (state is FavpageSuccess){
            return ListView.builder(
              itemCount: state.myFav.length,
              itemBuilder: (BuildContext context, int index){
              return FavItems(mapacancion: state.myFav[index]);
              });
          }else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
