import 'package:flutter/material.dart';
import 'package:task_app_medium/controller/task_screen_controller.dart';

void main() {}

class ManageTaskScreen extends StatefulWidget {
  const ManageTaskScreen({super.key});

  @override
  State<ManageTaskScreen> createState() => _ManageTaskScreenState();
}

class _ManageTaskScreenState extends State<ManageTaskScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade600,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(
          "Search",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Search Category : ",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Text(
                        TaskScreenController.sCondition,
                        style: TextStyle(
                            color: Colors.orangeAccent,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  ///
                  ///Category Selection
                  ///
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          TaskScreenController.sCondition = "title";
                          setState(() {});
                        },
                        child: Container(
                          width: 80,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.deepPurple,
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: Offset(2, 2))
                              ],
                              border: Border.all(
                                  color: Colors.orangeAccent, width: 2),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              "Title",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurple,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          TaskScreenController.sCondition = "category";
                          setState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.deepPurple,
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: Offset(2, 2))
                              ],
                              border: Border.all(
                                  color: Colors.orangeAccent, width: 2),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              "Category",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurple,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          TaskScreenController.sCondition = "priority";
                          setState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.deepPurple,
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: Offset(2, 2))
                              ],
                              border: Border.all(
                                  color: Colors.orangeAccent, width: 2),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              "Priority",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurple,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 20,
                children: [
                  TextFormField(
                    controller: searchController,
                    style: TextStyle(
                        color: Colors.white, overflow: TextOverflow.ellipsis),
                    maxLines: 1,
                    decoration: InputDecoration(
                        hintText: "Enter Title",
                        hintStyle: TextStyle(color: Colors.white),
                        label: Text(
                          "Search",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.horizontal(),
                            borderSide: BorderSide(color: Colors.white)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.horizontal(),
                            borderSide: BorderSide(color: Colors.orangeAccent)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.horizontal(),
                            borderSide: BorderSide(color: Colors.purple))),
                  ),
                  InkWell(
                    onTap: () async {
                      await TaskScreenController.searchTask(
                          searchController.text);
                      setState(() {});
                    },
                    child: Container(
                      height: 40,
                      margin: EdgeInsets.symmetric(horizontal: 50),
                      decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        spacing: 5,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Search",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          Icon(
                            Icons.search,
                            color: Colors.orangeAccent,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Display All Tasks : ",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      InkWell(
                        onTap: () async {
                          await TaskScreenController.resetList();
                          setState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white)),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text("Reset",
                                style: TextStyle(
                                    color: Colors.orangeAccent,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Sort By : ",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          Text(
                            TaskScreenController.sCondition,
                            style: TextStyle(
                                color: Colors.orangeAccent,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      InkWell(
                        onTap: () async {
                          await TaskScreenController.sortList();
                          setState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white)),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text("Sort",
                                style: TextStyle(
                                    color: Colors.orangeAccent,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Expanded(
                child: TaskScreenController.searchList.isNotEmpty
                    ? Container(
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: TaskScreenController.searchList.length,
                            itemBuilder: (context, index) {
                              String eval = TaskScreenController
                                  .searchList[index]["priority"];
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(
                                      colors: TaskScreenController
                                          .priorColorSelection(
                                              eval), //selecting color based on priority
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight),
                                ),
                                margin: EdgeInsets.all(10),
                                height: 100,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            TaskScreenController
                                                .searchList[index]["title"],
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                          Text(
                                            TaskScreenController
                                                .searchList[index]["date"],
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      )
                    : Container(
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
                              Icons.error_outline,
                              size: 50,
                            ),
                            Text(
                              "No Data Found",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ],
                        ),
                      ))
          ],
        ),
      ),
    );
  }
}
