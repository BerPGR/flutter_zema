import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:zema/features/game_details/data/models/comment.dart';

class RemoteUserCommentsDataSource {
  final Dio dio;

  RemoteUserCommentsDataSource(this.dio);

  Future<List<CommentModel>> fetchUserComments(String userId) async {
    try {
      final collection = FirebaseFirestore.instance.collection("comments");
      final QuerySnapshot snapshot =
          await collection.where('userId', isEqualTo: userId).get();

      if (snapshot.size == 0) {
        return [];
      }

      List<CommentModel> comments = snapshot.docs.map((doc) {
        return CommentModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      return comments;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
