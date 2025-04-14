import 'package:college_scheduler/components/delete_confirmation_component.dart';
import 'package:college_scheduler/components/primary_button.dart';
import 'package:college_scheduler/config/color_config.dart';
import 'package:college_scheduler/config/constants_route_value.dart';
import 'package:college_scheduler/config/generated/app_localizations.dart';
import 'package:college_scheduler/config/state_general.dart';
import 'package:college_scheduler/config/text_style_config.dart';
import 'package:college_scheduler/cubit/class/list_data_class_cubit.dart';
import 'package:college_scheduler/data/models/class_model.dart';
import 'package:college_scheduler/pages/input_data_class_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';

class DataClassPage extends StatefulWidget {
  const DataClassPage({super.key});

  @override
  State<DataClassPage> createState() => _DataClassPageState();
}

class _DataClassPageState extends State<DataClassPage> {

  late ListDataClassCubit _cubit;

  @override
  void initState() {
    super.initState();

    _cubit = BlocProvider.of<ListDataClassCubit>(context, listen: false);
    _cubit.getAllData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: ColorConfig.backgroundColor,
        backgroundColor: ColorConfig.backgroundColor,
        title: Text(AppLocalizations.of(context)?.dataClassTitle ?? "Data Class", style: TextStyleConfig.body1,),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background_image.png"),
            fit: BoxFit.cover
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: BlocBuilder<ListDataClassCubit, StateGeneral>(
                builder: (context, state) {
                  if (state.state is ListDataClassLoadedState){
                    if (state.data.isNotEmpty){
                      return ListView.separated(
                        itemCount: state.data.length,
                        physics: BouncingScrollPhysics(),
                        separatorBuilder: (context, index) {
                          return Divider(color: ColorConfig.backgroundColor, height: 2.0,);
                        },
                        itemBuilder: (context, index){
                          return DataClassItemWidget(
                            data: state.data[index],
                            cubit: _cubit,
                          );
                        },
                      );
                    } else {
                      return Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(vertical: 24.0),
                        child: Text(
                          AppLocalizations.of(context)?.gettingDataEmpty(AppLocalizations.of(context)?.dataClassTitle ?? "Data Class") ?? "You Don't Have Any Data On Class",
                          style: TextStyleConfig.body1bold,
                        ),
                      );
                    }
                  } else if (state.state is ListDataClassFailedState){
                    return Center(
                      child: Text(
                        state.message ?? "",
                        style: TextStyleConfig.body1,
                      ),
                    );
                  } else {
                    return ListView.separated(
                      itemCount: 5,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) {
                        return Divider(color: ColorConfig.backgroundColor, height: 2.0,);
                      },
                      itemBuilder: (context, index){
                        return DataClassItemLoadingWidget();
                      },
                    );
                  }
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 24.0),
              alignment: Alignment.center,
              child: PrimaryButtonComponent(
                label: AppLocalizations.of(context)?.createDataClass ?? "Create Data Class",
                onTap: (){
                  context.push("${ConstantsRouteValue.clasess}/${ConstantsRouteValue.actionClasess}");
                },
              ),
            )
          ],
        ),
      )
    );
  }
}

class DataClassItemWidget extends StatelessWidget {
  const DataClassItemWidget({
    super.key,
    required ClassModel data,
    required ListDataClassCubit cubit
  }) : _data = data,
       _cubit = cubit;

  final ClassModel _data;
  final ListDataClassCubit _cubit;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(_data.id),
      startActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            onPressed: (context) {
              context.push("${ConstantsRouteValue.clasess}/${ConstantsRouteValue.actionClasess}", extra: _data);
            },
            label: AppLocalizations.of(context)?.editButton ?? "Edit",
            backgroundColor: ColorConfig.mainColor,
            icon: Icons.edit,
          ),
          SlidableAction(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            onPressed: (context) async{
              showModalBottomSheet(
                context: context,
                builder: (context){
                  return DeleteConfirmationComponent(
                    onCancel: (){
                      context.pop();
                    }, 
                    onProcceed: () async{
                      await _cubit.deleteData(data: _data);

                      if (context.mounted){
                        context.pop();
                      }
                    }
                  );
                }
              );
            },
            label: AppLocalizations.of(context)?.deleteButton ?? "Delete",
            backgroundColor: ColorConfig.redColor,
            icon: Icons.edit,
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          color: ColorConfig.mainColor,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
        child: Column(
          spacing: 4.0,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              _data.name ?? "",
              style: TextStyleConfig.body1bold,
            ),
            Text(
              _data.lecturerName ?? "",
              style: TextStyleConfig.body1,
            ),
            const SizedBox(height: 4.0,),
            Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      _data.day == DAYOFWEEK.selectDay ? "" : "${_data.day?.name[0].toUpperCase()}${_data.day?.name.substring(1)}",
                      style: TextStyleConfig.body1,
                    ),
                  )
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "${_data.startHour?.hour}:${_data.startHour?.minute}",
                      style: TextStyleConfig.body1,
                    ),
                  )
                ),
                Text(
                  AppLocalizations.of(context)?.to ?? "To",
                  style: TextStyleConfig.body1,
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "${_data.endHour?.hour}:${_data.endHour?.minute}",
                      style: TextStyleConfig.body1,
                    ),
                  )
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class DataClassItemLoadingWidget extends StatelessWidget {
  const DataClassItemLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorConfig.mainColor,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: Column(
        spacing: 4.0,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Shimmer.fromColors(
            baseColor: ColorConfig.greyColor,
            highlightColor: ColorConfig.whiteColor,
            child: Container(
              width: MediaQuery.sizeOf(context).width * 0.4,
              height: 10.0,
              color: ColorConfig.greyColor,
            )
          ),
          Shimmer.fromColors(
            baseColor: ColorConfig.greyColor,
            highlightColor: ColorConfig.whiteColor,
            child: Container(
              width: MediaQuery.sizeOf(context).width * 0.5,
              height: 10.0,
              color: ColorConfig.greyColor,
            )
          ),
          const SizedBox(height: 4.0,),
          Row(
            spacing: 24.0,
            children: [
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.center,
                  child: Shimmer.fromColors(
                    baseColor: ColorConfig.greyColor,
                    highlightColor: ColorConfig.whiteColor,
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 0.4,
                      height: 10.0,
                      color: ColorConfig.greyColor,
                    )
                  ),
                )
              ),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.center,
                  child: Shimmer.fromColors(
                    baseColor: ColorConfig.greyColor,
                    highlightColor: ColorConfig.whiteColor,
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 0.4,
                      height: 10.0,
                      color: ColorConfig.greyColor,
                    )
                  ),
                )
              ),
              Text(
                AppLocalizations.of(context)?.to ?? "To",
                style: TextStyleConfig.body1,
              ),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.center,
                  child: Shimmer.fromColors(
                    baseColor: ColorConfig.greyColor,
                    highlightColor: ColorConfig.whiteColor,
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 0.4,
                      height: 10.0,
                      color: ColorConfig.greyColor,
                    )
                  ),
                )
              ),
            ],
          )
        ],
      ),
    );
  }
}