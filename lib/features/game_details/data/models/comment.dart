class ComemntModel {
  int? id;
  String? gameId;
  String? username;
  double? stars;
  String? content;

  ComemntModel({
    required this.id,
    required this.gameId,
    required this.username,
    required this.stars,
    required this.content,
  });

  factory ComemntModel.fromJson(Map<String, dynamic> json) {
    return ComemntModel(
        id: json['id'] ?? 0,
        gameId: json["game_id"] ?? "",
        username: json["username"] ?? "",
        stars: json["stars"] ?? 0.0,
        content: json["content"] ?? "");
  }
}
