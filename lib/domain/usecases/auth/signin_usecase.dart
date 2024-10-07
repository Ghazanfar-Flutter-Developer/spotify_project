import 'package:spotify_project/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:spotify_project/data/models/auth/signin_user_req.dart';
import 'package:spotify_project/domain/repository/auth/auth_repository.dart';
import 'package:spotify_project/service_locator.dart';

class SigninUsecase implements Usecase<Either, SignUserReq> {
  @override
  Future<Either> call({SignUserReq? params}) async {
    return sl<AuthRepository>().signin(params!);
  }
}
