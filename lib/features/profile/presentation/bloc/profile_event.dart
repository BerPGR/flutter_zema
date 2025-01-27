abstract class ProfileEvent {}

class ProfileLoadCommentsEvent extends ProfileEvent {
  final String userId;

  ProfileLoadCommentsEvent(this.userId);
}
