import 'package:flutter/material.dart';
import 'package:task_app_medium/controller/task_screen_controller.dart';
import 'package:task_app_medium/view/add_task_screen/add_task_screen.dart';
import 'package:task_app_medium/view/manage_task_screen/manage_task_screen.dart';
import 'package:task_app_medium/view/task_details_screen/task_details_screen.dart';

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await TaskScreenController.getTaskList();
        setState(() {});
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(
          "Daily Manager",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Icon(
            Icons.settings,
            color: Colors.white,
          ),
          SizedBox(
            width: 30,
          )
        ],
      ),
      body: Container(
        color: Colors.grey.shade600,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 10,
          children: [
            SizedBox(
              height: 10,
            ),

            ///
            ///      Generate new Task
            ///
            InkWell(
              onTap: () async {
                await Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddTaskScreen()));
                setState(() {});
              },
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                        colors: [Colors.grey.shade400, Colors.blueGrey],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black,
                          spreadRadius: 1,
                          blurRadius: 6,
                          offset: Offset(3, 3))
                    ]),
                margin: EdgeInsets.all(10),
                height: 100,
                child: Column(
                  spacing: 5,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add,
                      size: 50,
                    ),
                    Text(
                      "Add  Note / Task",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                "Your Notes",
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),

            ///
            /// Manage Tasks
            ///
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ManageTaskScreen()));
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      //color: Colors.white
                    ),
                    color: Colors.blueGrey),
                margin: EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Manage Task List",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17)),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            ),

            ///
            ///    List of Notes
            ///
            Expanded(
              child: Container(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: TaskScreenController.taskList.length,
                    itemBuilder: (context, index) {
                      String eval =
                          TaskScreenController.taskList[index]["priority"];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TaskDetailsScreen(
                                        index: index,
                                      )));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                                colors: TaskScreenController.priorColorSelection(
                                    eval), //selecting color based on priority
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight),
                          ),
                          margin: EdgeInsets.all(10),
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      TaskScreenController.taskList[index]
                                          ["title"],
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    Text(
                                      TaskScreenController.taskList[index]
                                          ["date"],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  spacing: 10,
                                  children: [
                                    //-------Edit----------
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => AddTaskScreen(
                                                  isEdit: true,
                                                  taskId: TaskScreenController
                                                      .taskList[index]["id"],
                                                  taskTitle: TaskScreenController
                                                      .taskList[index]["title"],
                                                  date: TaskScreenController
                                                      .taskList[index]["date"],
                                                  details: TaskScreenController.taskList[index]
                                                      ["details"],
                                                  priority: TaskScreenController
                                                          .taskList[index]
                                                      ["priority"],
                                                  category: TaskScreenController
                                                      .taskList[index]["category"]),
                                            ));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            gradient: LinearGradient(
                                                colors: [
                                                  Colors.white,
                                                  Colors.grey.shade400
                                                ],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black,
                                                  spreadRadius: 1,
                                                  blurRadius: 3,
                                                  offset: Offset(1, 1))
                                            ]),
                                        width: 45,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.edit),
                                            Text("Edit")
                                          ],
                                        ),
                                      ),
                                    ),
                                    //-------Delete------------
                                    InkWell(
                                      onTap: () async {
                                        var did = TaskScreenController
                                            .taskList[index]["id"];
                                        await TaskScreenController.removeTask(
                                            did);
                                        setState(() {});
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            gradient: LinearGradient(
                                                colors: [
                                                  Colors.white,
                                                  Colors.grey.shade400
                                                ],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black,
                                                  spreadRadius: 1,
                                                  blurRadius: 3,
                                                  offset: Offset(1, 1))
                                            ]),
                                        width: 45,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.delete),
                                            Text("Delete")
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
