import 'package:flutter/material.dart';
import 'package:task_app_medium/controller/task_screen_controller.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen(
      {super.key,
      this.isEdit = false,
      this.taskTitle,
      this.details,
      this.priority,
      this.category,
      this.date,
      this.taskId});

  final bool isEdit;
  final String? taskTitle;
  final String? details;
  final String? category;
  final String? priority;
  final String? date;
  final int? taskId;

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.isEdit) {
      titleController.text = widget.taskTitle ?? "";
      detailsController.text = widget.details ?? "";
      dateController.text = widget.date ?? "";
      TaskScreenController.onPrioritySelection(widget.priority);
      TaskScreenController.onCategorySelection(widget.category);
      setState(() {});
    } else {
      TaskScreenController.onPrioritySelection(null);
      TaskScreenController.onCategorySelection(null);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade600,
      appBar: AppBar(
        leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back, color: Colors.white)),
        backgroundColor: Colors.blueGrey,
        title: Text(
          widget.isEdit == true ? "Update" : "Add New",
          style: TextStyle(color: Colors.white),
        ),
      ),

      ///
      ///-------------------body----------------------------
      ///

      body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              spacing: 13,
              children: [
                ///
                ///-----------------Title---------------------------
                ///
                TextFormField(
                  controller: titleController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      hintText: "Enter Title",
                      hintStyle: TextStyle(color: Colors.white),
                      label:
                          Text("Title", style: TextStyle(color: Colors.white)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.horizontal(),
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.horizontal(),
                          borderSide:
                              BorderSide(color: Colors.lightGreenAccent)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.horizontal(),
                          borderSide: BorderSide(color: Colors.redAccent))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Title is required";
                    }
                    return null;
                  },
                ),

                ///
                ///-----------------Details---------------------------
                ///
                TextFormField(
                  controller: detailsController,
                  style: TextStyle(
                      color: Colors.white, overflow: TextOverflow.ellipsis),
                  minLines: 5,
                  maxLines: 15,
                  decoration: InputDecoration(
                      hintText: "Enter Details",
                      hintStyle: TextStyle(color: Colors.white),
                      label: Text(
                        "Details",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.horizontal(),
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.horizontal(),
                          borderSide:
                              BorderSide(color: Colors.lightGreenAccent)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.horizontal(),
                          borderSide: BorderSide(color: Colors.redAccent))),
                ),

                ///
                ///------------------Category Selection---------------------------
                ///
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.white),
                      color: Colors.grey.shade400),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: DropdownButton(
                        dropdownColor: Colors.grey.shade300,
                        isExpanded: true,
                        value: TaskScreenController.selectedCategory,
                        menuWidth: MediaQuery.sizeOf(context).width,
                        hint: Text(
                          "Select Category",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey.shade900),
                        ),
                        items: List.generate(
                            TaskScreenController.categories.length,
                            (index) => DropdownMenuItem(
                                value: TaskScreenController.categories[index],
                                child: Text(
                                    TaskScreenController.categories[index]))),
                        onChanged: (value) {
                          TaskScreenController.onCategorySelection(value);
                          setState(() {});
                        }),
                  ),
                ),

                ///
                ///------------------Priority Selecion----------------------------
                ///
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.white),
                      color: Colors.grey.shade400),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: DropdownButton(
                        dropdownColor: Colors.grey.shade300,
                        isExpanded: true,
                        value: TaskScreenController.selectedPriority,
                        menuWidth: MediaQuery.sizeOf(context).width,
                        hint: Text(
                          "Set Priority",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey.shade900),
                        ),
                        items: List.generate(
                            TaskScreenController.priorities.length,
                            (index) => DropdownMenuItem(
                                value: TaskScreenController.priorities[index],
                                child: Text(
                                    TaskScreenController.priorities[index]))),
                        onChanged: (value) {
                          TaskScreenController.onPrioritySelection(value);
                          setState(() {});
                        }),
                  ),
                ),

                ///
                ///-----------------Date Selection-------------------
                ///
                TextFormField(
                  controller: dateController,
                  readOnly: true,
                  onTap: () async {
                    dateController.text =
                        await TaskScreenController.onDateSelection(context);
                  },
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      label: Text(
                        "Select Date",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.horizontal(),
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.horizontal(),
                          borderSide:
                              BorderSide(color: Colors.lightGreenAccent)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.horizontal(),
                          borderSide: BorderSide(color: Colors.redAccent))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Date is required";
                    }
                    return null;
                  },
                ),

                ///
                ///---------------------Action Buttton---------------
                ///
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () async {
                    if (widget.isEdit) {
                      if (_formKey.currentState!.validate()) {
                        TaskScreenController.editTask(
                            taskId: int.parse(widget.taskId!.toString()),
                            title: titleController.text,
                            details: detailsController.text,
                            date: dateController.text);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Task Listed Successfully")),
                        );

                        Navigator.pop(context);
                      }
                    } else {
                      if (_formKey.currentState!.validate()) {
                        TaskScreenController.addTask(
                            title: titleController.text,
                            details: detailsController.text,
                            date: dateController.text);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Task Listed Successfully")),
                        );

                        Navigator.pop(context);
                      }
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.white),
                        color: Colors.blueGrey),
                    //margin: EdgeInsets.symmetric(horizontal: 50),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 80, vertical: 10),
                      child: Text(
                        "Confirm",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
