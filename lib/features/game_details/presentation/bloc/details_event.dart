abstract class DetailsEvent {}

class LoadCommentsEvent extends DetailsEvent {
  final String id;

  LoadCommentsEvent(this.id);
}