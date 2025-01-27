import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:go_router/go_router.dart';
import 'package:zema/core/service/firebase.dart';
import 'package:zema/features/game_details/presentation/bloc/details_bloc.dart';
import 'package:zema/features/game_details/presentation/bloc/details_event.dart';

class AddCommentPage extends StatefulWidget {
  final int gameId;
  const AddCommentPage({super.key, required this.gameId});

  @override
  State<AddCommentPage> createState() => _AddCommentPageState();
}

class _AddCommentPageState extends State<AddCommentPage> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final authService = AuthService();
  double userRating = 0;

  final _formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final detailsBloc = context.read<DetailsBloc>();
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {
                                  context.pop();
                                },
                                icon: Icon(Icons.chevron_left, size: 32)),
                            Text(
                              "Write a Review",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 28,
                        ),
                        Text(
                          "Title",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Summarize your experience in one sentence",
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: _titleController,
                          decoration: InputDecoration(
                            hintText:
                                "e.g. The best game I've played this year",
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Title is required.";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 28,
                        ),
                        Text(
                          "Review",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Tell us more abou what you think of the game",
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: _contentController,
                          minLines: 3,
                          maxLines: 10,
                          decoration: InputDecoration(
                            hintText: "Share your thoughts with other players",
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Review is required.";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 28,
                        ),
                        Text(
                          "Rate",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Rate the game based on your experience",
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        StarRating(
                          size: 32,
                          rating: userRating,
                          allowHalfRating: false,
                          color: Theme.of(context).primaryColor,
                          borderColor: Colors.grey.shade800,
                          onRatingChanged: (rating) => setState(
                            () {
                              userRating = rating;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            if (userRating == 0) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      "Please provide a rating for the game."),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            }

                            Map<String, dynamic> data = {
                              "gameId": widget.gameId,
                              "userId": authService.currentUser!.uid,
                              "username": authService.currentUser!.displayName,
                              "title": _titleController.text,
                              "content": _contentController.text,
                              "stars": userRating,
                            };

                            detailsBloc.add(AddCommentEvent(data));
                            context.pop();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        child: Text(
                          "Submit",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    //SizedBox(
                    //  width: double.infinity,
                    //  child: ElevatedButton(
                    //    onPressed: () {},
                    //    style: ElevatedButton.styleFrom(
                    //        padding: const EdgeInsets.all(14),
                    //        shape: RoundedRectangleBorder(
                    //            borderRadius: BorderRadius.circular(10)),
                    //        backgroundColor: Color(0xff213d4a)),
                    //    child: Text(
                    //      "Save draft",
                    //      style: TextStyle(fontSize: 18),
                    //    ),
                    //  ),
                    //),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
