import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo/UI/models/task_model.dart';
import 'package:todo/UI/screens/taskes/task_item.dart';
import 'package:todo/UI/shared/firebase/firebase_functions.dart';
import 'package:todo/UI/styels/my_theme.dart';

class TaskesTab extends StatefulWidget {
  const TaskesTab({super.key});

  @override
  State<TaskesTab> createState() => _TaskesTabState();
}

class _TaskesTabState extends State<TaskesTab> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CalendarTimeline(
          initialDate: selectedDate,
          firstDate: DateTime.now().subtract(Duration(days: 365)),
          lastDate: DateTime.now().add(Duration(days: 365)),
          onDateSelected: (date) {
            setState(() {
              selectedDate = date;
            });
          },
          leftMargin: 20,
          showYears: false,
          monthColor: Colors.blue,
          dayColor: Colors.blue.withOpacity(0.70),
          activeDayColor: Colors.white,
          activeBackgroundDayColor: Colors.blue,
          dotsColor: Colors.white,
          selectableDayPredicate: (date) => true,
          locale: 'en_ISO',
        ),
        StreamBuilder(
          stream: FirebaseFunctions.getTaskes(selectedDate),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text("Something went error"));
            }
            List<TaskModel> tasks =
                snapshot.data?.docs.map((e) => e.data()).toList() ?? [];
            return Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return TaskItem(
                    task: tasks[index],
                  );
                },
                itemCount: tasks.length,
              ),
            );
          },
        )
      ],
    );
  }
}
