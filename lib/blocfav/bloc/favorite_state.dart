part of 'favorite_bloc.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();
  
  @override
  List<Object> get props => [];
}

class FavoriteInitial extends FavoriteState {}

class CreateLoadingState extends FavoriteState {}
class CreateSuccessState extends FavoriteState {}
class Createfoto_shareErrorState extends FavoriteState {}



