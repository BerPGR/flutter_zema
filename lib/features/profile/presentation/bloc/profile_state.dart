import 'package:zema/features/game_details/domain/entities/comment.dart';

abstract class ProfileState {}

class ProfileDoneInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileDone extends ProfileState {
  final List<CommentEntity> comments;

  ProfileDone(this.comments);
}

class ProfileFailed extends ProfileState {}
