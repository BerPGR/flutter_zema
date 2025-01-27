import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:go_router/go_router.dart';
import 'package:zema/features/game_details/presentation/bloc/details_bloc.dart';
import 'package:zema/features/game_details/presentation/bloc/details_event.dart';
import 'package:zema/features/game_details/presentation/bloc/details_state.dart';
import 'package:zema/features/game_details/presentation/widgets/about_game_detail.dart';
import 'package:zema/features/game_details/presentation/widgets/info_game_detail.dart';
import 'package:zema/features/home/domain/entities/game.dart';

class GameDetailsPage extends StatelessWidget {
  final GameEntity game;
  const GameDetailsPage({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    final detailsBloc = context.read<DetailsBloc>();
    detailsBloc.add(LoadCommentsEvent(game.id!));

    final stars = ((game.rating! / 10) / 2).floor().toDouble();
    final rating = (game.rating! / 10).floor().toDouble();

    return Scaffold(
        appBar: AppBar(
          title: Text("${game.name}"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(
                "https://images.igdb.com/igdb/image/upload/t_1080p/${game.screenshot}.jpg",
                fit: BoxFit.fill,
                height: 260,
                width: double.infinity,
              ),
              Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                      spacing: 32,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AboutGameDetail(
                            name: game.name!,
                            about: game.storyline != ''
                                ? game.storyline!
                                : (game.summary ?? "No story about"),
                            genres: game.genres!),
                        InfoGameDetail(
                            stars: stars,
                            rating: rating,
                            platforms: game.platforms!),
                        Text(
                          "Community reviews",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w700),
                        ),
                        BlocBuilder<DetailsBloc, DetailsState>(
                            builder: (context, state) {
                          if (state is DetailsLoading) {
                            return Center(child: CircularProgressIndicator());
                          }

                          if (state is DetailsDone) {
                            final comments = state.comments;
                            return Column(
                              spacing: 12,
                              children: [
                                if (comments.length == 0)
                                  Text(
                                    "There's no comments for this game.\nBe the first to comment!",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 18),
                                  )
                                else
                                  for (var comment in comments)
                                    Card(
                                      color: Theme.of(context).cardColor,
                                      margin: const EdgeInsets.only(bottom: 16),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          spacing: 12,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                                spacing: 12,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  CircleAvatar(
                                                    radius: 20,
                                                    child: Text(
                                                        "${comment.username!.split("")[0]}"),
                                                  ),
                                                  Text("${comment.username}"),
                                                ]),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                StarRating(
                                                  rating: comment.stars!,
                                                  allowHalfRating: false,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  borderColor:
                                                      Colors.grey.shade800,
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${comment.title}",
                                                  style: TextStyle(
                                                      fontSize: 26,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  "${comment.content}",
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 18.0),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              padding: const EdgeInsets.all(14),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10))),
                                          onPressed: () {
                                            context.push("/addcomment",
                                                extra: game);
                                          },
                                          child: Text(
                                            "Add Comment",
                                            style: TextStyle(fontSize: 18),
                                          )),
                                    ),
                                  ),
                                )
                              ],
                            );
                          }
                          return SizedBox.shrink();
                        })
                      ]))
            ],
          ),
        ));
  }
}
