import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class toDoScreen extends StatefulWidget {
  const toDoScreen({super.key});

  @override
  State<toDoScreen> createState() => _toDoScreenState();
}

class _toDoScreenState extends State<toDoScreen> {
  List<String> _todos = [];
  List<String> _completed = [];
  String _newTodo = '';

  void _addToDo() {
    if (_newTodo.isNotEmpty) {
      setState(() {
        _todos.add(_newTodo);
        _newTodo = '';
      });
    }
  }

  void _removeToDo(int index) {
    setState(() {
      _todos.removeAt(index);
    });
  }

  void _editTodo(int index) {
    setState(() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          String updatedTodo = _todos[index];
          return AlertDialog(
            title: Text('Edit Task'),
            content: TextField(
              onChanged: (value) {
                updatedTodo = value;
              },
              controller: TextEditingController(text: _todos[index]),
            ),
            actions: [
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Save'),
                onPressed: () {
                  setState(() {
                    _todos[index] = updatedTodo;
                    Navigator.of(context).pop();
                  });
                },
              ),
            ],
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    //Adapting Mobile Screen Aspect Ratio - we use MediaQuery
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double textSize = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ToDo List',
          style: GoogleFonts.lato(
              fontWeight: FontWeight.bold, fontSize: 20 * textSize),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(15, 0, 15, 15),
              height: height / 2.5,
              width: width,
              child: ListView.builder(
                itemCount: _todos.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(_todos[index]),
                    onDismissed: (direction) {
                      _removeToDo(index);
                    },
                    background: Container(
                      color: Colors.green,
                      child: Icon(Icons.check, color: Colors.white),
                      alignment: Alignment.centerRight,
                    ),
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1.5, color: Colors.grey)),
                      child: ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(_todos[index]),
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.black),
                              onPressed: () {
                                _editTodo(index);
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Add new task'),
                content: TextField(
                  onChanged: (value) {
                    setState(() {
                      _newTodo = value;
                    });
                  },
                  onSubmitted: (value) {
                    _addToDo();
                  },
                  decoration: InputDecoration(
                    labelText: 'New Todo',
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                    child: const Text('Ok'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      _addToDo();
                    },
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
