abstract class DetailsEvent {}

class LoadCommentsEvent extends DetailsEvent {
  final int id;

  LoadCommentsEvent(this.id);
}

class AddCommentEvent extends DetailsEvent {
  final Map<String, dynamic> comment;

  AddCommentEvent(this.comment);
}