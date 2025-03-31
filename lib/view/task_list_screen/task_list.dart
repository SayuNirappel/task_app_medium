import 'package:flutter/material.dart';
import 'package:task_app_medium/controller/task_screen_controller.dart';
import 'package:task_app_medium/view/add_task_screen/add_task_screen.dart';

void main() {}

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
                        end: Alignment.bottomRight)),
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
            /// category selection
            ///
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    //color: Colors.white
                  ),
                  color: Colors.grey.shade400),
              margin: EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: DropdownButton(
                    dropdownColor: Colors.grey.shade300,
                    //focusColor: Colors.greenAccent,
                    isExpanded: true,
                    value: TaskScreenController.selectedCategory,
                    menuWidth: MediaQuery.sizeOf(context).width * .85,
                    hint: Text(
                      "All",
                      style: TextStyle(fontWeight: FontWeight.bold
                          //color: Colors.white
                          ),
                    ),
                    items: List.generate(
                        TaskScreenController.categories.length,
                        (index) => DropdownMenuItem(
                            value: TaskScreenController.categories[index],
                            child:
                                Text(TaskScreenController.categories[index]))),
                    onChanged: (value) {
                      TaskScreenController.onCategorySelection(value);
                      setState(() {});
                    }),
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
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                                colors: (eval == "Level 0")
                                    ? [
                                        Colors.lightGreenAccent.shade100,
                                        Colors.green
                                      ]
                                    : (eval == "Level 1")
                                        ? [
                                            Colors.lightBlueAccent.shade100,
                                            Colors.blueAccent
                                          ]
                                        : (eval == "Level 3")
                                            ? [
                                                Colors
                                                    .deepOrangeAccent.shade100,
                                                Colors.deepOrange
                                              ]
                                            : (eval == "Level 4")
                                                ? [
                                                    Colors.redAccent.shade100,
                                                    Colors.red
                                                  ]
                                                : [
                                                    Colors
                                                        .yellowAccent.shade100,
                                                    Colors.amber
                                                  ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight)

                            //color: Colors.redAccent.shade100,
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
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                    ),
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
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                    ),
                                    width: 45,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.delete),
                                        Text("Delete")
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
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
