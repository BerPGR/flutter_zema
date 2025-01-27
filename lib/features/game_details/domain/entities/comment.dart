import 'package:zema/features/game_details/data/models/comment.dart';

class CommentEntity {
  final int? gameId;
  final String? gameName;
  final String? gameCoverId;
  final String? userId;
  final String? username;
  final double? stars;
  final String? title;
  final String? content;

  const CommentEntity({
    required this.gameName,
    required this.gameCoverId, 
    required this.gameId,
    required this.userId,
    required this.username,
    required this.stars,
    required this.title,
    required this.content,
  });

  factory CommentEntity.fromModel(CommentModel cModel) {
    return CommentEntity(
      gameName: cModel.gameName,
      gameCoverId: cModel.gameCoverId,
      gameId: cModel.gameId,
      userId: cModel.userId,
      username: cModel.username,
      stars: cModel.stars,
      title: cModel.title,
      content: cModel.content,
    );
  }
}
