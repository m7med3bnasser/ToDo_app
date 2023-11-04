import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/UI/models/task_model.dart';
import 'package:todo/UI/shared/firebase/firebase_functions.dart';

class TaskItem extends StatelessWidget {
  TaskModel task;

  TaskItem({required this.task, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        child: Slidable(
          startActionPane: ActionPane(
            motion: DrawerMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {
                  FirebaseFunctions.deletTask(task.id);
                },
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14),
                  bottomLeft: Radius.circular(14),
                ),
                label: "Delete",
                icon: Icons.delete,
                backgroundColor: Colors.red,
              ),
              SlidableAction(
                onPressed: (context) {},
                label: "Edite",
                icon: Icons.edit,
                backgroundColor: Colors.blue,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Row(
              children: [
                Container(
                    height: 80,
                    width: 3,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(18))),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${task.title}"),
                    Text("${task.description}"),
                  ],
                ),
                Spacer(),
               task.isDone?
               Container(
                 padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                 decoration: BoxDecoration(
                     color: Colors.green,
                     borderRadius: BorderRadius.circular(8)),
                 child: Text("Done!",style: TextStyle(color: Colors.white),)
               )
                   :InkWell(
                  onTap: () {
                    task.isDone=true;
                    FirebaseFunctions.updateTask(task);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8)),
                    child: const Icon(
                      Icons.done,
                      color: Colors.white,
                    ),
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
