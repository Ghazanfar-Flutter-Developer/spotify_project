import 'package:spotify_project/domain/entities/auth/user_entity.dart';

abstract class ProfileInfoState {}

class ProfileInfoLoading extends ProfileInfoState {}

class ProfileInfoLoaded extends ProfileInfoState {
  final UserEntity userEntity;
  ProfileInfoLoaded({
    required this.userEntity,
  });
}

class ProfileName extends ProfileInfoState {
  final UserEntity userEntity;
  ProfileName({
    required this.userEntity,
  });
}

class ProfileInfoLoadFailure extends ProfileInfoState {
  final String error;

  ProfileInfoLoadFailure(this.error);
}
