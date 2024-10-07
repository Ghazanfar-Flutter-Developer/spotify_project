import 'package:dartz/dartz.dart';
import 'package:spotify_project/data/models/auth/create_user_req.dart';
import 'package:spotify_project/data/models/auth/signin_user_req.dart';
import 'package:spotify_project/data/sources/auth/auth_firebase_services.dart';
import 'package:spotify_project/domain/repository/auth/auth_repository.dart';
import 'package:spotify_project/service_locator.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either> signin(SignUserReq signinuserReq) async {
    return await sl<AuthFirebaseServices>().signin(signinuserReq);
  }

  @override
  Future<Either> signup(CreateUserReq createuserReq) async {
    return await sl<AuthFirebaseServices>().signup(createuserReq);
  }

  @override
  Future<Either> getUser() async {
    return await sl<AuthFirebaseServices>().getUser();
  }
}
