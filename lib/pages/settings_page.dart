import 'package:college_scheduler/components/quote_widget.dart';
import 'package:college_scheduler/config/color_config.dart';
import 'package:college_scheduler/config/constants_route_value.dart';
import 'package:college_scheduler/config/generated/app_localizations.dart';
import 'package:college_scheduler/config/shared_preference.dart';
import 'package:college_scheduler/config/state_general.dart';
import 'package:college_scheduler/config/text_style_config.dart';
import 'package:college_scheduler/cubit/language_locale_cubit.dart';
import 'package:college_scheduler/cubit/menu/settings_menu_cubit.dart';
import 'package:college_scheduler/data/models/menu_model.dart';
import 'package:college_scheduler/pages/change_fullname_username_page.dart';
import 'package:college_scheduler/pages/change_password_page.dart';
import 'package:college_scheduler/pages/data_class_page.dart';
import 'package:college_scheduler/pages/data_lecturer_page.dart';
import 'package:college_scheduler/pages/event_history_page.dart';
import 'package:college_scheduler/pages/login_history_page.dart';
import 'package:college_scheduler/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  late LanguageLocaleCubit _cubit;

  @override
  void initState() {
    super.initState();

    _cubit = BlocProvider.of<LanguageLocaleCubit>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          spacing: 24.0,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // QuoteWidget(),
            const SizedBox(
              height: 8.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    AppLocalizations.of(context)?.settingsMenuButton ?? "Settings",
                    style: TextStyleConfig.heading1,
                  ),
                ),
                BlocBuilder<LanguageLocaleCubit, Locale>(
                  builder: (context, state){
                    return GestureDetector(
                      onTap: (){
                        try {
                          late Locale changeLocale;

                          if (state.languageCode == "en"){
                            changeLocale = Locale("id");
                          } else {
                            changeLocale = Locale("en");
                          }
                          _cubit.changeLocale(changeLocale);
                          print("test");
                        } catch (e){
                          print(e);
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 24.0),
                        width: 30.0,
                        height: 30.0,
                        child: Image.asset(state.languageCode == "en" ? "assets/united-states.png" : "assets/indonesia.png"),
                      )
                    );
                  },
                )
              ],
            ),
            SettingsListWidget(),
            const SizedBox()
          ],
        ),
      ),
    );
  }
}

class SettingsListWidget extends StatefulWidget {
  const SettingsListWidget({super.key});

  @override
  State<SettingsListWidget> createState() => _SettingsListWidgetState();
}

class _SettingsListWidgetState extends State<SettingsListWidget> {
  late SettingsMenuCubit _cubit;

  @override
  void initState() {
    super.initState();

    _cubit = BlocProvider.of<SettingsMenuCubit>(context, listen: false);
    _cubit.getAllMenu();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsMenuCubit, SettingsMenuStateType>(
      builder: (context, state){
        if (state.state is SettingsMenuFailedState){
          return Center(
            child: Text(
              state.message ?? "",
              style: TextStyleConfig.body1bold,
            ),
          );
        } else if (state.state is SettingsMenuLoadedState){
          if (state.data?.isNotEmpty ?? false){
            List<MenuModel?> dataListMenu = List.from([]);
            List<MenuModel?> notificationListMenu = List.from([]);
            List<MenuModel?> accountListMenu = List.from([]);

            for (MenuModel? data in state.data!){
              if (data?.parentName == "data"){
                dataListMenu.add(data);
              } else if (data?.parentName == "notification"){
                notificationListMenu.add(data);
              } else if (data?.parentName == "account"){
                accountListMenu.add(data);
              }
            }

            List dataMenu = List.from([
              {
                "label": AppLocalizations.of(context)?.dataSettingsLabel ?? "Data",
                "item" : dataListMenu
              },
              {
                "label": AppLocalizations.of(context)?.notificationSettingsLabel ?? "Notification",
                "item" : notificationListMenu
              },
              {
                "label": AppLocalizations.of(context)?.accountSettingsLabel ?? "Account",
                "item" : accountListMenu
              },
            ]);

            return ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index){
                return SettingsDataSectionWidget(
                  label: dataMenu[index]["label"],
                  dataMenu: dataMenu[index]["item"],
                );
              }, 
              separatorBuilder: (context, index){
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Divider(
                    height: 0.0,
                    thickness: 3,
                  ),
                );
              }, 
              itemCount: dataMenu.length
            );
          } else {
            return Center(
              child: Text(
                AppLocalizations.of(context)?.gettingDataEmpty(AppLocalizations.of(context)?.settingsMenuButton ?? "") ?? "You don't have data on Settings",
                style: TextStyleConfig.body1bold,
              ),
            );
          }
        } else {
          return ListView.builder(
            itemCount: 3,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index){
              return SettingsDataListLoadingItem();
            },
          );
        }
      },
    );
  }
}

