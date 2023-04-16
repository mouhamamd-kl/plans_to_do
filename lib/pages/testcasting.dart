import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytest/controllers/categoryController.dart';
import 'package:mytest/controllers/userController.dart';
import 'package:mytest/controllers/user_task_controller.dart';
import 'package:mytest/models/User/User_model.dart';
import 'package:mytest/models/task/UserTaskCategory_model.dart';
import 'package:mytest/models/team/Team_model.dart';
import 'package:mytest/models/tops/TopModel_model.dart';
import 'package:mytest/pages/user_home_page.dart';

import '../controllers/manger_controller.dart';
import '../controllers/projectController.dart';
import '../controllers/project_main_task_controller.dart';
import '../controllers/project_sub_task_controller.dart';
import '../controllers/teamController.dart';
import '../controllers/team_member_controller.dart';
import '../models/User/User_task_Model.dart';
import '../services/auth_service.dart';
import '../services/collectionsrefrences.dart';

class MyButtonScreen extends StatelessWidget {
  MyButtonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.put(UserController());
    TaskCategoryController categoryController =
        Get.put(TaskCategoryController());
    UserTaskController taskController = Get.put(UserTaskController());
    TeamController teamController = Get.put(TeamController());
    TeamMemberController memberController = Get.put(TeamMemberController());
    ProjectController projectController = Get.put(ProjectController());
    ProjectMainTaskController mainTaskController =
        Get.put(ProjectMainTaskController());
    ProjectSubTaskController subTaskController =
        Get.put(ProjectSubTaskController());
    ManagerController managerController = Get.put(ManagerController());
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text('My Button Screen'),
        actions: [
          IconButton(
            icon: const Icon(Icons.task),
            onPressed: () {
              // Do something when search button is pressed
              Get.to(const UserTaskCategoriesScreen());
            },
          ),
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              // Do something when menu button is pressed
            },
          ),
        ],
      ),
      body: Column(
        children: [
          ListView(
            scrollDirection: Axis.vertical,
            children: [
              const SizedBox(
                height: 10,
              ),
              TestButton(
                text: 'get all users',
                onPress: () async {
                  List<UserModel> list = await userController.getAllUsers();
                  printList(list: list, name: "users");
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TestButton(
                text: 'get all user categories',
                onPress: () async {
                  List<UserTaskCategoryModel> list = await categoryController
                      .getUserCategories(firebaseAuth.currentUser!.uid);
                  printList(list: list, name: "user categories");
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TestButton(
                text: 'get all user tasks',
                onPress: () async {
                  List<UserTaskModel> list = await taskController
                      .getUserTasks(firebaseAuth.currentUser!.uid);
                  printList(list: list, name: "user tasks");
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TestButton(
                text: 'get all category tasks',
                onPress: () async {
                  List<UserTaskModel> list = await taskController
                      .getCategoryTasks(folderId: "50Vke6B730ABg1Yg1WgV");
                  printList(list: list, name: "category tasks");
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TestButton(
                text: 'get user task by id',
                onPress: () async {
                  UserTaskModel userTaskModel = await taskController
                      .getUserTaskById(id: "cyqsVZcSJaLPBkNPuXwD");
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TestButton(
                text: 'get user task sons',
                onPress: () {
                  DocumentReference reference =
                      usersTasksRef.doc("cyqsVZcSJaLPBkNPuXwD");
                  taskController.getChildTasks(taskFatherId: reference);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TestButton(
                text: 'get task where',
                onPress: () {
                  DocumentReference reference =
                      usersTasksRef.doc("cyqsVZcSJaLPBkNPuXwD");
                  taskController.getChildTasks(taskFatherId: reference);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TestButton(
                text: 'get child tasks',
                onPress: () {
                  DocumentReference reference =
                      usersTasksRef.doc("cyqsVZcSJaLPBkNPuXwD");
                  taskController.getChildTasks(taskFatherId: reference);
                },
              ),
              TestButton(
                text: 'get all teams',
                onPress: () async {
                  List<TeamModel> list = await teamController.getAllTeams();
                },
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

printList<t extends TopModel>({required List<t> list, required String name}) {
  print(name);
  list.forEach((element) {
    print(element);
    print("////////////////////");
  });
}

printObject<t extends TopModel>({required t object, required String name}) {
  print(name);
  print(object.toString());
}

class TestButton extends StatelessWidget {
  TestButton({Key? key, required this.text, required this.onPress})
      : super(key: key);
  VoidCallback onPress;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 50,
      child: ElevatedButton(
        onPressed: onPress,
        child: Text(
          textAlign: TextAlign.center,
          text,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)),
          ),
        ),
      ),
    );
  }
}
