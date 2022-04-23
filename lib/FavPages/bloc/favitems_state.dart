part of 'favitems_bloc.dart';

abstract class FavitemsState extends Equatable {
  const FavitemsState();
  
  @override
  List<Object> get props => [];
}

class FavitemsInitial extends FavitemsState {}

class FavpageSuccess extends FavitemsState {
  final List<dynamic> myFav;

  FavpageSuccess({required this.myFav});

  @override
  List<Object> get props => [myFav];
}


class FavpageLoading extends FavitemsState {}
class FavpageError extends FavitemsState {}
class FavpageVacio extends FavitemsState {}
