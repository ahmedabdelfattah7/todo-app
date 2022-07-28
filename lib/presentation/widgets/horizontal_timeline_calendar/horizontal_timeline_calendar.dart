import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/core/cubit/app_cubit.dart';
import 'package:todoapp/core/cubit/app_state.dart';
class HorizontalTimeLineCalendar extends StatelessWidget {
  const HorizontalTimeLineCalendar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (BuildContext context, AppStates state) {
        AppCubit cubit = AppCubit.get(context);
        return Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: DatePicker(
            DateTime.now(),
            height: 80,
            width: 50.0,
            initialSelectedDate: DateTime.now(),
            selectionColor: Colors.green,
            selectedTextColor: Colors.white,
            onDateChange: (newDate) {

            },
            dateTextStyle: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
              color: Colors.grey,

            ),
          ),
        );
      },
    );
  }
}
