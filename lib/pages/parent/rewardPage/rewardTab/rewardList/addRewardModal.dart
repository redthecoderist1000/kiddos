import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kiddos/components/Snackbar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddRewardModal extends StatefulWidget {
  const AddRewardModal({Key? key}) : super(key: key);

  @override
  State<AddRewardModal> createState() => _AddRewardModalState();
}

class _AddRewardModalState extends State<AddRewardModal> {
  final supabase = Supabase.instance.client;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController titleCon = TextEditingController();
  final TextEditingController descCon = TextEditingController();
  final TextEditingController pointsCon = TextEditingController();
  String selectedCategory = 'Treats';

  final List<String> categories = [
    'Privileges',
    'Toys',
    'Treats',
    'Activities',
    'Others',
  ];

  @override
  void dispose() {
    titleCon.dispose();
    descCon.dispose();
    pointsCon.dispose();
    super.dispose();
  }

  createReward() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final newReward = {
      'title': titleCon.text,
      'description': descCon.text == '' ? null : descCon.text,
      'points': int.tryParse(pointsCon.text),
      'category': selectedCategory,
    };
    try {
      await supabase.from('tbl_reward').insert({
        'item_name': newReward['title'],
        'description': newReward['description'],
        'required_points': newReward['points'],
        'category': newReward['category'],
      });
      context.pop();
      setSnackBar('Reward created successfully!', context, Colors.green);
    } catch (e) {
      print(e);
      context.pop();
      setSnackBar('Failed to create reward at this time.', context, Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.pink.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.card_giftcard,
              color: Colors.pink.shade400,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          const Text(
            'Create New Reward',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
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
            spacing: 10,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Reward Title ',
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
                        hintText: 'e.g. Ice cream treat',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                        errorStyle: TextStyle(color: Colors.red, fontSize: 12),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a reward title';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
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
                    child: TextFormField(
                      controller: descCon,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        hintText: 'Details about the reward...',
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

              // Point Cost and Category Row
              Row(
                children: [
                  // Point Cost
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Point Cost',
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
                              hintText: '50',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter point cost';
                              }

                              if (int.tryParse(value) == null) {
                                return 'Please enter a valid number';
                              }

                              if (int.parse(value) <= 0) {
                                return 'Point cost must be greater than zero';
                              }

                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 16),

                  // Category
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
                          padding: const EdgeInsets.symmetric(horizontal: 16),
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
                                  child: Text(category),
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
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          style: TextButton.styleFrom(
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
        ElevatedButton(
          onPressed: createReward,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.pink.shade400,
            padding: const EdgeInsets.all(13),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 0,
          ),
          child: const Text(
            'Create Reward',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
