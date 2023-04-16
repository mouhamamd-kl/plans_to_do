
// import 'package:firebase_auth/firebase_auth.dart';

// import 'package:flutter/material.dart';

// import 'package:get/instance_manager.dart';

// import 'package:mytest/controllers/topController.dart';
// import 'package:mytest/controllers/userController.dart';

// import 'package:mytest/pages/taskscreen.dart';
// import 'package:mytest/pages/test.dart';

// import '../controllers/user_task_controller.dart';


// class HomePage extends StatelessWidget {
//   HomePage({super.key});
//   void logOut() {
//     FirebaseAuth.instance.signOut();
//   }

//  final TextEditingController textcontroller = TextEditingController();
//   final user = FirebaseAuth.instance.currentUser!;

//   @override
//   Widget build(BuildContext context) {
//     TopController controller = Get.put(TopController());
//     UserController userController = Get.put(UserController());
//     UserTaskController userTaskController = Get.put(UserTaskController());
//     return Scaffold(
//       appBar: AppBar(actions: [
//         const Padding(
//           padding: EdgeInsets.only(top: 22),
//           child: Text(
//             'LogOut',
//             style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//           ),
//         ),
//         IconButton(onPressed: logOut, icon: const Icon(Icons.logout))
//       ]),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               "LOGGED IN!  ${user.email!}",
//               style: const TextStyle(fontSize: 20),
//             ),
//             TextButton(
//               onPressed: () {
//                 listtask.forEach((taskModel) {
//                   userTaskController.addUserTask(userTaskModel: taskModel);
//                 });
//                 // userTaskController.addTask(list[4]);
//               },
//               child: Text("upload to firestore"),
//             ),
//             TextButton(
//               onPressed: () async {
//                 // await userTaskController
//                 //     .getUserTasks(firebaseAuth.currentUser!.uid);
//                 // userController.getbyid(firebaseAuth.currentUser!.uid);
//                 //  await userTaskController.getbyid("IFDb7F1T3vmBCQK8PX2G");h
//                 // DocumentReference a =
//                 //     await usersTasksRef.doc("11ofjYhKHjlAH0FGPb9Y");

//                 // await userTaskController.getChildTasks(a);
//                 // List<UserTaskModel> list =
//                 //     await userTaskController.getCategoryTasks("folder1");
//                 await userController.createUser(s);
//                 print(listtask);
//               },
//               child: const Text("get from firestore"),
//             ),
//             TextFormField(
//               controller: textcontroller,
//             ),
//             TextButton(
//               onPressed: () async {
//                 print(textcontroller.text);
//                 (await userController.deleteUser(textcontroller.text));
//               },
//               child: const Text("delete from firestore"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
