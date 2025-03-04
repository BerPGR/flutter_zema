import 'package:zema/features/game_details/data/datasources/remote_comment_data_source.dart';
import 'package:zema/features/game_details/data/models/comment.dart';
import 'package:zema/features/game_details/domain/entities/comment.dart';
import 'package:zema/features/game_details/domain/respositories/comment_repository.dart';

class CommentRepositoryImpl implements CommentRepository {
  final RemoteCommentDataSource _remoteCommentDataSource;

  CommentRepositoryImpl(this._remoteCommentDataSource);

  @override
  Future<List<CommentEntity>> fetchComments(int id) async {
    try {
      final List<CommentModel> comments =
          await _remoteCommentDataSource.fetchComments(id);
      return comments
          .map((comment) => CommentEntity.fromModel(comment))
          .toList();
    } catch (e) {
      print(e);
      return [];
    }
  }

  @override
  Future<void> addComment(Map<String, dynamic> comment) async {
    try {
      await _remoteCommentDataSource.addComment(comment);
    } catch (e) {
      print(e);
    }
  }
}
