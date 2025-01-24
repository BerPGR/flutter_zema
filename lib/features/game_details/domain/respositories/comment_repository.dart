import 'package:zema/features/game_details/domain/entities/comment.dart';

abstract class CommentRepository {
  Future<List<CommentEntity>> fetchComments(String id);
}