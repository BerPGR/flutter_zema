import 'package:dio/dio.dart';
import 'package:zema/core/constants/constants.dart';
import 'package:zema/features/home/data/model/game.dart';

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
          fields *, rating, cover.image_id, genres.name; 
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
}
