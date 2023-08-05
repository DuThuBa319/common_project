part of 'get_user_detail_bloc.dart';

@immutable
abstract class UserDetailEvent {}

class GetUserDetailEvent extends UserDetailEvent {
  final int userId;

  GetUserDetailEvent({required this.userId}) : super();
}

class DeleteUserEvent extends UserDetailEvent {
  final int userId;

  DeleteUserEvent({required this.userId}) : super();
}

class UpdateUserEvent extends UserDetailEvent {
  final int userId;
  final UserModel user;

  UpdateUserEvent({required this.userId, required this.user}) : super();
}

class PickImageEvent extends UserDetailEvent {
  PickImageEvent({this.source});
  final ImageSource? source;
}

class DeleteImageEvent extends UserDetailEvent {}

// ignore: must_be_immutable
class ReplaceImageEvent extends UserDetailEvent {
  ReplaceImageEvent({this.source});
  ImageSource? source;
}

class LoadImageEvent extends UserDetailEvent {
  LoadImageEvent({this.imageFile});
  final File? imageFile;
}

class ImageChangedEvent extends UserDetailEvent {
  ImageChangedEvent({this.imageFiles});
  final List<XFile>? imageFiles;
}

// class FilterUserEvent extends UserEvent {
//   FilterUserEvent({required this.searchText});
//   String searchText;
//   @override
//   List<Object> get props => [];
// }



