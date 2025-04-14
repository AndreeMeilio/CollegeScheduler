import 'package:college_scheduler/config/color_config.dart';
import 'package:college_scheduler/config/generated/app_localizations.dart';
import 'package:college_scheduler/config/text_style_config.dart';
import 'package:college_scheduler/cubit/menu/base_menu_cubit.dart';
import 'package:college_scheduler/cubit/event/create_event_cubit.dart';
import 'package:college_scheduler/pages/dashboard_page.dart';
import 'package:college_scheduler/pages/input_data_page.dart';
import 'package:college_scheduler/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> with TickerProviderStateMixin{

  late TabController _menuController;
  late BaseMenuCubit _cubit;
  late CreateAndUpdateEventCubit _createAndUpdateCubit;

  @override
  void initState() {
    super.initState();

    _cubit = BlocProvider.of<BaseMenuCubit>(context, listen:false);
    _createAndUpdateCubit = BlocProvider.of<CreateAndUpdateEventCubit>(context, listen: false);
    _menuController = TabController(
      length: 3,
      vsync: this
    );
    
    _menuController.index = 0;

    WidgetsBinding.instance.addPostFrameCallback((_){
      _menuController.addListener((){
        _cubit.changeIndexActiveMenu(_menuController.index);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background_image.png"),
            fit: BoxFit.cover
          )
        ),
        child: SafeArea(
          child: BlocBuilder<BaseMenuCubit, int>(
            builder: (context, state) {
              _menuController.index = state;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 16.0,
                children: [
                  Expanded(
                    child: TabBarView(
                      controller: _menuController,
                      children: [
                        DashboardPage(),
                        InputDataPage(),
                        SettingsPage()
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: ColorConfig.whiteColor,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TabBar(
                      controller: _menuController,
                      dividerColor: Colors.transparent,
                      labelColor: ColorConfig.mainColor,
                      indicatorColor: ColorConfig.mainColor,
                      tabs: [
                        Column(
                          spacing: 4.0,
                          children: [
                            Icon(Icons.home),
                            Text(
                              AppLocalizations.of(context)?.homeMenuButton ?? "Home",
                              style: TextStyleConfig.body1,
                            )
                          ],
                        ),
                        Column(
                          spacing: 4.0,
                          children: [
                            Icon(Icons.add_circle_outline_rounded),
                            Text(
                              AppLocalizations.of(context)?.eventsMenuButton ?? "Events",
                              style: TextStyleConfig.body1,
                            )
                          ],
                        ),
                        Column(
                          spacing: 4.0,
                          children: [
                            Icon(Icons.settings),
                            Text(
                              AppLocalizations.of(context)?.settingsMenuButton ?? "Settings",
                              style: TextStyleConfig.body1,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}