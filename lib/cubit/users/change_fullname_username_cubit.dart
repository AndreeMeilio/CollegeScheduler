
import 'package:college_scheduler/config/state_general.dart';
import 'package:college_scheduler/data/local_data/users_local_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef ChangeFullnameUsernameStateType = StateGeneral<ChangeFullnameUsernameState, int>;

class ChangeFullnameUsernameState {}
class ChangeFullnameUsernameInitialState extends ChangeFullnameUsernameState {}
class ChangeFullnameUsernameLoadingState extends ChangeFullnameUsernameState {}
class ChangeFullnameUsernameSuccessState extends ChangeFullnameUsernameState {}
class ChangeFullnameUsernameFailedState extends ChangeFullnameUsernameState {}

class ChangeFullnameUsernameCubit extends Cubit<ChangeFullnameUsernameStateType>{
  final UsersLocalData _usersLocalData;

  ChangeFullnameUsernameCubit({
    required UsersLocalData usersLocalData
  }) : _usersLocalData = usersLocalData,
       super(ChangeFullnameUsernameStateType(state: ChangeFullnameUsernameInitialState()));

  ChangeFullnameUsernameStateType changeState = ChangeFullnameUsernameStateType(state: ChangeFullnameUsernameInitialState());
  Future<void> changeFullnameUsername({
    required String fullname,
    required String username,
    required String password
  }) async {
    try {
      changeState = ChangeFullnameUsernameStateType(state: ChangeFullnameUsernameLoadingState());
      emit(changeState);

      final result = await _usersLocalData.changeFullnameOrUsername(
        fullname: fullname, 
        username: username, 
        password: password
      );

      if (result.code == "00"){
        changeState = ChangeFullnameUsernameStateType(
          state: ChangeFullnameUsernameSuccessState(),
          code: result.code,
          message: result.message,
          data: result.data
        );
      } else {
        changeState = ChangeFullnameUsernameStateType(
          state: ChangeFullnameUsernameFailedState(),
          code: result.code,
          message: result.message,
          data: result.data
        );
      }

      emit(changeState);
    } catch (e){
      changeState = ChangeFullnameUsernameStateType(
        state: ChangeFullnameUsernameFailedState(),
        code: "01",
        message: "There's a problem when trying to change your fullname or username",
        data: -1
      );
      emit(changeState);
    }
  }
}