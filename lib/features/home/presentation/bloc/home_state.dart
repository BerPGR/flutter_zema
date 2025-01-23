import 'package:zema/features/home/domain/entities/game.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeDone extends HomeState {
  final List<GameEntity> games;

  HomeDone(this.games);
}

class HomeFailed extends HomeState {}