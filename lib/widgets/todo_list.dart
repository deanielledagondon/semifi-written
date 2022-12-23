import 'package:flutter/material.dart';
import '../models/db.dart';
import './todo_card.dart';

class Todolist extends StatelessWidget {
  final Function insertTask;
  final Function deleteTask;
  final db = DatabaseConnect();

  Todolist({required this.insertTask, required this.deleteTask, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: db.getTodo(),
        initialData: [],
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          var data = snapshot.data;
          var datalength = data!.length;

          return datalength == 0
              ? const Center(
                  child: Text('no data found'),
                )
              : ListView.builder(
                  itemCount: datalength,
                  itemBuilder: (context, i) => TodoCard(
                    id: data[i].id,
                    title: data[i].title,
                    createdAt: data[i].createdAt,
                    isChecked: data[i].isChecked,
                    insert: insertTask,
                    delete: deleteTask,
                  ),
                );
        },
      ),
    );
  }
}
