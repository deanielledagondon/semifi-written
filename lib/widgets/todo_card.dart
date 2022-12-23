import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/todo_model.dart';

class TodoCard extends StatefulWidget {
  final int id;
  final String title;
  final DateTime creationDate;
  bool isChecked;
  final Function insert;
  final Function delete;

  TodoCard(
      {required this.id,
      required this.title,
      required this.creationDate,
      required this.isChecked,
      required this.insert,
      required this.delete,
      Key? key})
      : super(key: key);

  @override
  _TodoCardState createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  @override
  Widget build(BuildContext context) {
    var anotherTodo = TaskModel(
        id: widget.id,
        title: widget.title,
        creationDate: widget.creationDate,
        isChecked: widget.isChecked);
    //
    return Card(
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Checkbox(
              value: widget.isChecked,
              onChanged: (bool? value) {
                setState(() {
                  widget.isChecked = value!;
                });
                anotherTodo.isChecked = value!;
                widget.insert(anotherTodo);
              },
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  DateFormat('dd MMM yyyy - hh:mm aaa')
                      .format(widget.creationDate),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF8F8F8F),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              widget.delete(anotherTodo);
            },
            icon: const Icon(Icons.close),
          ),
        ],
      ),
    );
  }
}
