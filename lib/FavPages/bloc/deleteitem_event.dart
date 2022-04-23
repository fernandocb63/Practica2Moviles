part of 'deleteitem_bloc.dart';

abstract class DeleteitemEvent extends Equatable {
  const DeleteitemEvent();

  @override
  List<Object> get props => [];
}

class DeleteMyFav extends DeleteitemEvent{
  final Map<String, dynamic> deletemyFav;

  DeleteMyFav({required this.deletemyFav});

  @override
  List<Object> get props => [deletemyFav];

}
