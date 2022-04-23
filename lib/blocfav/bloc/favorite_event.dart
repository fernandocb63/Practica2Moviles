part of 'favorite_bloc.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}

class FavoriteCambiar extends FavoriteEvent {}

class OnCreateSaveDataEvent extends FavoriteEvent{
  final String cancion;
  final String autor;
  final String url;
  final String img;

  OnCreateSaveDataEvent({required this.autor,required this.cancion, required this.url, required this.img});

  @override
  List<Object> get props => [cancion, autor, img, url];
}
