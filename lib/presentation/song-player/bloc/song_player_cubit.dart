import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spotify_project/presentation/song-player/bloc/song_player_state.dart';

class SongPlayerCubit extends Cubit<SongPlayerState> {
  AudioPlayer audioPlayer = AudioPlayer();
  Duration songDuration = Duration.zero;
  Duration songPosition = Duration.zero;

  SongPlayerCubit() : super(SongPlayerLoading()) {
    audioPlayer.positionStream.listen((position) {
      songPosition = position;
      updateSongPlayer();
    });
    audioPlayer.durationStream.listen((duration) {
      songDuration = duration!;
    });
  }

  // Update the UI state to reflect the current song position and duration
  void updateSongPlayer() {
    emit(
      SongPlayerLoaded(),
    );
  }

  // Load the song from the provided URL
  Future<void> loadSong(String url) async {
    try {
      await audioPlayer.setUrl(url);
      emit(SongPlayerLoaded());
    } catch (e) {
      emit(SongPlayerLoadFailure());
    }
  }

  // Play or pause the song
  void playorPauseSong() {
    if (audioPlayer.playing) {
      audioPlayer.stop();
    } else {
      audioPlayer.play();
    }
    emit(SongPlayerLoaded());
  }

  // Seek the song to the specified position when dragging ends
  void seekSong(Duration newPosition) {
    audioPlayer.seek(newPosition);
    emit(SongPlayerLoaded());
  }

  // Update song position while dragging the slider
  void updateSongPosition(Duration newPosition) {
    songPosition = newPosition;
    emit(SongPlayerLoaded());
  }

  @override
  Future<void> close() {
    audioPlayer.dispose();
    return super.close();
  }
}
