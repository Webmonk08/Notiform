import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class MakeSchedulePage extends StatefulWidget {
  const MakeSchedulePage({Key? key}) : super(key: key);

  @override
  _MakeSchedulePageState createState() => _MakeSchedulePageState();
}

class _MakeSchedulePageState extends State<MakeSchedulePage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  final Map<DateTime, List<Map<String, dynamic>>> _tasks = {}; // Stores task & completion status
  final TextEditingController _taskController = TextEditingController();

  void _addTask() {
    if (_taskController.text.isNotEmpty) {
      setState(() {
        if (_tasks[_selectedDay] == null) {
          _tasks[_selectedDay] = [];
        }
        _tasks[_selectedDay]!.add({"task": _taskController.text, "completed": false});
      });
      _taskController.clear();
    }
  }

  void _toggleTaskCompletion(int index) {
    setState(() {
      _tasks[_selectedDay]![index]["completed"] = !_tasks[_selectedDay]![index]["completed"];
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> tasks = _tasks[_selectedDay] ?? [];

    return Scaffold(
      appBar: AppBar(title: const Text("Make Schedule")),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2022, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _taskController,
              decoration: InputDecoration(
                labelText: "Add Task",
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _addTask,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView(
              children: [
                if (tasks.where((task) => !task["completed"]).isNotEmpty) ...[
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Pending Tasks", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  ...tasks.where((task) => !task["completed"]).map((task) {
                    int index = tasks.indexOf(task);
                    return ListTile(
                      title: Text(task["task"]),
                      leading: Checkbox(
                        value: task["completed"],
                        onChanged: (_) => _toggleTaskCompletion(index),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            tasks.removeAt(index);
                          });
                        },
                      ),
                    );
                  }).toList(),
                ],
                if (tasks.where((task) => task["completed"]).isNotEmpty) ...[
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Completed Tasks", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)),
                  ),
                  ...tasks.where((task) => task["completed"]).map((task) {
                    int index = tasks.indexOf(task);
                    return ListTile(
                      title: Text(task["task"], style: const TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey)),
                      leading: Checkbox(
                        value: task["completed"],
                        onChanged: (_) => _toggleTaskCompletion(index),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            tasks.removeAt(index);
                          });
                        },
                      ),
                    );
                  }).toList(),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

