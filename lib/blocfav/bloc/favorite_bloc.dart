import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';


part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteInitial()) {
    on<OnCreateSaveDataEvent>(_saveData);
  }
  FutureOr<void> _saveData(OnCreateSaveDataEvent event, Emitter emit) async {
    emit(CreateLoadingState());
    bool _saved = await _savefoto_share(event.cancion, event.autor, event.url, event.img);

    if(_saved){
      emit(CreateSuccessState());
    } else {
      emit(Createfoto_shareErrorState());
    }
  }
  

  Future<bool> _savefoto_share(String cancion,String autor,String url, String img) async {
    Map<String, dynamic> Mapacancion = {
      "title": cancion,
      "autor": autor,
      "url":url,
      "img":img,
    };
      try{
      var qUser = await FirebaseFirestore.instance
        .collection("Usuarios")
        .doc("${FirebaseAuth.instance.currentUser!.uid}");

      var docsRef = await qUser.get();
      List<dynamic> listIds = docsRef.data()?["Favoritos"];


      for(var song in listIds){
        if(mapEquals(song, Mapacancion)){
          return false;
        }
      }

      listIds.add(Mapacancion);

      await qUser.update({"Favoritos": listIds});
      return true;
      
    }catch(e){
      print("Error: $e");
      return false;
    }
  }
  
  }
