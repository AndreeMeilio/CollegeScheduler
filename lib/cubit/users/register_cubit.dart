import 'package:college_scheduler/config/state_general.dart';
import 'package:college_scheduler/data/local_data/users_local_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef StateRegisterType = StateGeneral<RegisterState, int>;

class RegisterState {}
class RegisterInitialState extends RegisterState{}
class RegisterSuccessState extends RegisterState{}
class RegisterFailedState extends RegisterState{}
class RegisterLoadingState extends RegisterState{}

class RegisterCubit extends Cubit<StateRegisterType> {
  final UsersLocalData _usersLocalData;

  RegisterCubit({
    required UsersLocalData usersLocalData
  }) : _usersLocalData = usersLocalData,
       super(StateGeneral(state: RegisterInitialState()));

  
  StateRegisterType registerState = StateGeneral(
    state: RegisterInitialState()
  );

  Future<void> registerAccount({
    required String fullname,
    required String username,
    required String password
  }) async{
    try {
      registerState = StateRegisterType(state: RegisterLoadingState());
      emit(registerState);

      final result = await _usersLocalData.registerAccount(fullname: fullname, username: username, password: password);

      if (result.data >= 1){
        registerState = StateRegisterType(
          state: RegisterSuccessState(),
          code: result.code,
          message: result.message,
          data: result.data
        );
      } else {
        registerState = StateRegisterType(
          state: RegisterFailedState(),
          code: result.code,
          message: result.message,
          data: result.data
        );
      }
      emit(registerState);
    } catch (e){
      registerState = StateRegisterType(
        state: RegisterFailedState(),
        code: "",
        message: "There's a problem creating your account i am sorry );",
        data: -1
      );
      emit(registerState);
    }
  }
}