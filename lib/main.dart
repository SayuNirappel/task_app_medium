import 'package:flutter/material.dart';
import 'package:task_app_medium/controller/task_screen_controller.dart';
import 'package:task_app_medium/view/task_list_screen/task_list.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await TaskScreenController.initDb();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TaskList(),
    );
  }
}
