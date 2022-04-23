import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'favitems_event.dart';
part 'favitems_state.dart';

class FavitemsBloc extends Bloc<FavitemsEvent, FavitemsState> {
  FavitemsBloc() : super(FavitemsInitial()) {
    on<FavitemsEvent>(getfavorites);
  }
    FutureOr<void> getfavorites(event, emit) async {
      emit(FavpageLoading());
      try{
        var queryUser = await FirebaseFirestore.instance
          .collection("Usuarios")
          .doc("${FirebaseAuth.instance.currentUser!.uid}");

        var docsRef = await queryUser.get();
        List<dynamic> listIds = docsRef.data()?["Favoritos"] ?? [];


        emit(FavpageSuccess(myFav: listIds));


      }catch(e){
        print("Error al obtener todos los items");
        emit(FavpageError());
      }
    }

  }
