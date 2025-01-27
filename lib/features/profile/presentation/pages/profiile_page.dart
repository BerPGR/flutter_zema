import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:zema/core/service/firebase.dart';
import 'package:zema/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:zema/features/profile/presentation/bloc/profile_event.dart';
import 'package:zema/features/profile/presentation/bloc/profile_state.dart';

class ProfilePage extends StatelessWidget {
  final authService = AuthService();

  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final profileBloc = context.read<ProfileBloc>();
    profileBloc.add(ProfileLoadCommentsEvent(authService.currentUser!.uid));

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Profile"),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is ProfileDone) {
            final userComments = state.comments;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 16,
                  children: [
                    Row(
                      spacing: 12,
                      children: [
                        CircleAvatar(
                          radius: 36,
                          child: Text(authService.currentUser!.displayName!
                              .split("")[0]),
                        ),
                        Column(
                          spacing: 4,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              authService.currentUser!.displayName!,
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w500),
                            ),
                            Text(
                                "Joined in ${authService.currentUser!.metadata.creationTime!.year}")
                          ],
                        )
                      ],
                    ),
                    Text("Your reviews",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w700)),
                    if (userComments.isEmpty)
                      Center(
                        child: Text("You have no comments/reviews"),
                      ),
                    for (var comments in userComments)
                      SizedBox(
                        child: Column(
                          spacing: 12,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(spacing: 12, children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  "https://images.igdb.com/igdb/image/upload/t_1080p/p3svrq6ewzxnn7p1a3v9.jpg",
                                  height: 56,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Column(
                                children: [
                                  Text(comments.gameName!, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, overflow: TextOverflow.ellipsis),),
                                ],
                              ),
                            ]),
                            Text(comments.content!, style: TextStyle(fontSize: 16, overflow: TextOverflow.clip), maxLines: 3),
                            const Divider()
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
