import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/core/cubit/app_cubit.dart';
import 'package:todoapp/core/cubit/app_state.dart';
import 'package:todoapp/presentation/widgets/main_button_widget/main_button.dart';
import 'package:todoapp/presentation/widgets/text_form_feild/textformFeild.dart';

class TaskAddingScreen extends StatelessWidget {
  const TaskAddingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController titleController = TextEditingController();
    TextEditingController dateController = TextEditingController();
    TextEditingController startTimeController = TextEditingController();
    TextEditingController endTimeController = TextEditingController();
    TextEditingController? remindController = TextEditingController();
    TextEditingController? repeatController = TextEditingController();
    String? selectedRemind = '10 min before';
    List<String> remindList = [
      '1 day before',
      '1 hour before',
      '30 min before',
      '10 min before'
    ];
    String _selectedRepeat = 'None';
    List<String> repeatList = ['None', 'Daily', 'Weekly', 'Monthly'];

    return BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {},
        builder: (BuildContext context, AppStates state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(FontAwesomeIcons.angleLeft),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: const Text('Add Task'),
              elevation: 1,
            ),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FormFieldName(
                          label: 'Title',
                        ),
                        CustomFormField(
                          Controller: titleController,
                          hintText: 'Enter Task Title ',
                          textInputType: TextInputType.text,
                          width: double.infinity,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        FormFieldName(
                          label: 'Date',
                        ),
                        CustomFormField(
                          Controller: dateController,
                          hintText: 'Enter Task DATE ',
                          textInputType: TextInputType.datetime,
                          onTapped: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime.parse('2025-05-03'),
                            ).then((value) => {
                                  dateController.text =
                                      DateFormat.yMMMd().format(value!)
                                });
                          },
                          width: double.infinity,
                          suffixIcon: const Icon(FontAwesomeIcons.angleDown),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FormFieldName(
                                    label: 'Start time',
                                  ),
                                  CustomFormField(
                                    Controller: startTimeController,
                                    hintText: 'Starting  ',
                                    textInputType: TextInputType.datetime,
                                    onTapped: () {
                                      showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay.now())
                                          .then((value) => {
                                                startTimeController.text =
                                                    value!
                                                        .format(context)
                                                        .toString()
                                              });
                                    },
                                    suffixIcon:
                                        const Icon(FontAwesomeIcons.clock),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FormFieldName(
                                    label: 'Ending time',
                                  ),
                                  CustomFormField(
                                    Controller: endTimeController,
                                    hintText: 'Ending  ',
                                    textInputType: TextInputType.datetime,
                                    onTapped: () {
                                      showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay.now())
                                          .then((value) => {
                                                endTimeController.text = value!
                                                    .format(context)
                                                    .toString()
                                              });
                                    },
                                    suffixIcon:
                                        const Icon(FontAwesomeIcons.clock),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        FormFieldName(
                          label: 'Remind',
                        ),
                        CustomFormField(
                          Controller: remindController,
                          hintText: selectedRemind,
                          width: double.infinity,
                          suffixIcon: DropdownButton(
                            dropdownColor: Colors.blueGrey,
                            borderRadius: BorderRadius.circular(10),
                            items: remindList
                                .map<DropdownMenuItem<String>>(
                                  (String value) => DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        )),
                                  ),
                                )
                                .toList(),
                            icon: const Icon(Icons.keyboard_arrow_down,
                                color: Colors.grey),
                            iconSize: 32,
                            elevation: 4,
                            underline: Container(height: 0),
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                            onChanged: (String? newValue) {
                              remindController.text = newValue!;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        FormFieldName(
                          label: 'Repeat',
                        ),
                        CustomFormField(
                          Controller: repeatController,
                          hintText: _selectedRepeat,
                          width: double.infinity,
                          suffixIcon: DropdownButton(
                            dropdownColor: Colors.blueGrey,
                            borderRadius: BorderRadius.circular(10),
                            items: repeatList
                                .map<DropdownMenuItem<String>>(
                                  (String value) => DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        )),
                                  ),
                                )
                                .toList(),
                            icon: const Icon(Icons.keyboard_arrow_down,
                                color: Colors.grey),
                            iconSize: 32,
                            elevation: 4,
                            underline: Container(height: 0),
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                            onChanged: (String? newValue) {
                              repeatController.text = newValue!;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        MainButton(
                          onTabbed: () {
                            if (formKey.currentState!.validate()) {
                              cubit.insertToDatabase(
                                title: titleController.text,
                                date: dateController.text,
                                startingTime: startTimeController.text,
                                endingTime: endTimeController.text,
                                reminder: remindController.text,
                                repeater: repeatController.text,
                              );
                            }
                            cubit.Notification().showNotificationWithPayload(
                                id: 0,
                                title: titleController.text,
                                body: 'you have created a new task',
                                payload: 'payload navigation');

                            titleController.clear();
                            dateController.clear();
                            startTimeController.clear();
                            endTimeController.clear();
                            remindController.clear();
                            repeatController.clear();
                          },
                          myColor: const Color(0xff25C06D),
                          width: 450,
                          height: 50,
                          myStyle: const Text(
                            'Create a task',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ]),
                ),
              ),
            ),
          );
        });
  }
}
