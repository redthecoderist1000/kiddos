import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kiddos/components/Snackbar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddTaskModal extends StatefulWidget {
  const AddTaskModal({Key? key}) : super(key: key);

  @override
  State<AddTaskModal> createState() => _AddTaskModalState();
}

class _AddTaskModalState extends State<AddTaskModal> {
  final supabase = Supabase.instance.client;
  final formKey = GlobalKey<FormState>();
  final TextEditingController titleCon = TextEditingController();
  final TextEditingController descCon = TextEditingController();
  final TextEditingController pointsCon = TextEditingController();

  String selectedCategory = 'Others';

  dynamic childrenOptions = [];
  List selectedChildren = [];

  // String? error;

  final List<String> categories = [
    'Cleaning',
    'Homework',
    'Chores',
    'Exercise',
    'Reading',
    'Others',
  ];

  fetchChildrenOptions() async {
    try {
      final res = await supabase.from('vw_getchild').select('*');
      setState(() {
        childrenOptions = res;
      });
    } catch (e) {
      context.pop();
      setSnackBar(
        'There seems to be a problem. Try again later.',
        context,
        Colors.red,
      );
    }
  }

  @override
  void initState() {
    super.initState();

    fetchChildrenOptions();
  }

  @override
  void dispose() {
    titleCon.dispose();
    descCon.dispose();
    pointsCon.dispose();
    super.dispose();
  }

  createTask() async {
    if (!formKey.currentState!.validate()) return;
    if (selectedChildren.isEmpty) return;

    try {
      final taskPayload = {
        'task_name': titleCon.text,
        'desc': descCon.text == '' ? null : descCon.text,
        'category': selectedCategory,
        'points': int.parse(pointsCon.text),
      };
      // print(taskPayload);
      // insert sa tasks table
      final newTask = await supabase
          .from('tbl_task')
          .insert(taskPayload)
          .select('id')
          .single();

      final task_tran_payload = [];

      for (var child in selectedChildren) {
        task_tran_payload.add({
          'task_id': newTask['id'],
          'child_id': child['user_id'],
          'status': 'Assigned',
        });
      }

      await supabase.from('tbl_task_transaction').insert(task_tran_payload);

      context.pop();
      setSnackBar('Task created successfully!', context, Colors.green);
    } catch (e) {
      context.pop();
      setSnackBar(
        'Failed to create task. Please try again.',
        context,
        Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    childrenDropdownItems() {
      List<DropdownMenuItem<String>> items = [];
      for (var data in childrenOptions) {
        items.add(
          DropdownMenuItem<String>(
            value: data['user_id'],
            child: Text(
              data['user_name'],
              style: TextStyle(color: Colors.black87),
            ),
          ),
        );
      }
      return items;
    }

    addToSelectedChildren(String childId) {
      final value = childrenOptions.firstWhere(
        (element) => element['user_id'] == childId,
      );

      if (!selectedChildren.contains(value)) {
        setState(() {
          selectedChildren.add(value);
        });
      }
    }

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.add, color: Colors.blue.shade400, size: 20),
          ),
          const SizedBox(width: 12),
          const Text(
            'Create New Task',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => context.pop(),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.close, color: Colors.grey.shade600, size: 16),
            ),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Task Title
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Task Title ',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: '*',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextFormField(
                      controller: titleCon,
                      decoration: const InputDecoration(
                        hintText: 'e.g. Clean bedroom',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a task title';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Description
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Description',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      controller: descCon,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        hintText: 'Details about the task...',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Assign to and Points Row
              Row(
                children: [
                  // Assign to
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Category',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: selectedCategory,
                              isExpanded: true,
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.grey.shade600,
                              ),
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 14,
                              ),
                              items: categories.map((String category) {
                                return DropdownMenuItem<String>(
                                  value: category,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 8,
                                        height: 8,
                                        decoration: BoxDecoration(
                                          color: _getCategoryColor(category),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(category),
                                    ],
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedCategory = newValue!;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 16),

                  // Points
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Points',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextFormField(
                            controller: pointsCon,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter points';
                              }
                              if (int.tryParse(value) == null) {
                                return 'Enter a valid number';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              //  assign to
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Assign to ',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: '*',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        hint: Text(
                          'Choose child',
                          style: TextStyle(color: Colors.grey),
                        ),
                        isExpanded: true,
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey.shade600,
                        ),
                        style: TextStyle(color: Colors.black87, fontSize: 14),
                        items: childrenDropdownItems(),
                        onChanged: (String? newValue) {
                          addToSelectedChildren(newValue!);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              selectedChildren.isEmpty
                  ? SizedBox()
                  : Text('Selected Children:'),
              Wrap(
                spacing: 8,
                children: selectedChildren.map<Widget>((child) {
                  return Chip(
                    label: Text(child['user_name']),
                    onDeleted: () {
                      setState(() {
                        selectedChildren.remove(child);
                      });
                    },
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            'Cancel',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ElevatedButton(
            onPressed: createTask,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              padding: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Create Task',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Cleaning':
        return Colors.red;
      case 'Homework':
        return Colors.blue;
      case 'Chores':
        return Colors.green;
      case 'Exercise':
        return Colors.orange;
      case 'Reading':
        return Colors.purple;
      case 'Others':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }
}
