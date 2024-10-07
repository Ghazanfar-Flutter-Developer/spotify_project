import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify_project/data/models/songs/songs_model.dart';
import 'package:spotify_project/domain/entities/songs/songs_entity.dart';
import 'package:spotify_project/domain/usecases/songs/is_favourite_song.dart';
import 'package:spotify_project/service_locator.dart';

abstract class SongsFirebaseServices {
  Future<Either> getNewsSongs();
  Future<Either> getPlayList();
  Future<Either> addOrRemoveFavouriteSong(String songId);
  Future<bool> isFavouriteSong(String songId);
  Future<Either> getUserFavouriteSongs();
}

class SongFirebaseServiceImpl extends SongsFirebaseServices {
  @override
  Future<Either> getNewsSongs() async {
    try {
      List<SongsEntity> songs = [];
      var data = await FirebaseFirestore.instance
          .collection('Songs')
          .orderBy('releaseDate', descending: true)
          .limit(3)
          .get();

      for (var element in data.docs) {
        var songsModel = SongsModel.fromJson(element.data());
        bool isFavourite = await sl<IsFavouriteSongUseCase>().call(
          params: element.reference.id,
        );
        songsModel.isFavourite = isFavourite;
        songsModel.songId = element.reference.id;
        songs.add(
          songsModel.toEntity(),
        );
      }
      return right(songs);
    } catch (e) {
      return left('An Error occurred, Please try Again.');
    }
  }

  @override
  Future<Either> getPlayList() async {
    try {
      List<SongsEntity> songs = [];
      var data = await FirebaseFirestore.instance
          .collection('Songs')
          .orderBy('releaseDate', descending: true)
          .get();

      for (var element in data.docs) {
        var songsModel = SongsModel.fromJson(element.data());
        bool isFavourite = await sl<IsFavouriteSongUseCase>().call(
          params: element.reference.id,
        );
        songsModel.isFavourite = isFavourite;
        songsModel.songId = element.reference.id;
        songs.add(
          songsModel.toEntity(),
        );
      }
      return right(songs);
    } catch (e) {
      return left('An Error occurred, Please try Again.');
    }
  }

  @override
  Future<Either> addOrRemoveFavouriteSong(String songId) async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      late bool isFavourite;

      var user = firebaseAuth.currentUser;
      String uId = user!.uid;

      QuerySnapshot favouriteSongs = await firebaseFirestore
          .collection('Users')
          .doc(uId)
          .collection('Favourites')
          .where('songId', isEqualTo: songId)
          .get();

      if (favouriteSongs.docs.isNotEmpty) {
        await favouriteSongs.docs.first.reference.delete();
        isFavourite = false;
      } else {
        await firebaseFirestore
            .collection('Users')
            .doc(uId)
            .collection('Favourites')
            .add({
          'songId': songId,
          'addedDate': Timestamp.now(),
        });
        isFavourite = true;
      }
      return right(isFavourite);
    } catch (e) {
      return left('An error has been Occurred');
    }
  }

  @override
  Future<bool> isFavouriteSong(String songId) async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      var user = firebaseAuth.currentUser;
      String uId = user!.uid;

      QuerySnapshot favouriteSongs = await firebaseFirestore
          .collection('Users')
          .doc(uId)
          .collection('Favourites')
          .where('songId', isEqualTo: songId)
          .get();

      if (favouriteSongs.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Either> getUserFavouriteSongs() async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      var user = firebaseAuth.currentUser;
      List<SongsEntity> favouriteSongs = [];
      String uId = user!.uid;
      QuerySnapshot favouriteSnapshot = await firebaseFirestore
          .collection('Users')
          .doc(uId)
          .collection('Favourites')
          .get();

      for (var element in favouriteSnapshot.docs) {
        String songId = element['songId'];
        var song =
            await firebaseFirestore.collection('Songs').doc(songId).get();
        SongsModel songsModel = SongsModel.fromJson(song.data()!);
        songsModel.isFavourite = true;
        songsModel.songId = songId;
        favouriteSongs.add(
          songsModel.toEntity(),
        );
      }
      return right(favouriteSongs);
    } catch (e) {
      return left('An Error has been Occured');
    }
  }
}
