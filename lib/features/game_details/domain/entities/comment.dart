import 'package:zema/features/game_details/data/models/comment.dart';

class CommentEntity {
  final int? gameId;
  final String? username;
  final double? stars;
  final String? title;
  final String? content;

  const CommentEntity({
    required this.gameId,
    required this.username,
    required this.stars,
    required this.title,
    required this.content,
  });

  factory CommentEntity.fromModel(ComemntModel cModel) {
    return CommentEntity(
      gameId: cModel.gameId,
      username: cModel.username,
      stars: cModel.stars,
      title: cModel.title,
      content: cModel.content,
    );
  }
}
