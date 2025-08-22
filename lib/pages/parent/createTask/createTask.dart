import 'package:flutter/material.dart';
import '../../../db/task_database_helper.dart';
import '../../../models/task.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({super.key});

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  String category = 'cleaning';
  int points = 10;
  String assignedTo = '';
  DateTime dueDate = DateTime.now();

  Future<void> _saveTask() async {
    final task = Task(
      title: title,
      description: description,
      category: category,
      points: points,
      assignedTo: assignedTo,
      dueDate: "${dueDate.year}-${dueDate.month}-${dueDate.day}",
    );
    await TaskDatabaseHelper().insertTask(task);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Container(
        width: 340,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Icon(Icons.add, color: Colors.blue, size: 18),
                  SizedBox(width: 6),
                  Text(
                    "Create New Task",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Task Title",
                  hintText: "e.g., Clean bedroom",
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                ),
                style: TextStyle(fontSize: 13),
                validator: (val) => val == null || val.isEmpty ? "Required" : null,
                onChanged: (val) => setState(() => title = val),
              ),
              SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Description",
                  hintText: "Details about the task...",
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                ),
                style: TextStyle(fontSize: 13),
                onChanged: (val) => setState(() => description = val),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: "Assign to",
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                      ),
                      style: TextStyle(fontSize: 13),
                      value: assignedTo.isEmpty ? null : assignedTo,
                      items: [
                        DropdownMenuItem(value: "child1", child: Text("Child 1", style: TextStyle(fontSize: 13))),
                        DropdownMenuItem(value: "child2", child: Text("Child 2", style: TextStyle(fontSize: 13))),
                      ],
                      onChanged: (val) => setState(() => assignedTo = val ?? ""),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Points",
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                      ),
                      style: TextStyle(fontSize: 13),
                      keyboardType: TextInputType.number,
                      initialValue: points.toString(),
                      onChanged: (val) => setState(() => points = int.tryParse(val) ?? 10),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    flex: 2, // Make Category field wider
                    child: DropdownButtonFormField<String>(
                      value: category,
                      decoration: InputDecoration(
                        labelText: "Category",
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                      ),
                      style: TextStyle(fontSize: 13, color: Colors.black), // Set text color to black
                      dropdownColor: Colors.white, // Ensure dropdown background is white
                      items: [
                        {'value': 'cleaning', 'emoji': '🧹', 'label': 'Cleaning'},
                        {'value': 'personal', 'emoji': '🧴', 'label': 'Personal Care'},
                        {'value': 'learning', 'emoji': '📚', 'label': 'Learning'},
                        {'value': 'helping', 'emoji': '🤝', 'label': 'Helping'},
                      ].map((cat) => DropdownMenuItem(
                        value: cat['value'] as String,
                        child: Row(
                          children: [
                            Text(cat['emoji'] as String, style: TextStyle(fontSize: 16)),
                            SizedBox(width: 6),
                            Text(
                              cat['label'] as String,
                              style: TextStyle(fontSize: 13, color: Colors.black), // Ensure label is black
                            ),
                          ],
                        ),
                      )).toList(),
                      onChanged: (val) => setState(() => category = val ?? "cleaning"),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Due Date",
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                ),
                style: TextStyle(fontSize: 13),
                readOnly: true,
                controller: TextEditingController(
                  text: "${dueDate.year}-${dueDate.month}-${dueDate.day}",
                ),
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: dueDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) setState(() => dueDate = picked);
                },
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text("Cancel", style: TextStyle(fontSize: 13)),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF6A5AE0), Color(0xFF8D5AE0)],
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          padding: EdgeInsets.symmetric(vertical: 10),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await _saveTask();
                          }
                        },
                        child: Text("Create Task", style: TextStyle(fontSize: 13)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}