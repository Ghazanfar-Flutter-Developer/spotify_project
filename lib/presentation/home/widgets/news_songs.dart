import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_project/core/configs/theme/app_colors.dart';
import 'package:spotify_project/core/constant/app_url.dart';
import 'package:spotify_project/domain/entities/songs/songs_entity.dart';
import 'package:spotify_project/presentation/home/bloc/news_songs_cubit.dart';
import 'package:spotify_project/presentation/home/bloc/news_songs_cubit_state.dart';
import 'package:spotify_project/presentation/song-player/pages/song_player.dart';

class NewsSongs extends StatelessWidget {
  const NewsSongs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NewsSongsCubit()..getNewsSongs(),
      child: SizedBox(
        height: 200,
        child: BlocBuilder<NewsSongsCubit, NewsSongsState>(
            builder: (context, state) {
          if (state is NewsSongsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is NewsSongsLoaded) {
            return _songs(state.songs);
          }
          return Container();
        }),
      ),
    );
  }

  Widget _songs(List<SongsEntity> songs) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SongPlayer(
                    songsEntity: songs[index],
                  ),
                ));
          },
          child: SizedBox(
            width: 150,
            child: Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            '${AppUrl.fireStore}${songs[index].title}.jpg${AppUrl.mediaAlt}',
                          ),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          height: 30,
                          width: 30,
                          transform: Matrix4.translationValues(8, 8, 0),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.darkGrey,
                          ),
                          child: const Icon(
                            Icons.play_arrow_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    songs[index].title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    songs[index].artist,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(width: 10),
      itemCount: songs.length,
    );
  }
}
