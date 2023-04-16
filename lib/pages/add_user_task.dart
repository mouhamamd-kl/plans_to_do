import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mytest/controllers/categoryController.dart';
import 'package:mytest/services/collectionsrefrences.dart';
import 'package:mytest/controllers/user_task_controller.dart';
import 'package:mytest/models/User/User_task_Model.dart';
import 'package:mytest/services/auth_service.dart';


import '../models/task/UserTaskCategory_model.dart';

// ignore: must_be_immutable
class AddNewTask extends StatefulWidget {
  AddNewTask({Key? key, required this.category}) : super(key: key);
  TaskCategoryController controller = Get.put(TaskCategoryController());
  UserTaskController taskcontroller = Get.put(UserTaskController());

  UserTaskCategoryModel category;
  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  late final TextEditingController _desccontroller = TextEditingController();

  late TextEditingController _titlecontroller;
  late TextEditingController _datecontroller;
  late TextEditingController _startTime;
  late TextEditingController _endTime;
  DateTime selectedDate = DateTime.now();
  String categoryId = "Meeting";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titlecontroller = TextEditingController();
    _datecontroller = TextEditingController(
        text: DateFormat('EEE, MMM d, ' 'yy').format(selectedDate));
    _startTime = TextEditingController(
        text: DateFormat.jm().format(DateTime.now()));
    _endTime =  TextEditingController(
        text: DateFormat.jm().format(DateTime.now().add(
      const Duration(hours: 1),
    )));
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2005),
      lastDate: DateTime(2030),
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
        _datecontroller.text =
            DateFormat('EEE, MMM d, ' 'yy').format(selected);
      });
    }
  }

  _selectTime(BuildContext context, String timetype) async {
    final TimeOfDay? result =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (result != null) {
      setState(() {
        if (timetype == "StartTime") {
          _startTime.text = result.format(context);
        } else {
          _endTime.text = result.format(context);
        }
      });
    }
  }

  _SetCategory(String categoryId) {
    setState(() {
      categoryId = categoryId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Container(
          color: const Color.fromRGBO(130, 0, 255, 1),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.arrow_back,
                            size: 30, color: Colors.white),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      Text(
                        "Create New Task",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 20,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 10, bottom: 10),
                  child: TextFormField(
                    controller: _titlecontroller,
                    cursorColor: Colors.white,
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                    decoration: InputDecoration(
                      labelText: "Title",
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      fillColor: Colors.white,
                      labelStyle: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 10, bottom: 10),
                  child: TextFormField(
                    controller: _datecontroller,
                    cursorColor: Colors.white,
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: "Date",
                      suffixIcon: GestureDetector(
                        onTap: () {
                          _selectDate(context);
                        },
                        child: const Icon(
                          Icons.calendar_month_outlined,
                          color: Colors.white,
                        ),
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      fillColor: Colors.white,
                      labelStyle: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 40),
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:  BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: TextField(
                                readOnly: true,
                                controller: _startTime,
                                decoration: InputDecoration(
                                  labelText: "Date",
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      _selectTime(context, "StartTime");
                                    },
                                    child: const Icon(
                                      Icons.alarm,
                                      color: Colors.black26,
                                    ),
                                  ),
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black26),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black26),
                                  ),
                                  fillColor: Colors.black26,
                                  labelStyle: GoogleFonts.montserrat(
                                    color: Colors.black26,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: TextField(
                                readOnly: true,
                                controller: _endTime,
                                decoration: InputDecoration(
                                  labelText: "Date",
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      _selectTime(context, "EndTime");
                                    },
                                    child: const Icon(
                                      Icons.alarm,
                                      color: Colors.black26,
                                    ),
                                  ),
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black26),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black26),
                                  ),
                                  fillColor: Colors.black26,
                                  labelStyle: GoogleFonts.montserrat(
                                    color: Colors.black26,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 20),
                        child: TextFormField(
                          controller: _desccontroller,
                          keyboardType: TextInputType.multiline,
                          minLines: 1,
                          maxLines: 8,
                          cursorColor: Colors.black26,
                          style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                          decoration: InputDecoration(
                            labelText: "Description",
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black26),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black26),
                            ),
                            fillColor: Colors.black26,
                            labelStyle: GoogleFonts.montserrat(
                              color: Colors.black26,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      GestureDetector(
                        onTap: () {
                          UserTaskModel s = UserTaskModel(
                              userIdParameter: firebaseAuth.currentUser!.uid,
                              folderIdParameter: widget.category.id,
                              taskFatherIdParameter: null,
                              descriptionParameter: _desccontroller.text,
                              idParameter: usersTasksRef.doc().id,
                              nameParameter: _titlecontroller.text,
                              statusIdParameter: "ssssss",
                              importanceParameter: 3,
                              createdAtParameter: DateTime.now(),
                              updatedAtParameter: DateTime.now(),
                              startDateParameter: selectedDate,
                              endDateParameter:
                                  selectedDate.add(const Duration(days: 2)));
                          widget.taskcontroller.addUserTask(userTaskModel: s);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color.fromRGBO(130, 0, 255, 1),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Create Task",
                            style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Categorcard extends StatelessWidget {
  const Categorcard({
    Key? key,
    required  this.categoryText,
    required  this.isActive,
  }) : super(key: key);
  final String categoryText;
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: !isActive
              ? const Color.fromRGBO(221, 229, 249, 1)
              : const Color.fromRGBO(130, 0, 255, 1),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        child: Text(
          categoryText,
          style: GoogleFonts.montserrat(
            color: !isActive ? Colors.grey : Colors.white,
            fontSize: 12,
          ),
        ));
  }
}
