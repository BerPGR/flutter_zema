import 'package:dio/dio.dart';
import 'package:zema/core/constants/constants.dart';
import 'package:zema/features/home/data/model/game.dart';
import 'package:zema/features/home/domain/entities/game.dart';

class RemoteGameDataSource {
  final Dio dio;

  RemoteGameDataSource(this.dio);

  Future<List<GameModel>> fetchGames() async {
    try {
      final response = await dio.post(
        endpoint,
        options: Options(headers: {
          'Client-ID': clientId,
          'Authorization': 'Bearer ${bearerToken}'
        }),
        data: '''
          fields id, name, genres.name, summary, storyline, cover.image_id, screenshots.image_id, platforms.abbreviation, total_rating;
          limit 10; 
          where total_rating > 90 & total_rating_count > 100;
        ''',
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((game) => GameModel.fromJson(game)).toList();
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<GameModel>> searchGames(String query) async {
    try {
      final response = await dio.post(
        endpoint,
        options: Options(headers: {
          'Client-ID': clientId,
          'Authorization': 'Bearer $bearerToken'
        }),
        data: '''
          fields id, name, genres.name, summary, storyline, cover.image_id, screenshots.image_id, platforms.abbreviation, total_rating;
          search "$query";
        ''',
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((game) => GameModel.fromJson(game)).toList();
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<GameModel>> topReviewGames() async {
    try {
      final response = await dio.post(
        endpoint,
        options: Options(headers: {
          'Client-ID': clientId,
          'Authorization': 'Bearer $bearerToken'
        }),
        data: '''
          fields id, name, genres.name, summary, storyline, cover.image_id, screenshots.image_id, platforms.abbreviation, total_rating;
          limit 5; 
          where total_rating > 95 & total_rating_count > 500;
        ''',
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((game) => GameModel.fromJson(game)).toList();
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }
}
