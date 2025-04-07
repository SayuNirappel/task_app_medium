import 'package:flutter/material.dart';
import 'package:task_app_medium/controller/task_screen_controller.dart';

class TaskDetailsScreen extends StatefulWidget {
  final int index;
  const TaskDetailsScreen({super.key, required this.index});

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    String eval = TaskScreenController.taskList[widget.index]["priority"];
    int pState = TaskScreenController.taskList[widget.index]["status"];
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
                  TaskScreenController.taskList[widget.index]["title"],
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
                      TaskScreenController.taskList[widget.index]["category"],
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Status : ",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    InkWell(
                      onTap: () async {
                        int newStatus = pState == 0 ? 1 : 0;
                        int taskId =
                            TaskScreenController.taskList[widget.index]["id"];
                        await TaskScreenController.updateTaskStatus(
                            taskId, newStatus);
                        // Refresh the task list
                        await TaskScreenController.getTaskList();
                        // Update the state
                        setState(() {
                          pState = newStatus;
                        });
                      },
                      child: Container(
                        child: Text(
                          pState == 0 ? "In Progress" : "Completed",
                          style: TextStyle(
                              color: pState == 0
                                  ? Colors.redAccent
                                  : Colors.lightGreenAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ),
                    Text(
                      " (Click to change Status)",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
                Container(
                    child: Text(
                  TaskScreenController.taskList[widget.index]["details"],
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
                TaskScreenController.taskList[widget.index]["date"],
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
