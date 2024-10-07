import 'package:spotify_project/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:spotify_project/data/repository/songs/songs_repository_impl.dart';
import 'package:spotify_project/service_locator.dart';

class GetNewsSongsUsecase implements Usecase<Either, dynamic> {
  @override
  Future<Either> call({params}) async {
    return await sl<SongsRepositoryImpl>().getNewsSongs();
  }
}
