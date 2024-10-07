import 'package:dartz/dartz.dart';
import 'package:spotify_project/data/models/auth/create_user_req.dart';
import 'package:spotify_project/data/models/auth/signin_user_req.dart';

abstract class AuthRepository {
  Future<Either> signin(SignUserReq signinuserReq);
  Future<Either> signup(CreateUserReq createuserReq);
  Future<Either> getUser();
}
