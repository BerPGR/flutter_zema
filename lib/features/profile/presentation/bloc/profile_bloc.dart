import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zema/features/profile/domain/use_cases/get_user_comments.dart';
import 'package:zema/features/profile/presentation/bloc/profile_event.dart';
import 'package:zema/features/profile/presentation/bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetUserCommentsUseCase _getUserCommentsUseCase;

  ProfileBloc(this._getUserCommentsUseCase) : super(ProfileLoading()) {
    on<ProfileLoadCommentsEvent>((event, emit) async {
      emit(ProfileLoading());
      try {
        final userComments = await _getUserCommentsUseCase(event.userId);
        emit(ProfileDone(userComments));
      } catch (e) {
        print(e);
        emit(ProfileFailed());
      }
    });
  }
}
