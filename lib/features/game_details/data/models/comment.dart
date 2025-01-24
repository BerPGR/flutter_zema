class ComemntModel {
  int? gameId;
  String? username;
  double? stars;
  String? title;
  String? content;

  ComemntModel({
    required this.gameId,
    required this.username,
    required this.stars,
    required this.title,
    required this.content,
  });

  factory ComemntModel.fromJson(Map<String, dynamic> json) {
    return ComemntModel(
        gameId: json["game_id"] ?? 0,
        username: json["username"] ?? "",
        stars: json["stars"] ?? 0.0,
        title: json["title"] ?? "",
        content: json["content"] ?? "");
  }
}
