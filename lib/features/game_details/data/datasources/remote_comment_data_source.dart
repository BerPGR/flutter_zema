import 'package:dio/dio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zema/features/game_details/data/models/comment.dart';

class RemoteCommentDataSource {
  final Dio dio;

  RemoteCommentDataSource(this.dio);

  Future<List<ComemntModel>> fetchComments(String id) async {
    try {
          final collection = FirebaseFirestore.instance.collection("comments");
      final QuerySnapshot snapshot = await collection.where('game_id', isEqualTo: id).get();
      
      if (snapshot.size == 0) {
        return [];
      }
      
      List<ComemntModel> comments = snapshot.docs.map((doc) {
        return ComemntModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      return comments;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
