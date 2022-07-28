import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/cubit/app_cubit.dart';
import '../../../core/cubit/app_state.dart';
import '../No_tasks_widget/no_tasks_widget.dart';
import '../check_box_element/check_box_element.dart';

class TaskItemBuilder extends StatelessWidget {
  const TaskItemBuilder({
    required this.tasks,
  });

  final List<Map> tasks;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (BuildContext context, AppStates state) {
        AppCubit cubit = AppCubit.get(context);

        return ConditionalBuilder(
          condition: tasks.isNotEmpty,
          builder: (context) => ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) => TaskCheckBoxBuilder(
              item: tasks[index],
              index: index,
              colour: cubit.colorList[index % cubit.colorList.length],
            ),
          ),
          fallback: (context) => NoTasksElement(),
        );
      },
    );
  }
}
