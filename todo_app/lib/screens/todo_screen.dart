import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({Key? key}) : super(key: key);

  @override
  _ToDoScreenState createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen>
    with SingleTickerProviderStateMixin {
  List<String> _todos = [];
  List<String> _completed = [];
  String _newTodo = '';
  late TabController _tabController;
  bool _isAddingTodo = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabChange);
    _retrieveToDoLists(); // Retrieve stored lists on app launch
  }

  void _handleTabChange() {
    setState(() {
      _isAddingTodo = _tabController.index == 0;
    });
  }

  void _addToDo() {
    if (_newTodo.isNotEmpty) {
      setState(() {
        _todos.add(_newTodo);
        _newTodo = '';
        _storeToDoLists(); // Store updated lists
      });
    }
  }

  void _removeToDo(int index) {
    setState(() {
      _todos.removeAt(index);
      _storeToDoLists(); // Store updated lists
    });
  }

  void _editTodo(int index) {
    setState(() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          String updatedTodo = _todos[index];
          return AlertDialog(
            title: const Text('Edit Task'),
            content: TextField(
              onChanged: (value) {
                updatedTodo = value;
              },
              controller: TextEditingController(text: _todos[index]),
            ),
            actions: [
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Save'),
                onPressed: () {
                  setState(() {
                    _todos[index] = updatedTodo;
                    Navigator.of(context).pop();
                    _storeToDoLists(); // Store updated lists
                  });
                },
              ),
            ],
          );
        },
      );
    });
  }

  Future<void> _storeToDoLists() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('todos', _todos);
    await prefs.setStringList('completed', _completed);
  }

  Future<void> _retrieveToDoLists() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _todos = prefs.getStringList('todos') ?? [];
      _completed = prefs.getStringList('completed') ?? [];
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double textSize = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ToDo List',
          style: GoogleFonts.lato(
            fontWeight: FontWeight.bold,
            fontSize: 20 * textSize,
          ),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Ongoing'),
            Tab(text: 'Completed'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOngoingTab(),
          _buildCompletedTab(),
        ],
      ),
    );
  }

  Widget _buildOngoingTab() {
    return Scaffold(
      body: ListView.builder(
        itemCount: _todos.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(_todos[index]),
            onDismissed: (direction) {
              if (direction == DismissDirection.endToStart) {
                _removeToDo(index);
              } else if (direction == DismissDirection.startToEnd) {
                setState(() {
                  _completed.add(_todos[index]);
                  _todos.removeAt(index);
                  _storeToDoLists(); // Store updated lists
                });
              }
            },
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.endToStart) {
                return true;
              } else if (direction == DismissDirection.startToEnd) {
                return true;
              }
              return false;
            },
            background: Container(
              color: Colors.green,
              child: const Icon(Icons.check, color: Colors.white),
              alignment: Alignment.centerRight,
            ),
            secondaryBackground: Container(
              color: Colors.red,
              child: const Icon(Icons.delete, color: Colors.white),
              alignment: Alignment.centerLeft,
            ),
            child: Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
              decoration: BoxDecoration(
                border: Border.all(width: 1.5, color: Colors.grey),
              ),
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_todos[index]),
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.grey),
                      onPressed: () {
                        _editTodo(index);
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: _isAddingTodo
          ? FloatingActionButton(
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
                        decoration: const InputDecoration(
                          labelText: 'New Todo',
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: Theme.of(context).textTheme.headline6,
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
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

  Widget _buildCompletedTab() {
    return Scaffold(
      body: ListView.builder(
        itemCount: _completed.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
            decoration: BoxDecoration(
              border: Border.all(width: 1.5, color: Colors.grey),
            ),
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    _completed[index],
                    style: const TextStyle(
                      decoration: TextDecoration.lineThrough,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: _tabController.index == 1 && _completed.isNotEmpty
          ? FloatingActionButton(
              onPressed: () {
                setState(() {
                  _completed.clear();
                  _storeToDoLists(); // Store updated lists
                });
              },
              child: const Icon(Icons.clear),
            )
          : null,
    );
  }
}
