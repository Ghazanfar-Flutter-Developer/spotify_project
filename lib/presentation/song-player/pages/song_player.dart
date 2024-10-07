import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_project/common/widgets/appbar/base_app_bar.dart';
import 'package:spotify_project/common/widgets/favourite-button/favourite_button.dart';
import 'package:spotify_project/core/configs/theme/app_colors.dart';
import 'package:spotify_project/core/constant/app_url.dart';
import 'package:spotify_project/domain/entities/songs/songs_entity.dart';
import 'package:spotify_project/presentation/song-player/bloc/song_player_cubit.dart';
import 'package:spotify_project/presentation/song-player/bloc/song_player_state.dart';

class SongPlayer extends StatelessWidget {
  final SongsEntity songsEntity;
  const SongPlayer({
    super.key,
    required this.songsEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: const Text(
          'Now Playing',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        action: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.more_vert_rounded,
          ),
        ),
      ),
      body: BlocProvider(
        create: (_) => SongPlayerCubit()
          ..loadSong(
              '${AppUrl.songFireStore}${songsEntity.title}.mp3${AppUrl.mediaAlt}'),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Column(
              children: [
                _songCover(context),
                const SizedBox(height: 10),
                _songDetail(),
                const SizedBox(height: 10),
                _songSlider(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _songCover(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            '${AppUrl.fireStore}${songsEntity.title}.jpg${AppUrl.mediaAlt}',
          ),
        ),
        borderRadius: BorderRadius.circular(30),
      ),
    );
  }

  Widget _songDetail() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              songsEntity.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              songsEntity.artist,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.darkGrey,
              ),
            ),
          ],
        ),
        FavouriteButton(songsEntity: songsEntity)
      ],
    );
  }

  Widget _songSlider(BuildContext context) {
    return BlocBuilder<SongPlayerCubit, SongPlayerState>(
      builder: (context, state) {
        if (state is SongPlayerLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is SongPlayerLoaded) {
          return Column(
            children: [
              Slider(
                activeColor: Colors.white,
                inactiveColor: AppColors.darkGrey,
                value: context
                    .read<SongPlayerCubit>()
                    .songPosition
                    .inSeconds
                    .toDouble(),
                min: 0.0,
                max: context
                    .read<SongPlayerCubit>()
                    .songDuration
                    .inSeconds
                    .toDouble(),
                onChanged: (value) {
                  context
                      .read<SongPlayerCubit>()
                      .updateSongPosition(Duration(seconds: value.toInt()));
                },
                onChangeEnd: (value) {
                  context
                      .read<SongPlayerCubit>()
                      .seekSong(Duration(seconds: value.toInt()));
                },
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formatedDuration(
                        context.read<SongPlayerCubit>().songPosition),
                  ),
                  Text(
                    formatedDuration(
                        context.read<SongPlayerCubit>().songDuration),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  context.read<SongPlayerCubit>().playorPauseSong();
                },
                child: Container(
                  height: 55,
                  width: 55,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    context.read<SongPlayerCubit>().audioPlayer.playing
                        ? Icons.pause
                        : Icons.play_arrow_rounded,
                  ),
                ),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }

  String formatedDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
