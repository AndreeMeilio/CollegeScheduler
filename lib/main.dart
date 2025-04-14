import 'dart:io';

import 'package:college_scheduler/config/color_config.dart';
import 'package:college_scheduler/config/cubit_config.dart';
import 'package:college_scheduler/config/di_config.dart';
import 'package:college_scheduler/config/generated/app_localizations.dart';
import 'package:college_scheduler/config/generated/app_localizations_en.dart';
import 'package:college_scheduler/config/generated/app_localizations_id.dart';
import 'package:college_scheduler/config/route_navigator_config.dart';
import 'package:college_scheduler/cubit/language_locale_cubit.dart';
import 'package:college_scheduler/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key}); 

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  // bool _isJailbroken = false;

  @override
  void initState() {
    super.initState();
    // checkJailbreak();
  }

  // Future<void> checkJailbreak() async {
  //   bool jailbroken;
  //   try {
  //     jailbroken = await FlutterJailbreakDetection.jailbroken;
  //   } catch (e) {
  //     jailbroken = false;
  //   }

  //   setState(() {
  //     _isJailbroken = jailbroken;
  //   });

  //   if (jailbroken) {
  //     // Jika perangkat terdeteksi jailbreak, keluar dari aplikasi
  //     Future.delayed(Duration(seconds: 2), () {
  //       exitApp();
  //     });
  //   }
  // }

  // void exitApp() {
  //   // Untuk keluar dari aplikasi
  //   Future.delayed(Duration(milliseconds: 500), () {
  //     if (Platform.isAndroid) {
  //       SystemNavigator.pop(); // Tutup aplikasi di Android
  //     } else if (Platform.isIOS) {
  //       exit(0); // Tutup aplikasi di iOS
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: CubitConfig.getProviders(),
      child: BlocBuilder<LanguageLocaleCubit, Locale>(
        builder: (context, state) {
          return MaterialApp.router(
            title: 'Jadwal Kuliah',
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: ColorConfig.mainColor),
              useMaterial3: true,
              fontFamily: "LibreBaskerville",
              scaffoldBackgroundColor: ColorConfig.backgroundColor
            ),
            locale: state,
            routerConfig: RouteNavigatorConfig.router,
          );
        }
      ),
    );
  }
}