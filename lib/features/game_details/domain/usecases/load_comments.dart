import 'package:zema/core/usecases/usecase.dart';
import 'package:zema/features/game_details/domain/entities/comment.dart';
import 'package:zema/features/game_details/domain/respositories/comment_repository.dart';

class LoadCommentsUseCase implements UseCase<List<CommentEntity>, String> {
  final CommentRepository _commentRepository;

  LoadCommentsUseCase(this._commentRepository);

  @override
  Future<List<CommentEntity>> call(String id) async {
    return await _commentRepository.fetchComments(id);
  }
  
}