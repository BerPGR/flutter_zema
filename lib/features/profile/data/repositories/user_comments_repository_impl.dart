import 'package:zema/features/game_details/data/models/comment.dart';
import 'package:zema/features/game_details/domain/entities/comment.dart';
import 'package:zema/features/profile/data/data_source/remote_user_comments_ds.dart';
import 'package:zema/features/profile/domain/repositories/user_comments_repository.dart';

class UserCommentsRepositoryImpl implements UserCommentsRepository {
  final RemoteUserCommentsDataSource _remoteUserCommentsDataSource;

  UserCommentsRepositoryImpl(this._remoteUserCommentsDataSource);

  @override
  Future<List<CommentEntity>> getUserComments(String userId) async {
    try {
      final List<CommentModel> userComments = await _remoteUserCommentsDataSource.fetchUserComments(userId);
      return userComments.map((game) => CommentEntity.fromModel(game)).toList();
    } catch (e) {
      return [];
    }
  }
}
