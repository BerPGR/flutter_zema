abstract class HomeEvent {}

class LoadGamesEvent extends HomeEvent {}

class SearchGameEvent extends HomeEvent {}

class SearchingGameEvent extends HomeEvent {
  final String query;

  SearchingGameEvent({required this.query});
}