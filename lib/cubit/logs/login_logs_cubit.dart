
import 'package:college_scheduler/config/state_general.dart';
import 'package:college_scheduler/data/local_data/logs_local_data.dart';
import 'package:college_scheduler/data/models/logs_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef LoginLogsStateType = StateGeneral<LoginLogsState, List<LogsModel?>?>;

class LoginLogsState{}
class LoginLogsInitialState extends LoginLogsState {}
class LoginLogsLoadingState extends LoginLogsState {}
class LoginLogsLoadedState extends LoginLogsState {}
class LoginLogsFailedState extends LoginLogsState {}

class LoginLogsCubit extends Cubit<LoginLogsStateType>{
  final LogsLocalData _logsLocalData;

  LoginLogsCubit({
    required LogsLocalData logsLocalData
  }) : _logsLocalData = logsLocalData,
       super(LoginLogsStateType(state: LoginLogsInitialState()));

  LoginLogsStateType logsState = LoginLogsStateType(state: LoginLogsInitialState());
  Future<void> getAllLoginLogs() async{
    try {
      logsState = LoginLogsStateType(state: LoginLogsLoadingState());
      emit(logsState);

      final result = await _logsLocalData.getLogs(actionName: "login");

      if (result.code == "00"){
        logsState = LoginLogsStateType(
          state: LoginLogsLoadedState(),
          code: result.code,
          message: result.message,
          data: result.data
        );
      } else {
        logsState = LoginLogsStateType(
          state: LoginLogsFailedState(),
          code: result.code,
          message: result.message,
          data: result.data
        );
      }

      emit(logsState);
    } catch (e){
      logsState = LoginLogsStateType(
        state: LoginLogsFailedState(),
        code: "01",
        message: "There's a problem when getting login history",
        data: []
      );
      emit(logsState);
    }
  }
}