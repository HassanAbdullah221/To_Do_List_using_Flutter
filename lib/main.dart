import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:to_do_list/to_do.dart';
import 'package:to_do_list/to_do_item.dart';

void main() {
  runApp(const ToDoList());
}

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  final todoList = ToDo.todoList();
  final _controller = TextEditingController();
  List<ToDo> _foundToDo = [];

  @override
  void initState() {
    _foundToDo = todoList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blue[200],
        appBar: _buildAppBar(),
        body: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: Column(
            children: [
              searchbox(),
              Container(
                margin: const EdgeInsets.only(left: 25),
                alignment: Alignment.centerLeft,
                child: const Text(
                  'To Do List ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    fontFamily: '29LTAzer',
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView(
                  children: [
                    for (ToDo i in _foundToDo)
                      ToDoItem(
                        todo: i,
                        onToDoChange: _handleToDoChange,
                        onDeleteItem: _deleteToDoItem,
                      ),
                  ],
                ),
              ),
              addtask(),
            ],
          ),
        ),
      ),
    );
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDoItem(String id) {
    setState(() {
      todoList.removeWhere((item) => item.id == id);
    });
  }

  void _runFilter(String entered) {
    List<ToDo> results = [];
    if (entered.isEmpty) {
      results = todoList;
    } else {
      results = todoList
          .where((element) =>
              element.todotext!.toLowerCase().contains(entered.toLowerCase()))
          .toList();

      setState(() {
        _foundToDo = results;
      });
    }
  }

  void _addToDoItem(String todo) {
    setState(() {
      todoList.add(
        ToDo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todotext: todo,
        ),
      );
    });
    _controller.clear();
  }

  Widget searchbox() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.only(
              top: 10,
              bottom: 10,
            ),
            prefixIcon: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: Colors.grey,
              ),
            ),
            hintText: "Search",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            )),
      ),
    );
  }

  Widget addtask() {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 40,
        horizontal: 35,
      ),
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.only(
              top: 10,
              left: 20,
              bottom: 10,
            ),
            suffixIcon: IconButton(
              onPressed: () {
                _addToDoItem(_controller.text);
              },
              icon: const Icon(
                Icons.add,
                color: Colors.grey,
              ),
            ),
            hintText: "Add Task",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide.none,
            )),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.blueGrey[300],
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Icon(
            Icons.menu,
            size: 30,
          ),
          Text(
            "To Do List",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Icon(Icons.person),
        ],
      ),
    );
  }
}
