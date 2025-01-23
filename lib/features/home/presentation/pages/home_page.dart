import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zema/features/home/presentation/bloc/home_bloc.dart';
import 'package:zema/features/home/presentation/bloc/home_event.dart';
import 'package:zema/features/home/presentation/bloc/home_state.dart';
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final homeBloc = context.read<HomeBloc>();
    homeBloc.add(LoadGamesEvent());

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            spacing: 28,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Image.asset(
                  "assets/images/zema-logo.png",
                  fit: BoxFit.contain,
                  height: 56,
                ),
              ),
              const Divider(),
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoading) {
                    return const CircularProgressIndicator();
                  }
                
                  if (state is HomeFailed) {
                    return const Center(child: Text("Erro ao buscar jogos"));
                  }
                
                  if (state is HomeDone) {
                    return SizedBox(
                      height: 600, 
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.games.length,
                        itemBuilder: (context, index) {
                          final game = state.games[index];
                          return Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: SizedBox(
                              width: 220,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                    child: Image.network(
                                      "https://images.igdb.com/igdb/image/upload/t_1080p/${game.imageId}.jpg", height: 300, fit: BoxFit.cover,
                                      
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      game.name!,
                                      style: const TextStyle(fontSize: 20),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      game.storyline!,
                                      style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
                                      maxLines: 5,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.start
                                      
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      ),
                    );
                  }
                
                  return const Center(child: Text("Algo deu errado"));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}