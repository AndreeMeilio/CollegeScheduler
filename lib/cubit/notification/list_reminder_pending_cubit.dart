
import 'package:college_scheduler/config/constants_value.dart';
import 'package:college_scheduler/config/notification_config.dart';
import 'package:college_scheduler/config/shared_preference.dart';
import 'package:college_scheduler/config/state_general.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


typedef ListReminderPendingStateType = StateGeneral<ListReminderPendingState, List<PendingNotificationRequest>>;

class ListReminderPendingState {}
class ListReminderPendingInitialState extends ListReminderPendingState {}
class ListReminderPendingLoadedState extends ListReminderPendingState {}
class ListReminderPendingLoadingState extends ListReminderPendingState {}
class ListReminderPendingFailedState extends ListReminderPendingState {}

class ListReminderPendingCubit extends Cubit<ListReminderPendingStateType> {

  ListReminderPendingCubit(): super(ListReminderPendingStateType(state: ListReminderPendingInitialState()));


  ListReminderPendingStateType listState = ListReminderPendingStateType(state: ListReminderPendingInitialState());
  Future<void> getReminderPending() async{
    try {
      listState = ListReminderPendingStateType(state: ListReminderPendingLoadingState());
      emit(listState);

      final notification = NotificationConfig.getFlutterLocalNotif();

      final List<PendingNotificationRequest> allDataPending = await notification.pendingNotificationRequests();

      final userId = await SharedPreferenceConfig().getInt(key: ConstansValue.user_id);
      List<PendingNotificationRequest> filteredUserIdPending = List.empty(growable: true);

      for (var dataPending in allDataPending){
        if (dataPending.payload != "userid$userId!"){
          continue;
        }

        filteredUserIdPending.add(dataPending);
      }

      listState = ListReminderPendingStateType(
        state: ListReminderPendingLoadedState(),
        code: "00",
        data: filteredUserIdPending,
        message: "Getting reminder pending successfully"
      );

      emit(listState);
    } catch (e){
      print(e);
      listState = ListReminderPendingStateType(
        state: ListReminderPendingFailedState(),
        code: "01",
        data: [],
        message: "There's a problem when getting reminder pending"
      );
      emit(listState);

    }
  }
}