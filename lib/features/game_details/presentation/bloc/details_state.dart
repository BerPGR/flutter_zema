import 'package:zema/features/game_details/domain/entities/comment.dart';

abstract class DetailsState {}

class DetailsInitial extends DetailsState {}

class DetailsLoading extends DetailsState {}

class DetailsDone extends DetailsState {
  final List<CommentEntity> comments;

  DetailsDone(this.comments);
}

class DetailsFailed extends DetailsState {}