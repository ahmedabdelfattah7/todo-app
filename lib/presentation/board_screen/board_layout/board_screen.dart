import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todoapp/core/cubit/app_cubit.dart';
import 'package:todoapp/core/cubit/app_state.dart';
import 'package:todoapp/presentation/add_task_screen/add_task_screen.dart';
import 'package:todoapp/presentation/board_screen//favourate_tasks_item/favourite_screen.dart';
import 'package:todoapp/presentation/board_screen//uncompleted_tasks_item/uncompleted_screen.dart';
import 'package:todoapp/presentation/board_screen/all_tasks_item/all_tasks_screen.dart';
import 'package:todoapp/presentation/board_screen/completed_tasks_item/completed_screen.dart';
import 'package:todoapp/presentation/schedule_screen/schedule_screen.dart';
import 'package:todoapp/presentation/widgets/main_button_widget/main_button.dart';

class BoardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, AppStates state) {},
      builder: (BuildContext context, AppStates state) {
        return DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ScheduleScreen(),
                      ),
                    );
                  },
                  icon: const Icon(
                    FontAwesomeIcons.bars,
                  ),
                ),
              ],
              backgroundColor: Colors.white,
              title: const Text(
                'Board',
              ),
            ),
            body: Column(
              children: [
                Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.grey)),
                  child: const TabBar(
                    tabs: <Widget>[
                      Tab(
                        text: 'All',
                      ),
                      Tab(
                        text: 'Completed',
                      ),
                      Tab(
                        text: 'UnCompleted',
                      ),
                      Tab(text: 'Favourite')
                    ],
                  ),
                ),
                const Expanded(
                  child: TabBarView(
                    children: [
                      AllTasksElement(),
                      CompletedTasksElement(),
                      UnCompletedTasksElement(),
                      FavouriteTasksElement(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: MainButton(
                    myStyle: const Text(
                      'Add a task',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    myColor: const Color(0xff25C06D),
                    width: 450,
                    height: 50,
                    onTabbed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TaskAddingScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
