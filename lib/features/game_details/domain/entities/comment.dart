import 'package:zema/features/game_details/data/models/comment.dart';
import 'package:zema/features/home/data/model/game.dart';

class CommentEntity {
  final int? id;
  final String? gameId;
  final String? username;
  final double? stars;
  final String? content;

  const CommentEntity({
    required this.id,
    required this.gameId,
    required this.username,
    required this.stars,
    required this.content,
  });

  factory CommentEntity.fromModel(ComemntModel cModel) {
    return CommentEntity(
      id: cModel.id,
      gameId: cModel.gameId,
      username: cModel.username,
      stars: cModel.stars,
      content: cModel.content,
    );
  }
}
