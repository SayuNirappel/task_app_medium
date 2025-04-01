import 'package:flutter/material.dart';
import 'package:task_app_medium/controller/task_screen_controller.dart';

void main() {}

class TaskDetailsScreen extends StatelessWidget {
  final int index;
  const TaskDetailsScreen({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    String eval = TaskScreenController.taskList[index]["priority"];
    return Scaffold(
      backgroundColor: Colors.grey.shade600,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text(
          "Task in Detail",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  TaskScreenController.taskList[index]["title"],
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
                Row(
                  spacing: 15,
                  children: [
                    Icon(
                      Icons.circle,
                      size: 10,
                      color: TaskScreenController.priorColorSelection(eval)[1],
                    ),
                    Text(
                      TaskScreenController.taskList[index]["category"],
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ],
                ),
                Container(
                    child: Text(
                  TaskScreenController.taskList[index]["details"],
                  overflow: TextOverflow.ellipsis,
                  maxLines: 10,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )),
              ],
            ),
            Container(
              color: TaskScreenController.priorColorSelection(eval)[1],
              width: double.infinity,
              child: Text(
                TaskScreenController.taskList[index]["date"],
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
