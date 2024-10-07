import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_project/common/bloc/favourite_button/favourite_button_cubit.dart';
import 'package:spotify_project/common/bloc/favourite_button/favourite_button_state.dart';
import 'package:spotify_project/core/configs/theme/app_colors.dart';
import 'package:spotify_project/domain/entities/songs/songs_entity.dart';

class FavouriteButton extends StatelessWidget {
  final SongsEntity songsEntity;
  const FavouriteButton({
    super.key,
    required this.songsEntity,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FavouriteButtonCubit(),
      child: BlocBuilder<FavouriteButtonCubit, FavouriteButtonState>(
        builder: (context, state) {
          if (state is FavouriteButtonInitial) {
            return IconButton(
              onPressed: () {
                context.read<FavouriteButtonCubit>().favouriteButtonUpdate(
                      songsEntity.songId,
                    );
              },
              icon: Icon(
                songsEntity.isFavourite
                    ? Icons.favorite
                    : Icons.favorite_outline_rounded,
                color: AppColors.darkGrey,
              ),
            );
          }

          if (state is FavouriteButtonUpdate) {
            return IconButton(
              onPressed: () {
                context.read<FavouriteButtonCubit>().favouriteButtonUpdate(
                      songsEntity.songId,
                    );
              },
              icon: Icon(
                state.isFavourite
                    ? Icons.favorite
                    : Icons.favorite_outline_rounded,
                color: AppColors.darkGrey,
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
