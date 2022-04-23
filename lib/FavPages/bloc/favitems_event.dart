part of 'favitems_bloc.dart';

abstract class FavitemsEvent extends Equatable {
  const FavitemsEvent();

  @override
  List<Object> get props => [];
}

class GetMyFavorites extends FavitemsEvent{}