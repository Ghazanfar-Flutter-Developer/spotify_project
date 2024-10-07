import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_project/domain/usecases/auth/get_user_usecase.dart';
import 'package:spotify_project/presentation/profile/bloc/profile_info_state.dart';
import 'package:spotify_project/service_locator.dart';

class ProfileInfoCubit extends Cubit<ProfileInfoState> {
  ProfileInfoCubit() : super(ProfileInfoLoading());

  Future<void> getName() async {
    var user = await sl<GetUserUsecase>().call();

    user.fold(
      (l) {
        emit(
          ProfileInfoLoadFailure(l),
        );
      },
      (userEntity) {
        emit(
          ProfileName(userEntity: userEntity),
        );
      },
    );
  }

  Future<void> getUser() async {
    var user = await sl<GetUserUsecase>().call();

    user.fold(
      (failure) {
        emit(
          ProfileInfoLoadFailure(failure),
        );
      },
      (userEntity) {
        emit(
          ProfileInfoLoaded(userEntity: userEntity),
        );
      },
    );
  }
}
