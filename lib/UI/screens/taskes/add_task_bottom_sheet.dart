import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/UI/models/task_model.dart';
import 'package:todo/UI/shared/firebase/firebase_functions.dart';

class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var titleController = TextEditingController();

  var descriptionController = TextEditingController();

  var selectedDate = DateTime.now();
  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Form(
        key:formKey ,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Add NEW Task",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: titleController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Title cannot be empty";
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                  label: Text("Task Title"),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.blue)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.blue))),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: descriptionController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "description cannot be empty";
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                  label: Text("Task Description"),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.blue)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.blue))),
            ),
            Text("Select Date",
                textAlign: TextAlign.start,
                style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.black)),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                selectDate(context);
              },
              child: Text(selectDate.toString().substring(0, 10),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                      color: Colors.blue)),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {

                  if(formKey.currentState!.validate()){
                    TaskModel taskmodel = TaskModel(
                      title: titleController.text,
                      description: descriptionController.text,
                      date: DateUtils.dateOnly(selectedDate).millisecondsSinceEpoch,
                    );
                    FirebaseFunctions.addTask(taskmodel).then((value) {
                      Navigator.pop(context);
                    });
                  }

                },
                child: Text("Add Task"))
          ],
        ),
      ),
    );
  }

  void selectDate(BuildContext context) async {
    DateTime? chossenDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (chossenDate != null) {
      selectedDate = chossenDate;
    } else {
      return;
    }
    setState(() {});
  }
}
