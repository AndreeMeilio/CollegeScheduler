
import 'package:college_scheduler/config/constants_route_value.dart';
import 'package:college_scheduler/data/models/class_model.dart';
import 'package:college_scheduler/data/models/event_model.dart';
import 'package:college_scheduler/data/models/lecturer_model.dart';
import 'package:college_scheduler/pages/base_page.dart';
import 'package:college_scheduler/pages/change_fullname_username_page.dart';
import 'package:college_scheduler/pages/change_password_page.dart';
import 'package:college_scheduler/pages/data_class_page.dart';
import 'package:college_scheduler/pages/data_events_page.dart';
import 'package:college_scheduler/pages/data_lecturer_page.dart';
import 'package:college_scheduler/pages/detail_event_page.dart';
import 'package:college_scheduler/pages/event_history_page.dart';
import 'package:college_scheduler/pages/input_data_class_page.dart';
import 'package:college_scheduler/pages/input_data_lecturer_page.dart';
import 'package:college_scheduler/pages/login_history_page.dart';
import 'package:college_scheduler/pages/login_page.dart';
import 'package:college_scheduler/pages/register_page.dart';
import 'package:college_scheduler/utils/custom_animation_page_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class RouteNavigatorConfig {
  static final router = GoRouter(
    initialLocation: ConstantsRouteValue.login,
    routes: [
      GoRoute(
        path: ConstantsRouteValue.login,
        pageBuilder: (context, state){
          return CustomAnimationPageUtils.animate(
            key: state.pageKey,
            child: LoginPage()
          );
        },
        routes: [
          GoRoute(
            path: ConstantsRouteValue.loginHistory,
            pageBuilder: (context, state){
              return CustomAnimationPageUtils.animate(
                key: state.pageKey, 
                child: LoginHistoryPage(),
              );
            }
          )
        ]
      ),
      GoRoute(
        path: ConstantsRouteValue.register,
        pageBuilder: (context, state){
          return CustomAnimationPageUtils.animate(
            key: state.pageKey,
            child: RegisterPage()
          );
        }
      ),
      GoRoute(
        path: ConstantsRouteValue.changePassword,
        pageBuilder: (context, state){
          return CustomAnimationPageUtils.animate(
            key: state.pageKey,
            child: ChangePasswordPage()
          );
        }
      ),
      GoRoute(
        path: ConstantsRouteValue.changeFullnameOrUsername,
        pageBuilder: (context, state){
          return CustomAnimationPageUtils.animate(
            key: state.pageKey,
            child: ChangeFullnameUsernamePage()
          );
        }
      ),
      GoRoute(
        path: ConstantsRouteValue.baseMenu,
        pageBuilder: (context, state){
          return CustomAnimationPageUtils.animate(
            key: state.pageKey,
            child: BasePage()
          );
        }
      ),
      GoRoute(
        path: ConstantsRouteValue.events,
        pageBuilder: (context, state){
          return CustomAnimationPageUtils.animate(
            key: state.pageKey,
            child: DataEventsPage()
          );
        },
        routes: [
          GoRoute(
            path: ConstantsRouteValue.detailEvents,
            pageBuilder: (context, state){
              return CustomAnimationPageUtils.animate(
                key: state.pageKey,
                child: DetailEventPage(data: state.extra as EventModel)
              );
            }
          ),
          GoRoute(
            path: ConstantsRouteValue.historyEvents,
            pageBuilder: (context, state){
              return CustomAnimationPageUtils.animate(
                key: state.pageKey,
                child: EventHistoryPage()
              );
            }
          ),
        ]
      ),
      GoRoute(
        path: ConstantsRouteValue.clasess,
        pageBuilder: (context, state){
          return CustomAnimationPageUtils.animate(
            key: state.pageKey,
            child: DataClassPage()
          );
        },
        routes: [
          GoRoute(
            path: ConstantsRouteValue.actionClasess,
            pageBuilder: (context, state){
              return CustomAnimationPageUtils.animate(
                key: state.pageKey,
                child: InputDataClassPage(
                  dataClassFromEdit: state.extra as ClassModel?,
                )
              );
            }
          ),
        ]
      ),
      GoRoute(
        path: ConstantsRouteValue.lecturer,
        pageBuilder: (context, state){
          return CustomAnimationPageUtils.animate(
            key: state.pageKey,
            child: DataLecturerPage()
          );
        },
        routes: [
          GoRoute(
            path: ConstantsRouteValue.actionLecturer,
            pageBuilder: (context, state){
              return CustomAnimationPageUtils.animate(
                key: state.pageKey,
                child: InputDataLecturerPage(
                  data: state.extra as LecturerModel?,
                )
              );
            }
          ),
        ]
      ),
    ]
  );
}