import 'package:zema/features/game_details/domain/entities/comment.dart';

abstract class UserCommentsRepository {

  Future<List<CommentEntity>> getUserComments(String userId);
}