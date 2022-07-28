import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/cubit/app_cubit.dart';
import '../../../core/cubit/app_state.dart';

class ScheduleBuilder extends StatelessWidget {
  const ScheduleBuilder({
    required this.item,
    required this.index,
  });

  final int index;
  final Map item;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (BuildContext context, AppStates state) {
        AppCubit cubit = AppCubit.get(context);
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: cubit.colorList[index % cubit.colorList.length],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${item['endingTime']}',
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${item['title']}',
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: null,
                      icon: item['status'] == 'Completed'
                          ? const Icon(
                              FontAwesomeIcons.circleCheck,
                              color: Colors.white,
                            )
                          : const Icon(
                              FontAwesomeIcons.circle,
                            ),
                    ),
                  ]),
            ),
          ),
        );
      },
    );
  }
}
