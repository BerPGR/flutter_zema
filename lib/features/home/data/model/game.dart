class GameModel {
  int? id;
  String? name;
  String? storyline;
  String? imageId;
  
  GameModel({required this.id,  required this.name, required this.storyline,  required this.imageId});

  factory GameModel.fromJson(Map<String, dynamic> json) {
    return GameModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      storyline: json['storyline'] ?? json['summary'] ?? "No information" ,
      imageId: json['cover'] != null ? json['cover']['image_id'] : "dfgkfivjrhcksyymh9vw", // This is a default value
    );
  }
}