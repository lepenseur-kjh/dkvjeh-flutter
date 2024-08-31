import 'package:dkejvh/common/bloc/button_state.dart';
import 'package:dkejvh/core/usecase/usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';

class ButtonStateCubit extends Cubit<ButtonState> {
  ButtonStateCubit() : super(ButtonInitialState());

  // TODO: required UseCase 코드 작성하기
  Future<void> execute({dynamic params, UseCase? usecase}) async {
    emit(ButtonLoadingState());
    try {
      Either resp = await usecase?.call(params: params);
      resp.fold((error) {
        emit(ButtonFailureState(errorMsg: error));
      }, (data) {
        emit(ButtonSuccessState());
      });
    } catch (e) {
      emit(ButtonFailureState(errorMsg: e.toString()));
    }
  }
}
