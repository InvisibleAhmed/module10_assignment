import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class ListItem {
  int id;
  String title;
  String description;

  ListItem({
    required this.id,
    required this.title,
    required this.description,
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<ListItem> items = [];
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("To-Do List"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(labelText: "Title"),
                  ),
                  SizedBox(height: 16), // Space before the "Add" button
                  TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(labelText: "Description"),
                  ),
                  SizedBox(height: 16), // Additional space
                  ElevatedButton(
                    onPressed: () {
                      _addItem();
                    },
                    child: Text("Add"),
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(items[index].title),
                    subtitle: Text(items[index].description),
                    trailing: Icon(Icons.arrow_forward),
                    onLongPress: () {
                      _showEditDeleteDialog(context, items[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addItem() {
    String title = titleController.text;
    String description = descriptionController.text;
    int id = items.length + 1;
    if (title.isNotEmpty) {
      setState(() {
        items.add(ListItem(id: id, title: title, description: description));
        titleController.clear();
        descriptionController.clear();
      });
    }
  }

  void _showEditDeleteDialog(BuildContext context, ListItem item) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit or Delete"),
          actions: [
            TextButton(
              child: Text("Edit"),
              onPressed: () {
                _showEditBottomSheet(context, item);
              },
            ),
            TextButton(
              child: Text("Delete"),
              onPressed: () {
                _deleteItem(item);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showEditBottomSheet(BuildContext context, ListItem item) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Text("Edit Item"),
              TextField(
                controller: TextEditingController(text: item.title),
                onChanged: (value) {
                  item.title = value;
                },
              ),
              TextField(
                controller: TextEditingController(text: item.description),
                onChanged: (value) {
                  item.description = value;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  _updateItem(item);
                  Navigator.of(context).pop();
                },
                child: Text("Save"),
              ),
            ],
          ),
        );
      },
    );
  }

  void _updateItem(ListItem item) {
    setState(() {
      // Implement your update logic here.
    });
  }

  void _deleteItem(ListItem item) {
    setState(() {
      items.remove(item);
    });
  }
}
