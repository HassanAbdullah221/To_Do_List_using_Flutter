class ToDo {
  String? id;
  String? todotext;
  bool isDone;
  ToDo({
    required this.id,
    required this.todotext,
    this.isDone = false,
  });
  static List<ToDo> todoList() {
    return [
      ToDo(
        id: '01',
        todotext: 'GYM',
      ),
      ToDo(
        id: '02',
        todotext: 'Coding',
      ),
      ToDo(
        id: '03',
        todotext: 'Sleep',
      ),
      ToDo(
        id: '04',
        todotext: 'Play',
      ),
    ];
  }
}
