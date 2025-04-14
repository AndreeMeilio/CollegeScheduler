

import 'package:college_scheduler/config/database.dart';
import 'package:college_scheduler/data/local_data/class_local_data.dart';
import 'package:college_scheduler/data/local_data/event_local_data.dart';
import 'package:college_scheduler/data/local_data/lecturer_local_data.dart';
import 'package:college_scheduler/data/local_data/logs_local_data.dart';
import 'package:college_scheduler/data/local_data/menu_local_data.dart';
import 'package:college_scheduler/data/local_data/users_local_data.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.I;

void setupServiceLocator(){
  sl.registerLazySingleton<DatabaseConfig>(() => DatabaseConfig());
  sl.registerLazySingleton<UsersLocalData>(() => UsersLocalData(database: sl(), logsLocalData: sl()));
  sl.registerLazySingleton<EventLocalData>(() => EventLocalData(database: sl(), logsLocalData: sl()));
  sl.registerLazySingleton<ClassLocalData>(() => ClassLocalData(database: sl()));
  sl.registerLazySingleton<LogsLocalData>(() => LogsLocalData(database: sl()));
  sl.registerLazySingleton<LecturerLocalData>(() => LecturerLocalData(database: sl()));
  sl.registerLazySingleton<MenuLocalData>(() => MenuLocalData(database: sl()));
}