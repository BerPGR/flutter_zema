
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zema/features/game_details/domain/usecases/load_comments.dart';
import 'package:zema/features/game_details/presentation/bloc/details_event.dart';
import 'package:zema/features/game_details/presentation/bloc/details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final LoadCommentsUseCase _loadCommentUseCase;

  DetailsBloc(this._loadCommentUseCase) : super(DetailsInitial()) {
    on<LoadCommentsEvent>((event, emit) async {
      emit(DetailsLoading());
      try {
        final comments = await _loadCommentUseCase(event.id);
        emit(DetailsDone(comments));
      } catch (e) {
        emit(DetailsFailed());
      }
    });
  }
}