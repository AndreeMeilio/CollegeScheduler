

import 'package:college_scheduler/config/notification_config.dart';
import 'package:college_scheduler/config/response_general.dart';
import 'package:college_scheduler/config/state_general.dart';
import 'package:college_scheduler/data/local_data/reminder_local_data.dart';
import 'package:college_scheduler/data/models/reminder_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef CreateReminderSettingStateType = StateGeneral<CreateReminderSettingState, int>;

class CreateReminderSettingState {}
class CreateReminderSettingInitialState extends CreateReminderSettingState {}
class CreateReminderSettingLoadingState extends CreateReminderSettingState {}
class CreateReminderSettingSuccessState extends CreateReminderSettingState {}
class CreateReminderSettingFailedState extends CreateReminderSettingState {}

class CreateReminderSettingCubit extends Cubit<CreateReminderSettingStateType>{

  final ReminderLocalData _reminderLocalData;

  CreateReminderSettingCubit({
    required ReminderLocalData reminderLocalData
  }) : _reminderLocalData = reminderLocalData,
    super(CreateReminderSettingStateType(state: CreateReminderSettingInitialState()));

  
  CreateReminderSettingStateType createState = CreateReminderSettingStateType(state: CreateReminderSettingInitialState());
  Future<void> createReminderSetting({
    required bool isNotificationOn,
    required int numberNoticeBefore,
    required String notificationType,
    required String hoursType
  }) async {
    try {
      createState = CreateReminderSettingStateType(
        state: CreateReminderSettingLoadingState(),
      );
      emit(createState);

      final requestModel = ReminderModel(
        isNotificationOn: isNotificationOn,
        numberBeforeType: numberNoticeBefore,
        typeNotification: notificationType,
        typeHour: hoursType
      );

      final result = await _reminderLocalData.createReminderData(dataRequest: requestModel);

      if (result.code == "00"){
        createState = CreateReminderSettingStateType(
          state: CreateReminderSettingSuccessState(),
          code: result.code,
          message: result.message,
          data: result.data
        );

        if (isNotificationOn){
          NotificationConfig.initialize();
        }
      } else {
        createState = CreateReminderSettingStateType(
          state: CreateReminderSettingFailedState(),
          code: result.code,
          message: result.message,
          data: result.data
        );
      }

      emit(createState);
    } catch (e){
      createState = CreateReminderSettingStateType(
        state: CreateReminderSettingFailedState(),
        code: "01",
        message: "There's a problem when setting reminder event",
        data: -1
      );

      emit(createState);
    }
  }

}