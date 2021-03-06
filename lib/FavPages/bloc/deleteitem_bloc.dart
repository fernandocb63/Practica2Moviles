import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';


part 'deleteitem_event.dart';
part 'deleteitem_state.dart';

class DeleteitemBloc extends Bloc<DeleteitemEvent, DeleteitemState> {
  DeleteitemBloc() : super(DeleteitemInitial()) {
    on<DeleteMyFav>(_deleteData);
  }
  FutureOr<void> _deleteData(DeleteMyFav event, Emitter emit) async {
    Map<String, dynamic> Mapacancion = {
      "title": event.deletemyFav["title"],
      "autor": event.deletemyFav["autor"],
      "url": event.deletemyFav["url"],
      "img": event.deletemyFav["img"],
    };
    bool _saved = await deletesong(Mapacancion);

    if(_saved){
      emit(DeleteSuccess());
    } else {
      emit(DeleteError());
    }
  }

  Future<bool> deletesong(Map<String, dynamic> deletemyFav) async {
      try{
      var qUser = await FirebaseFirestore.instance
        .collection("Usuarios")
        .doc("${FirebaseAuth.instance.currentUser!.uid}");

      var docsRef = await qUser.get();
      List<dynamic> listIds = docsRef.data()?["Favoritos"];

      List<dynamic> Listdelete = []; 


      for(var song in listIds){
        if(!mapEquals(song, deletemyFav)){
          Listdelete.add(song);
        }
      }
      var deletesong = await FirebaseFirestore.instance
        .collection("Usuarios")
        .doc("${FirebaseAuth.instance.currentUser!.uid}")
        .update({'Favoritos': Listdelete});
      print(Listdelete);
      //await qUser.update({"Favoritos": listIds});
      return true;
      
    }catch(e){
      print("Error: $e");
      return false;
    }
  }
}
