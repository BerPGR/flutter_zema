import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zema/features/home/domain/use_cases/get_games.dart';
import 'package:zema/features/home/presentation/bloc/home_event.dart';
import 'package:zema/features/home/presentation/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState>{
  final GetGamesUseCase _getGamesUseCase;

  HomeBloc(this._getGamesUseCase) : super(HomeInitial()) {
    on<LoadMoreGamesHome>((event, emit) => doIt(event, emit)); 
  }

  void doIt(HomeEvent event, Emitter<HomeState> emit) {}
}