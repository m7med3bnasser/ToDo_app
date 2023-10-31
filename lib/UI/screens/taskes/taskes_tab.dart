import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo/UI/screens/taskes/task_item.dart';
import 'package:todo/UI/styels/my_theme.dart';
class TaskesTab extends StatelessWidget {
  const TaskesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        
        CalendarTimeline(
          initialDate: DateTime.now(),
          firstDate: DateTime.now().subtract(Duration(days: 365)),
          lastDate: DateTime.now().add(Duration(days: 365)),
          onDateSelected: (date) => print(date),
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
        Expanded(
          child: ListView.builder(itemBuilder: (context,index){
            return TaskItem();
          },itemCount: 8,),
        )

      ],
    );
  }
}
