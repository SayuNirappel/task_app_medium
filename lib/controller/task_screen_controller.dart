import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/setup.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class TaskScreenController {
  static late Database database;
  static List<Map> taskList = [];
  static List<Map> searchList = [];
  static String sCondition = "title";
  static String? displayCategory;
  static String? selectedCategory;
  static String? selectedPriority;
  static const List<String> categories = [
    "All",
    "Personal",
    "Work",
    "Daily Routine",
    "Study",
    "Finance",
    "Health & Fitness",
    "Travel",
    "Shopping Lists",
    "Ideas & Inspiration",
    "To-Do Lists",
    "Events & Appointments"
  ];
  static const List<String> priorities = [
    "Level 0",
    "Level 1",
    "Level 2",
    "Level 3",
    "Level 4"
  ];

  static List<Color> priorColorSelection(String eval) {
    switch (eval) {
      case "Level 0":
        return [Colors.lightGreenAccent.shade100, Colors.green];
      case "Level 1":
        return [Colors.lightBlueAccent.shade100, Colors.blueAccent];
      case "Level 3":
        return [Colors.deepOrangeAccent.shade100, Colors.deepOrange];

      case "Level 4":
        return [Colors.redAccent.shade100, Colors.red];
      default:
        return [Colors.yellowAccent.shade100, Colors.amber];
    }
  }

  static void onCategorySelection(String? value) {
    selectedCategory = value;
  }

  static void onDisCategorySelection(String? value) {
    displayCategory = value;
  }

  static void onPrioritySelection(String? value) {
    selectedPriority = value;
  }

  ///
  ///-----------Date Selection---------------
  ///

  static Future<String> onDateSelection(BuildContext context) async {
    var selectedDate = await showDatePicker(
        context: context, firstDate: DateTime.now(), lastDate: DateTime(2035));
    //return "";

//     //print(selectedDate);

//     // format date

    if (selectedDate != null) {
      String formatedDate = DateFormat("dd/MM/yyyy").format(selectedDate);
      return formatedDate;
    }
    return "";
  }

  ///
  ///
  ///
  //sqflite codes
  ///
  ///
  ///

  static Future<void> initDb() async {
    if (kIsWeb) {
      // Change default factory on the web
      databaseFactory = databaseFactoryFfiWeb;
    }

    //open DB
    database = await openDatabase("task.db", version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE Tasks (id INTEGER PRIMARY KEY, title TEXT, details TEXT, category TEXT, priority TEXT,date TEXT)');
    });
  }

  ///
  ///
  ///// get data from DB
  ///
  ///

  static Future<void> getTaskList() async {
    taskList = await database.rawQuery('SELECT * FROM Tasks');
    //await getTaskList();
    log(taskList.toString());
  }

  ///
  ///
  // add data to DB
  ///
  ///
  static Future<void> addTask({
    required String title,
    required String details,
    required String date,
  }) async {
    await database.rawInsert(
        'INSERT INTO Tasks(title, details, category, priority, date) VALUES(?, ?, ?,?, ?)',
        [title, details, selectedCategory, selectedPriority, date]);
    await getTaskList();
    //
    //askabout await while calling addnote and on calling getallNotes
    //
  }

  ///
  ///
  ///--------Update data on DB
  ///
  ///
  static Future<void> editTask(
      {required String title,
      required String details,
      required String date,
      required int taskId}) async {
    await database.rawUpdate(
      'UPDATE Tasks SET title = ?, details = ?, priority=?, category = ?, date = ? WHERE id = ?',
      [title, details, selectedPriority, selectedCategory, date, taskId],
    );
    await getTaskList();
  }

  ///
  ///
  ///---Deleete Data from DB
  ///
  ///

  static Future<void> removeTask(var did) async {
    await database.rawDelete('DELETE FROM Tasks WHERE id = ?', [did]);
    await getTaskList();
  }

  ///
  ///
  ///-------search data on DB
  ///
  ///

  static Future<void> searchTask(String ipdata) async {
    searchList = await database.rawQuery(
      'SELECT * FROM Tasks WHERE $sCondition LIKE ?',
      ['%$ipdata%'],
    );
    log(searchList.toString());
  }
}
