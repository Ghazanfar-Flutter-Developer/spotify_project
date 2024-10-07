import 'package:dartz/dartz.dart';
import 'package:spotify_project/core/usecase/usecase.dart';
import 'package:spotify_project/domain/repository/auth/auth_repository.dart';
import 'package:spotify_project/service_locator.dart';

class GetUserUsecase implements Usecase<Either, dynamic> {
  @override
  Future<Either> call({params}) async {
    return await sl<AuthRepository>().getUser();
  }
}
