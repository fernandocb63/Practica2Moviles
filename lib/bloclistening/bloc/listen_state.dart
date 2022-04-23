part of 'listen_bloc.dart';

abstract class ListenState extends Equatable {
  const ListenState();
  
  @override
  List<Object> get props => [];
}

class ListenInitial extends ListenState {}

class ListenErrorState extends ListenState {
  late final String errorMsg;

  ListenErrorState({required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}


class ListenSelected extends ListenState {
  final String img;
  final String cancion;
  final String autor;
  final String url;
  final String album;
  final String spotifi;
  final String apple;
  final String date;

  ListenSelected({required this.autor,required this.cancion, required this.url, required this.album, required this.img, required this.spotifi, required this.apple, required this.date});

  @override
  List<Object> get props => [autor,cancion];
}
