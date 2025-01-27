class CommentModel {
  int? gameId;
  String? gameName;
  String? gameCoverId;
  String? userId;
  String? username;
  double? stars;
  String? title;
  String? content;

  CommentModel({
    required this.gameId,
    required this.gameName,
    required this.gameCoverId,
    required this.userId,
    required this.username,
    required this.stars,
    required this.title,
    required this.content,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
        gameId: json["gameId"] ?? 0,
        userId: json["userId"] ?? "",
        username: json["username"] ?? "",
        stars: json["stars"] ?? 0.0,
        title: json["title"] ?? "",
        content: json["content"] ?? "",
        gameName: json['gameName'] ?? "",
        gameCoverId: json["gameCoverId"]);
  }
}
