class CommentModel {
  int? gameId;
  String? userId;
  String? username;
  double? stars;
  String? title;
  String? content;

  CommentModel({
    required this.gameId,
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
        content: json["content"] ?? "");
  }
}
