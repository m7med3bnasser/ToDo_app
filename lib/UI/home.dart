import 'package:flutter/material.dart';
import 'package:todo/UI/screens/settings/settings_tab.dart';
import 'package:todo/UI/screens/taskes/add_task_bottom_sheet.dart';
import 'package:todo/UI/screens/taskes/taskes_tab.dart';

class HomeScreen extends StatefulWidget {
  static const String routename1 = "home";

  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  List<Widget> tabs = [TaskesTab(), SettingsTab()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text("ToDo"),
        elevation: 0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showSheet();
        },
        child: Icon(Icons.add),
        shape: CircleBorder(
            side: BorderSide(
          color: Colors.white,
          width: 3.0,
        )),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        notchMargin: 8,
        shape: CircularNotchedRectangle(),
        child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            onTap: (value) {
              index = value;
              setState(() {});
            },
            currentIndex: index,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.list), label: ""),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: ""),
            ]),
      ),
      body: tabs[index],
    );
  }

  void showSheet() {
    showModalBottomSheet(
      backgroundColor:  Color(0xFFDEECDA),
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding:  EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom
          ),
          child: AddTaskBottomSheet(),
        );
      },
    );
  }
}
