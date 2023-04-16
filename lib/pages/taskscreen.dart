
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytest/models/User/User_model.dart';
import 'package:mytest/models/User/User_task_Model.dart';
import 'package:mytest/services/auth_service.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../services/collectionsrefrences.dart';
import '../controllers/topController.dart';
import '../controllers/userController.dart';
import '../controllers/user_task_controller.dart';
import '../models/task/UserTaskCategory_model.dart';
import 'add_user_task.dart';
import 'constants.dart';
import 'custom_widget/user_task_card.dart';

class Streamo extends StatelessWidget {
  const Streamo({super.key, required this.usercategory});
  final UserTaskCategoryModel usercategory;
  @override
  Widget build(BuildContext context) {
 final   TopController controller = Get.put(TopController());
final    UserController userController = Get.put(UserController());
    UserTaskController userTaskController = Get.put(UserTaskController());

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(20),
              height: 50,
              width: 200,
              child: TextButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(PColor)),
                  onPressed: () {
                    Get.to(AddNewTask(
                      category: usercategory,
                    ));
                  },
                  child: Row(
                    children: const [
                      Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      Text(
                        "add new task",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  )),
            ),
            Expanded(
              child: StreamBuilder(
                stream:
                    userTaskController.getCategoryTasksStream(usercategory.id),
                //   usersTasksRef.snapshots(),
                builder: (context, snapshot) {
                  return ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      if (snapshot.hasData) {
                        print(snapshot.data?.docs);
                        // UserTaskModel s =
                        //     snapshot.data?.docs[index].data() as UserTaskModel;
                        UserTaskModel s =
                            snapshot.data?.docs[index].data() as UserTaskModel;
                        return Slidable(
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (BuildContext context) {
                                  print(s.id);
                                  userTaskController.deleteUserTask(id: s.id);
                                },
                                backgroundColor: const Color(0xFFFE4A49),
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'Delete',
                              ),
                            ],
                          ),
                          child: UserTaskWidget(
                            task: s,
                          ),
                        );
                      }
                      return const CircularProgressIndicator();
                    },
                  );
                },
              ),
            ),
            // TextButton(
            //   onPressed: () async {
            //     // list.forEach((taskModel) {
            //     //   userTaskController.addTask(taskModel);
            //     // });
            //     // userTaskController.addTask(list[4]);
            //     print(firebaseAuth.currentUser!.uid);
            //     for (var element in listtask) {
            //       userTaskController.addTask(element);
            //     }
            //   },
            //   child: const Text("upload to firestore"),
            // ),
            // TextButton(
            //   onPressed: () async {
            //     // await userTaskController
            //     //     .getUserTasks(firebaseAuth.currentUser!.uid);
            //     // userController.getbyid(firebaseAuth.currentUser!.uid);
            //     //  await userTaskController.getbyid("IFDb7F1T3vmBCQK8PX2G");h
            //     // DocumentReference a =
            //     //     await usersTasksRef.doc("11ofjYhKHjlAH0FGPb9Y");

            //     // await userTaskController.getChildTasks(a);
            //     // List<UserTaskModel> list =
            //     //     await userTaskController.getCategoryTasks("folder1");
            //     await userController.addUserDoc(s);
            //   },
            //   child: const Text("get from firestore"),
            // ),
          ],
        ),
      ),
    );
  }
}

UserTaskModel ss = UserTaskModel(
  userIdParameter: firebaseAuth.currentUser!.uid,
  folderIdParameter: "folder1",
  taskFatherIdParameter: null,
  descriptionParameter: "oooooo",
  idParameter: usersTasksRef.doc().id,
  nameParameter: "oooooo",
  statusIdParameter: "in_progress",
  importanceParameter: 2,
  createdAtParameter: DateTime.now(),
  updatedAtParameter: DateTime.now().add(const Duration(days: 2)),
  startDateParameter: DateTime.now(),
  endDateParameter: DateTime.now().add(const Duration(days: 5)),
);

UserModel s = UserModel(
  nameParameter: "this is sparta",
  imageUrlParameter: "https://randomuser.me/api/portraits/women/19.jpg",
  tokenFcm: ["jHuGtRfEdCbAqZ"],
  idParameter: FirebaseAuth.instance.currentUser!.uid,
  createdAtParameter: DateTime.now(),
  updatedAtParameter: DateTime.now().add(const Duration(minutes: 4)),
  userNameParameter: "olivialee",
  emailParameter: FirebaseAuth.instance.currentUser!.email,
);
