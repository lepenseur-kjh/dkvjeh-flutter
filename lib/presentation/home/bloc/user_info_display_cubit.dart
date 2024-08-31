import 'package:dkejvh/domain/auth/usecases/get_user.dart';
import 'package:dkejvh/presentation/home/bloc/user_info_display_state.dart';
import 'package:dkejvh/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserInfoDisplayCubit extends Cubit<UserInfoDisplayState> {
  UserInfoDisplayCubit() : super(UserInfoLoading());

  void displayUserInfo() async {
    var resp = await sl<GetUserUsecase>().call();
    resp.fold((error) {
      emit(LoadUserInfoFailure());
    }, (data) {
      emit(UserInfoLoaded(user: data));
    });
  }
}
