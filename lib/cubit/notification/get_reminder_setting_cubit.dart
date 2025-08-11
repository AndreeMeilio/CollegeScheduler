
import 'package:college_scheduler/config/response_general.dart';
import 'package:college_scheduler/config/state_general.dart';
import 'package:college_scheduler/data/local_data/reminder_local_data.dart';
import 'package:college_scheduler/data/models/reminder_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef GetReminderSettingStateType = StateGeneral<GetReminderSettingState, ReminderModel>;

class GetReminderSettingState {}
class GetReminderSettingInitialState extends GetReminderSettingState{}
class GetReminderSettingLoadedState extends GetReminderSettingState{}
class GetReminderSettingLoadingState extends GetReminderSettingState{}
class GetReminderSettingFailedState extends GetReminderSettingState{}

class GetReminderSettigCubit extends Cubit<GetReminderSettingStateType>{
  final ReminderLocalData _reminderLocalData;

  GetReminderSettigCubit({
    required ReminderLocalData reminderLocalData
  }) : _reminderLocalData = reminderLocalData,
    super(GetReminderSettingStateType(state: GetReminderSettingInitialState()));


  GetReminderSettingStateType listReminderSettingState = GetReminderSettingStateType(state: GetReminderSettingInitialState());
  Future<void> getDataReminderSetting() async{
    try {
      listReminderSettingState = GetReminderSettingStateType(state: GetReminderSettingLoadingState());
      emit(listReminderSettingState);

      final dataResult = await _reminderLocalData.getReminderData();

      if (dataResult.code == "00"){
        listReminderSettingState = GetReminderSettingStateType(
          state: GetReminderSettingLoadedState(),
          code: dataResult.code,
          message: dataResult.message,
          data: dataResult.data
        );
      } else {
        listReminderSettingState = GetReminderSettingStateType(
          state: GetReminderSettingFailedState(),
          code: dataResult.code,
          message: dataResult.message,
          data: null
        );
      }

      emit(listReminderSettingState);

    } catch (e){
      listReminderSettingState = GetReminderSettingStateType(
        state: GetReminderSettingFailedState(),
        code: "01",
        message: "There's a problem when setting reminder event",
        data: null
      );

      emit(listReminderSettingState);
    }
  }
}