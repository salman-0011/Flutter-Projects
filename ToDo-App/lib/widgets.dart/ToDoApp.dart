import 'package:flutter/material.dart';

class ToDoApp extends StatefulWidget {
  const ToDoApp({super.key});

  @override
  State<ToDoApp> createState() => _ToDoAppState();
}

class _ToDoAppState extends State<ToDoApp> {
  TextEditingController todoController = TextEditingController();
  @override
  void dispose() {
    todoController.dispose();
    super.dispose();
  }

  String content = "";
  List todoList = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              "ToDo App",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          backgroundColor: Colors.blueAccent,
        ),
        body: ListView.builder(
          padding: EdgeInsets.only(top: 10),

          itemCount: todoList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                title: Text(todoList[index], style: TextStyle(fontSize: 20)),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    setState(() {
                      todoList.removeAt(index);
                    });
                  },
                ),
                leading: Icon(
                  Icons.check_circle,
                  color: Colors.black,
                  size: 30,
                ),
                subtitle: Text(
                  "Tap to mark as done",
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
                onTap: () {
                  setState(() {
                    if (todoList[index].contains("(done)")) {
                      todoList[index] = todoList[index].replaceAll(
                        " (done)",
                        "",
                        AlertDialog(
                          title: Text("ToDo"),
                          content: Text("You have already done this task."),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("OK"),
                            ),
                          ],
                        ),
                      );
                    } else {
                      todoList[index] = todoList[index] + " (done)";
                    }
                  });
                },
                tileColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: EdgeInsets.all(10),
                selectedTileColor: Colors.greenAccent[100],
                selectedColor: Colors.black,
                selected: todoList[index].contains("(done)"),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Add ToDo"),
                  content: TextField(
                    controller: todoController,
                    onChanged: (value) {
                      setState(() {
                        content = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "Enter ToDo",
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        gapPadding: 4,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: Colors.blueAccent,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        todoList.add(content);

                        Navigator.of(context).pop();
                        todoController.clear();
                        setState(() {});
                      },
                      child: Text("Add"),
                    ),
                  ],
                );
              },
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
