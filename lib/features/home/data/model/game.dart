class GameModel {
  int? id;
  String? name;
  String? storyline;
  String? summary;
  String? imageId;
  List<dynamic>? genres;
  List<dynamic>? platforms;
  String? screenshot;
  double? rating;

  GameModel(
      {required this.id,
      required this.name,
      required this.storyline,
      required this.imageId,
      required this.summary,
      required this.genres,
      required this.platforms,
      required this.screenshot,
      required this.rating});

  factory GameModel.fromJson(Map<String, dynamic> json) {
    return GameModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      storyline: json['storyline'] ?? "",
      summary: json["summary"] ?? "",
      imageId: json['cover'] != null
          ? json['cover']['image_id']
          : "dfgkfivjrhcksyymh9vw", // This is a default value
      genres: json["genres"] ?? [],
      platforms: json["platforms"] ?? [],
      screenshot: json["screenshots"][0]["image_id"] ??
          "dfgkfivjrhcksyymh9vw", // This is a default value
      rating: json["total_rating"] ?? 0.0
    );
  }
}
