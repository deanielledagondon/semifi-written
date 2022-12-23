import 'package:flutter/material.dart';
import '../models/db_model.dart';
import '../models/todo_model.dart';
import '../widgets/user_input.dart';
import '../widgets/todo_list.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var db = DatabaseConnect();

  void addItem(TaskModel task) async {
    await db.addTodo(task);
    setState(() {});
  }

  void deleteItem(TaskModel task) async {
    await db.deleteTodo(task);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFF5EBFF),
      body: Column(
        children: [
          Todolist(insertTask: addItem, deleteTask: deleteItem),
          UserInput(insertData: addItem),
        ],
      ),
    );
  }
}
