import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/core/cubit/app_cubit.dart';
import 'package:todoapp/core/cubit/app_state.dart';

class TaskCheckBoxBuilder extends StatelessWidget {
  const TaskCheckBoxBuilder({
    required this.item,
    required this.index,
    required this.colour,
  });

  final int index;
  final Map item;
  final Color? colour;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, AppStates state) {},
      builder: (BuildContext context, AppStates state) {
        AppCubit cubit = AppCubit.get(context);
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Dismissible(
            direction: DismissDirection.endToStart,
            background: Container(
              decoration: BoxDecoration(
                  color: Colors.deepOrange[300],
                  borderRadius: BorderRadius.circular(15)),
              width: 100,
              child: const Center(
                child: Padding(
                  padding: EdgeInsetsDirectional.only(start: 180),
                  child: Icon(Icons.delete),
                ),
              ),
            ),
            confirmDismiss: (direction) => showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                        title: const Text('Please Confirm'),
                        content: const Text('Are you sure you want to delete?'),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(ctx).pop(false);
                              },
                              child: const Text('Cancel')),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(ctx).pop(true);
                              },
                              child: const Text('Confirm')),
                        ])),
            onDismissed: (DismissDirection direction) {
              if (direction == DismissDirection.endToStart) {
                AppCubit.get(context).deleteData(
                  id: item['id'],
                );

                cubit.Notification().showNotificationWithPayload(
                    id: 0,
                    title: '${item['title']}',
                    body: 'you have deleted the Task',
                    payload: 'payload navigation');
              }
            },
            key: Key(item['id'].toString()),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      item['status'] != 'Completed'
                          ? cubit.updateData(
                              status: 'Completed', id: item['id'])
                          : cubit.updateData(
                              status: 'not done', id: item['id']);
                    },
                    child: Container(
                      width: 30,
                      height: 30,

                      child: item['status'] == 'Completed'
                          ? Icon(
                              Icons.check_box,
                              color: colour,
                              size: 30,
                            )
                          : Icon(
                              Icons.check_box_outline_blank_outlined,
                              color: colour,
                              size: 30,
                            ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    '${item['title']}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      item['favourite'] == 0
                          ? cubit.addFavourite(status: 1, id: item['id'])
                          : cubit.addFavourite(status: 0, id: item['id']);
                    },
                    icon: item['favourite'] == 0
                        ? const Icon(
                            Icons.favorite_border,
                            size: 25,
                          )
                        : const Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 25,
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
