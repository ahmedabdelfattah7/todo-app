import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/core/cubit/app_cubit.dart';
import 'package:todoapp/core/cubit/app_state.dart';
import 'package:todoapp/presentation/widgets/No_tasks_widget/no_tasks_widget.dart';
import 'package:todoapp/presentation/widgets/horizontal_timeline_calendar/horizontal_timeline_calendar.dart';
import 'package:todoapp/presentation/widgets/schedule_builder/schedule_builder.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (BuildContext context, AppStates state) {
        AppCubit cubit = AppCubit.get(context);
        var tasks = cubit.allTasks;
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(FontAwesomeIcons.angleLeft),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: const Text('Schedule'),
            elevation: 1,
          ),
          body: Column(
            children: <Widget>[
              const HorizontalTimeLineCalendar(),
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
                child: Container(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(DateFormat('EEEE').format(DateTime.now()),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            )),
                        Text(
                          DateFormat.yMMMMd().format(DateTime.now()),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ]),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: ConditionalBuilder(
                  condition: tasks.isNotEmpty,
                  builder: (BuildContext context) => ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        if (tasks[index]['repeater'] == 'Daily') {
                          return ScheduleBuilder(
                            item: tasks[index],
                            index: index,
                          );
                        }
                        if (tasks[index]['date'] ==
                            (cubit.scheduleDate != null
                                ? DateFormat.yMd().format(cubit.scheduleDate!)
                                : DateTime.now())) {
                          return ScheduleBuilder(
                            item: tasks[index],
                            index: index,
                          );
                        }
                        return Container();
                      }),
                  fallback: (context) => const NoTasksElement(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
