import 'package:college_scheduler/components/delete_confirmation_component.dart';
import 'package:college_scheduler/components/primary_button.dart';
import 'package:college_scheduler/config/color_config.dart';
import 'package:college_scheduler/config/constants_route_value.dart';
import 'package:college_scheduler/config/generated/app_localizations.dart';
import 'package:college_scheduler/config/state_general.dart';
import 'package:college_scheduler/config/text_style_config.dart';
import 'package:college_scheduler/cubit/class/list_data_class_cubit.dart';
import 'package:college_scheduler/cubit/lecturer/list_lecturer_cubit.dart';
import 'package:college_scheduler/data/models/class_model.dart';
import 'package:college_scheduler/data/models/lecturer_model.dart';
import 'package:college_scheduler/pages/input_data_class_page.dart';
import 'package:college_scheduler/pages/input_data_lecturer_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';

class DataLecturerPage extends StatefulWidget {
  const DataLecturerPage({super.key});

  @override
  State<DataLecturerPage> createState() => _DataLecturerPageState();
}

class _DataLecturerPageState extends State<DataLecturerPage> {

  late ListLecturerCubit _cubit;

  @override
  void initState() {
    super.initState();

    _cubit = BlocProvider.of<ListLecturerCubit>(context, listen: false);
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
        title: Text(AppLocalizations.of(context)?.dataLecturerTitle ?? "Data Lecturer", style: TextStyleConfig.body1,),
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
              child: BlocBuilder<ListLecturerCubit, StateGeneral>(
                builder: (context, state) {
                  if (state.state is ListLecturerLoadedState){
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
                          AppLocalizations.of(context)?.gettingDataEmpty(AppLocalizations.of(context)?.dataLecturerTitle ?? "") ?? "You Don't Have Any Data On Lecturer",
                          style: TextStyleConfig.body1bold,
                        ),
                      );
                    }
                  } else if (state.state is ListLecturerFailedState){
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
                label: AppLocalizations.of(context)?.createDataLecturer ?? "Create Data Lecturer",
                onTap: (){
                  context.push("${ConstantsRouteValue.lecturer}/${ConstantsRouteValue.actionLecturer}");
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
    required LecturerModel data,
    required ListLecturerCubit cubit
  }) : _data = data,
       _cubit = cubit;

  final LecturerModel _data;
  final ListLecturerCubit _cubit;

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
              context.push("${ConstantsRouteValue.lecturer}/${ConstantsRouteValue.actionLecturer}", extra: _data);
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
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          color: ColorConfig.mainColor,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Text(
          _data.name ?? "",
          style: TextStyleConfig.body1bold,
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
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        color: ColorConfig.mainColor,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Shimmer.fromColors(
        baseColor: ColorConfig.greyColor,
        highlightColor: ColorConfig.whiteColor,
        child: Container(
          width: MediaQuery.sizeOf(context).width * 0.4,
          height: 10.0,
          color: ColorConfig.greyColor,
        )
      ),
    );
  }
}