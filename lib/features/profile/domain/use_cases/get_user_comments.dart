import 'package:zema/core/usecases/usecase.dart';
import 'package:zema/features/game_details/domain/entities/comment.dart';
import 'package:zema/features/profile/domain/repositories/user_comments_repository.dart';

class GetUserCommentsUseCase implements UseCase<List<CommentEntity>, String> {
  final UserCommentsRepository _userCommentsRepository;

  GetUserCommentsUseCase(this._userCommentsRepository);

  @override
  Future<List<CommentEntity>> call(String userId) async {
    return await _userCommentsRepository.getUserComments(userId);
  }
}