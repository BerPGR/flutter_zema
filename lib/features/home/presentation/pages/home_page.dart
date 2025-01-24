import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:zema/features/home/presentation/bloc/home_bloc.dart';
import 'package:zema/features/home/presentation/bloc/home_event.dart';
import 'package:zema/features/home/presentation/bloc/home_state.dart';
import 'package:zema/features/home/presentation/widgets/home_games_list.dart';

class HomePage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final homeBloc = context.read<HomeBloc>();
    if (homeBloc.state is! HomeDone) {
      homeBloc.add(LoadGamesEvent());
    }

    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return Center(child: const CircularProgressIndicator());
          }

          if (state is HomeFailed) {
            return const Center(child: Text("Erro ao buscar jogos"));
          }

          if (state is HomeDone) {
            return SafeArea(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                "assets/images/zema-logo.png",
                                fit: BoxFit.contain,
                                height: 56,
                              ),
                              IconButton(
                                  onPressed: () {
                                    homeBloc.add(SearchGameEvent());
                                  },
                                  icon: Icon(
                                    Icons.search,
                                    size: 32,
                                  ))
                            ],
                          )),
                      const Divider(),
                      const SizedBox(
                        height: 28,
                      ),
                      SizedBox(
                        height: 450,
                        child: HomeGamesList(games: state.games),
                      ),
                      const SizedBox(
                        height: 28,
                      ),
                      const Text(
                        "Top Review",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      for (var top in state.topReviews)
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: ListTile(
                            onTap: () {
                              context.go("/details", extra: top);
                            },
                            splashColor: Colors.white30,
                            leading: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                    "https://images.igdb.com/igdb/image/upload/t_thumb/${top.imageId}.jpg")),
                            title: Text(
                              top.name!,
                              maxLines: 2,
                            ),
                            trailing: Icon(Icons.chevron_right_outlined),
                          ),
                        ),
                      const SizedBox(height: 28)
                    ],
                  ),
                ),
              ),
            );
          }

          if (state is HomeSearch) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Column(
                    spacing: 28,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {
                                homeBloc.add(LoadGamesEvent());
                              },
                              icon: Icon(
                                Icons.chevron_left_outlined,
                                size: 32,
                              ))
                        ],
                      ),
                      const Divider(),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Search',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                width: 1,
                              )),
                        ),
                        controller: _controller,
                        focusNode: _focusNode,
                        onSubmitted: (value) {
                          if (value.trim().isNotEmpty) {
                            homeBloc
                                .add(SearchingGameEvent(query: value.trim()));
                          }
                        },
                      ),
                      if (state.searchedGames.isNotEmpty)
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: state.searchedGames.length,
                            itemBuilder: (context, index) {
                              final searchedGame = state.searchedGames[index];
                              return Padding(
                                padding: const EdgeInsets.only(top: 16.0),
                                child: ListTile(
                                  splashColor: Colors.white30,
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                        "https://images.igdb.com/igdb/image/upload/t_thumb/${searchedGame.imageId}.jpg"),
                                  ),
                                  title: Text(
                                    searchedGame.name!,
                                    maxLines: 2,
                                  ),
                                  trailing: Icon(Icons.chevron_right_outlined),
                                ),
                              );
                            },
                          ),
                        ),
                    ],
                  ),
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
