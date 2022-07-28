import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/utils//services/local_services/local_notification_services/local_notification_services.dart';

import 'app_state.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  List? isChecked;
  Database? database;

  void createDataBase() {
    openDatabase(
      'todo.db',
      version: 2,
      onCreate: (database, int version) {
        debugPrint('db created');
        // When creating the db, create the table
        database.execute('''CREATE TABLE tasks
            (id INTEGER PRIMARY KEY,title TEXT,date TEXT ,startingTime Text,endingTime Text,reminder Text,repeater Text, status TEXT,favourite INT)''').then((value) {
          debugPrint('table crated');
        }).catchError((error) {
          debugPrint(' error when Creating table${error.toString}}');
        });
      },
      onOpen: (database) {
        getDataFromDataBase(database: database);
        debugPrint('db opened');
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  insertToDatabase({
    String? title,
    String? date,
    String? startingTime,
    String? endingTime,
    String? reminder,
    String? repeater,
  }) async {
    await database?.transaction((txn) async {
      txn.rawInsert(
          '''INSERT INTO tasks(title, date, startingTime,endingTime,reminder,repeater, status, favourite)
               VALUES("$title","$date","$startingTime","$endingTime","$reminder","$repeater", "new","${0}")''').then((value) {
        debugPrint('$value.inserted successfully');

        emit(AppInsertDatabaseState());

        getDataFromDataBase(database: database);
      }).catchError((onError) {
        debugPrint('Error when inserting New Record${onError.toString()}');
      });
    });
  }

  List<Map> allTasks = [];
  List<Map> completedTasks = [];
  List<Map> unCompletedTasks = [];
  List<Map> favoriteTasks = [];

  void getDataFromDataBase({database}) {
    allTasks = [];
    completedTasks = [];
    unCompletedTasks = [];
    favoriteTasks = [];
    emit(AppGetDatabaseLoadingState());
    return database?.rawQuery('SELECT * FROM tasks').then((value) {
      allTasks = value;

      for (var element in value) {
        if (element['status'] == 'Completed') {
          completedTasks.add(element);
        } else if (element['status'] == 'not done' ||
            element['status'] == 'new') {
          unCompletedTasks.add(element);
        }
        if (element['favourite'] == 1) {
          favoriteTasks.add(element);
        }

        emit(AppGetDatabaseState());
      }
      debugPrint("${favoriteTasks.toString()} from get");
    });
  }

  void addFavourite({
    required int status,
    required int id,
  }) {
    database?.rawUpdate('UPDATE tasks SET favourite = ? WHERE id = ?',
        [status, '$id']).then((value) {
      getDataFromDataBase(database: database);
      emit(AppUpdateDatabaseState());
    });
  }

  void updateData({
    required String status,
    required int id,
  }) {
    database?.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
        [status, '$id']).then((value) {
      getDataFromDataBase(database: database);
      emit(AppUpdateDatabaseState());
    });
  }

  void deleteData({
    required int id,
  }) {
    database?.rawDelete(
      'DELETE FROM tasks WHERE id = ?',
      [id],
    ).then((value) {
      getDataFromDataBase();
      emit(AppDeleteDatabaseState());
    });
  }

  List<Color> colorList = [
    const Color(0xff0097A7),
    const Color(0xffFF5252),
    const Color(0xff4CAF50),
    const Color(0xffFF9800),
  ];
  DateTime? scheduleDate;
  void setScheduleDate(DateTime date) {
    scheduleDate = date;
    emit(ChangeDataScheduleState());
  }




  LocalNotificationService Notification(){
    late final LocalNotificationService service;
    service = LocalNotificationService();
    service.initialize();
    return service;
  }

}
