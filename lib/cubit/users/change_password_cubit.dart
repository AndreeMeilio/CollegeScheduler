import 'package:college_scheduler/config/response_general.dart';
import 'package:college_scheduler/config/state_general.dart';
import 'package:college_scheduler/data/local_data/users_local_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef ChangePasswordStateType = StateGeneral<ChangePasswordState, int>;

class ChangePasswordState {}
class ChangePasswordInitialState extends ChangePasswordState{}
class ChangePasswordLoadingState extends ChangePasswordState{}
class ChangePasswordSuccessState extends ChangePasswordState{}
class ChangePasswordFailedState extends ChangePasswordState{}

class ChangePasswordCubit extends Cubit<ChangePasswordStateType>{

  final UsersLocalData _usersLocalData;

  ChangePasswordCubit({
    required UsersLocalData usersLocalData
  }) : _usersLocalData = usersLocalData,
       super(ChangePasswordStateType(state: ChangePasswordInitialState()));


  ChangePasswordStateType state = ChangePasswordStateType(state: ChangePasswordInitialState());
  Future<void> changePassword({
    required String oldPassword,
    required String newPassword
  }) async {
    try {
      state = ChangePasswordStateType(
        state: ChangePasswordLoadingState(),
      );

      emit(state);

      final result = await _usersLocalData.changePassword(
        newPassword: newPassword,
        oldPassword: oldPassword
      );

      if (result.code == "00"){
        state = ChangePasswordStateType(
          state: ChangePasswordSuccessState(),
          code: result.code,
          message: result.message,
          data: result.data,
        );
      } else {
        state = ChangePasswordStateType(
          state: ChangePasswordFailedState(),
          code: result.code,
          message: result.message,
          data: result.data,
        );
      }

      emit(state);
    } catch (e){
      state = ChangePasswordStateType(
        state: ChangePasswordFailedState(),
        code: "01",
        message: "There's a problem when changing your account password!",
        data: -1,
      );

      emit(state);
    }
  }

}