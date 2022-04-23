import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:practica2_f/secrets/secrets.dart';
import 'package:record/record.dart';
import 'package:http/http.dart' as http;


part 'listen_event.dart';
part 'listen_state.dart';

class ListenBloc extends Bloc<ListenEvent, ListenState> {
  ListenBloc() : super(ListenInitial()) {
    on<ListenCambiar>(CancionCambiar);
  }
  void CancionCambiar(ListenEvent event, Emitter emit)async {
    var cancion = await getcancion();
    print(cancion);
    if(cancion != null){
      emit(ListenSelected(cancion: cancion["title"],album: cancion["album"], img: cancion["spotify"]["album"]["images"][0]["url"], autor: cancion["artist"], url: cancion["song_link"], spotifi: cancion["spotify"]["external_urls"]["spotify"], apple: cancion["apple_music"]["url"], date: cancion["release_date"]));
    }
    else{
      emit(ListenErrorState(errorMsg: "Error"));
    }
  }


  Future getcancion()async{
  Duration tiempo = Duration(seconds: 10);
  final record = Record();
  try{
      bool result = await record.hasPermission();
      await record.start(
        encoder: AudioEncoder.AAC, // by default
        bitRate: 128000, // by default
        samplingRate: 44100, // by default
      );
      await Future.delayed(tiempo);
      var recorded = await record.stop();
      if(recorded == null){
        return;
      }
      File recorded2 = File(recorded);

      final bytes = recorded2.readAsBytesSync();
      String img64 = base64Encode(bytes);

      http.Response res = await http.post(Uri.parse("https://api.audd.io/"), body: {
        'audio': img64,
        'return': 'apple_music,spotify',
        'api_token': ApiKey
      });
      //log(jsonDecode(res.body).toString());
      if(res.statusCode == HttpStatus.ok){
        return jsonDecode(res.body)["result"];
      }


    }catch(e){
      print(e);
    }
  }
}