class SettingsDataSectionWidget extends StatelessWidget {
  SettingsDataSectionWidget({
    super.key,
    required String label,
    required List<MenuModel?> dataMenu
  }) : _label = label,
       _dataMenu = dataMenu;

  final String _label;
  final List<MenuModel?> _dataMenu;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        spacing: 16.0,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            _label,
            style: TextStyleConfig.body1bold,
          ),
          ListView.separated(
            itemCount: _dataMenu.length,
            shrinkWrap: true,
            separatorBuilder: (context, index) {
              return const SizedBox(height: 16.0,);
            },
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index){
              return SettingsDataListItem(
                onTap: () async{
                  if (_dataMenu[index]?.route == "/logout"){
                    final prefs = SharedPreferenceConfig();

                    await prefs.clearShared();

                    if (context.mounted){
                      context.pushReplacement(ConstantsRouteValue.login);
                    }
                  } else {
                    if (_dataMenu[index] != null && (_dataMenu[index]?.route?.isNotEmpty ?? false)) context.push(_dataMenu[index]!.route!);
                  }
                },
                menu: AppLocalizations.of(context)?.menuSettingsLabel(_dataMenu[index]?.name ?? "") ?? _dataMenu[index]?.name ?? "",
                isFeatureIncoming: _dataMenu[index]?.isIncoming,
              );
            },
          ),
        ],
      ),
    );
  }
}

class SettingsDataListItem extends StatelessWidget {
  SettingsDataListItem({
    super.key,
    required String menu,
    required void Function()? onTap,
    bool? isFeatureIncoming

  }) : _menu = menu,
       _onTap = onTap,
       _isFeatureIncoming = isFeatureIncoming;

  final String _menu;
  final void Function()? _onTap;
  final bool? _isFeatureIncoming;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _isFeatureIncoming ?? false ? ColorConfig.greyColor : ColorConfig.whiteColor,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        border: Border.all(color: ColorConfig.mainColor, width: 1.5)
      ),
      child: Material(
        color: Colors.transparent,
        child: _isFeatureIncoming ?? false
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _menu,
                      style: TextStyleConfig.body1,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: ColorConfig.whiteColor,
                      border: Border.all(color: ColorConfig.mainColor, width: 1.5),
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    child: Text(
                      AppLocalizations.of(context)?.incoming ?? "Coming Soon",
                      style: TextStyleConfig.body1,
                    ),
                  )
                ],
              )
            )
          : InkWell(
              onTap: _onTap,
              splashColor: ColorConfig.blackTransparent,
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                child: Text(
                  _menu,
                  style: TextStyleConfig.body1,
                ),
              ),
            ),
      ),
    );
  }
}

class SettingsDataListLoadingItem extends StatelessWidget {
  const SettingsDataListLoadingItem();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorConfig.whiteColor,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Shimmer.fromColors(
        baseColor: ColorConfig.greyColor,
        highlightColor: ColorConfig.whiteColor,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          height: 12.0,
          width: MediaQuery.sizeOf(context).width * 0.25,
          color: ColorConfig.greyColor,
        ),
      )
    );
  }
}