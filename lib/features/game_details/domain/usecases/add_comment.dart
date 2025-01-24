import 'package:zema/core/usecases/usecase.dart';
import 'package:zema/features/game_details/domain/respositories/comment_repository.dart';

class AddCommentUseCase implements UseCase<void, Map<String, dynamic>> {
  final CommentRepository _commentRepository;

  AddCommentUseCase(this._commentRepository);

  @override
  Future<void> call(Map<String, dynamic> comment) async {
    return await _commentRepository.addComment(comment);
  }
}
