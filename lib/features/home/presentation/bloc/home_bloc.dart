import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zema/features/home/domain/entities/game.dart';
import 'package:zema/features/home/domain/use_cases/get_games.dart';
import 'package:zema/features/home/domain/use_cases/search_games.dart';
import 'package:zema/features/home/domain/use_cases/top_reviews.dart';
import 'package:zema/features/home/presentation/bloc/home_event.dart';
import 'package:zema/features/home/presentation/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetGamesUseCase _getGamesUseCase;
  final SearchGamesUseCase _searchGamesUseCase;
  final TopReviewsUseCase _topReviewsUseCase;

  HomeBloc(this._getGamesUseCase, this._searchGamesUseCase, this._topReviewsUseCase) : super(HomeLoading()) {
    on<LoadGamesEvent>((event, emit) async {
      emit(HomeLoading());
      try {
        final trendingGames = await _getGamesUseCase({});
        final topReviewGames = await _topReviewsUseCase({});
        emit(HomeDone(trendingGames, topReviewGames));
      } catch (e) {
        print(e);
        emit(HomeFailed());
      }
    });

    on<SearchGameEvent>((event, emit) async {
      emit(HomeSearch([]));
    });

    on<SearchingGameEvent>((event, emit) async {
      emit(HomeSearch([]));
      try {
        final searchedGames = await _searchGamesUseCase(event.query);
        emit(HomeSearch(searchedGames));
      } catch (e) {
        print(e);
      }
    });
  }
}
