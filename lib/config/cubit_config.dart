
import 'package:college_scheduler/config/di_config.dart';
import 'package:college_scheduler/cubit/event/priority_events_cubit.dart';
import 'package:college_scheduler/cubit/event/status_events_cubit.dart';
import 'package:college_scheduler/cubit/language_locale_cubit.dart';
import 'package:college_scheduler/cubit/menu/settings_menu_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:college_scheduler/cubit/menu/base_menu_cubit.dart';
import 'package:college_scheduler/cubit/class/create_and_update_data_class_cubit.dart';
import 'package:college_scheduler/cubit/class/list_data_class_cubit.dart';
import 'package:college_scheduler/cubit/event/create_event_cubit.dart';
import 'package:college_scheduler/cubit/event/list_event_cubit.dart';
import 'package:college_scheduler/cubit/lecturer/create_lecturer_cubit.dart';
import 'package:college_scheduler/cubit/lecturer/list_lecturer_cubit.dart';
import 'package:college_scheduler/cubit/logs/event_logs_cubit.dart';
import 'package:college_scheduler/cubit/logs/login_logs_cubit.dart';
import 'package:college_scheduler/cubit/users/change_fullname_username_cubit.dart';
import 'package:college_scheduler/cubit/users/change_password_cubit.dart';
import 'package:college_scheduler/cubit/users/login_cubit.dart';
import 'package:college_scheduler/cubit/users/register_cubit.dart';

class CubitConfig {
  static getProviders(){
    return [
      BlocProvider<LoginCubit>(
        create: (context) => LoginCubit(usersLocalData: sl()),
      ),
      BlocProvider<RegisterCubit>(
        create: (context) => RegisterCubit(usersLocalData: sl()),
      ),
      BlocProvider<CreateAndUpdateEventCubit>(
        create: (context) => CreateAndUpdateEventCubit(eventLocalData: sl()),
      ),
      BlocProvider<ListEventCubit>(
        create: (context) => ListEventCubit(eventLocalData: sl()),
      ),
      BlocProvider<CreateAndUpdateDataClassCubit>(
        create: (context) => CreateAndUpdateDataClassCubit(classLocalData: sl()),
      ),
      BlocProvider<ListDataClassCubit>(
        create: (context) => ListDataClassCubit(classLocalData: sl()),
      ),
      BlocProvider<BaseMenuCubit>(
        create: (context) => BaseMenuCubit(),
      ),
      BlocProvider<ChangePasswordCubit>(
        create: (context) => ChangePasswordCubit(usersLocalData: sl())
      ),
      BlocProvider<LoginLogsCubit>(
        create: (context) => LoginLogsCubit(logsLocalData: sl()),
      ),
      BlocProvider<ChangeFullnameUsernameCubit>(
        create: (context) => ChangeFullnameUsernameCubit(usersLocalData: sl()),
      ),
      BlocProvider<CreateLecturerCubit>(
        create: (context) => CreateLecturerCubit(lecturerLocalData: sl()),
      ),
      BlocProvider<ListLecturerCubit>(
        create: (context) => ListLecturerCubit(lecturerLocalData: sl()),
      ),
      BlocProvider<EventsLogsCubit>(
        create: (context) => EventsLogsCubit(logsLocalData: sl()),
      ),
      BlocProvider<StatusEventsCubit>(
        create: (context) => StatusEventsCubit(eventLocalData: sl())
      ),
      BlocProvider<SettingsMenuCubit>(
        create: (context) => SettingsMenuCubit(menuLocalData: sl()),
      ),
      BlocProvider<PriorityEventsCubit>(
        create: (context) => PriorityEventsCubit(eventLocalData: sl())
      ),
      BlocProvider<LanguageLocaleCubit>(
        create: (context) => LanguageLocaleCubit(),
      )
    ];
  }
}