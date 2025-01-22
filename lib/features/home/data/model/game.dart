class GameModel {
  final String id;
  final String name;
  final String storyline;
  final String cover;
  
  GameModel({required this.id, required this.name, required this.storyline, required this.cover});

  factory GameModel.fromJson(Map<String, dynamic> json) {
    return GameModel(
      id: json['id'],
      name: json['name'],
      storyline: json['storyline'],
      cover: json['cover']['image_id'],
    );
  }
}