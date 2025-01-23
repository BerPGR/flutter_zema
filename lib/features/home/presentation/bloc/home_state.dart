import 'package:zema/features/home/domain/entities/game.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}
class HomeDone extends HomeState {
  final List<GameEntity> games;
  final List<GameEntity> topReviews;

  HomeDone(this.games, this.topReviews);
}

class HomeFailed extends HomeState {}

class HomeSearch extends HomeState {
  final List<GameEntity> searchedGames;

  HomeSearch(this.searchedGames);
}