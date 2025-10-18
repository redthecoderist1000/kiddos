import 'package:flutter/material.dart';

class TaskTileP extends StatelessWidget {
  final String status; // "completed" or "needs_confirmation"
  final String category;
  final IconData categoryIcon;
  final String title;
  final String description;
  final String userName;
  final String userAvatarUrl;
  final int points;
  final String date;
  final VoidCallback? onConfirm;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const TaskTileP({
    Key? key,
    required this.status,
    required this.category,
    required this.categoryIcon,
    required this.title,
    required this.description,
    required this.userName,
    required this.userAvatarUrl,
    required this.points,
    required this.date,
    this.onConfirm,
    this.onEdit,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isCompleted = status == "completed";
    bool needsConfirmation = status == "needs_confirmation";
    final width = MediaQuery.of(context).size.width;

    // Responsive sizes
    double containerPadding = width < 400 ? 10 : width < 600 ? 12 : 16;
    double borderRadius = width < 400 ? 12 : 18;
    double statusFontSize = width < 400 ? 10 : 12;
    double categoryFontSize = width < 400 ? 10 : 12;
    double titleFontSize = width < 400 ? 15 : 18;
    double descFontSize = width < 400 ? 12 : 14;
    double userFontSize = width < 400 ? 12 : 14;
    double pointsFontSize = width < 400 ? 12 : 14;
    double dateFontSize = width < 400 ? 11 : 13;
    double iconSize = width < 400 ? 14 : 16;
    double starSize = width < 400 ? 16 : 18;
    double avatarRadius = width < 400 ? 12 : 14;
    double buttonFontSize = width < 400 ? 12 : 14;
    double buttonHeight = width < 400 ? 28 : 32;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
        padding: EdgeInsets.all(containerPadding),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row: left (status/category vertical), right (actions horizontal)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left side: status and category (vertical)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isCompleted)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Color(0xFF16C98D),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "COMPLETED",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: statusFontSize,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    if (needsConfirmation)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Color(0xFFEDF6FF),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "NEEDS CONFIRMATION",
                          style: TextStyle(
                            color: Color(0xFF2972FE),
                            fontSize: statusFontSize,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    SizedBox(height: 6),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Color(0xFFF6F9FF),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(categoryIcon, size: iconSize, color: Colors.black54),
                          SizedBox(width: 4),
                          Text(
                            category,
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: categoryFontSize,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Spacer(),
                // Right side: actions horizontal
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.black54, size: iconSize + 2),
                      onPressed: onEdit,
                      tooltip: "Edit",
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.redAccent, size: iconSize + 2),
                      onPressed: onDelete,
                      tooltip: "Delete",
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            // Title
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: titleFontSize,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 4),
            // Description
            Text(
              description,
              style: TextStyle(
                fontSize: descFontSize,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 14),
            // User, points, date
            Row(
              children: [
                CircleAvatar(
                  radius: avatarRadius,
                  backgroundColor: Colors.grey[200],
                  child: (userAvatarUrl.isNotEmpty && userAvatarUrl.startsWith('http'))
                      ? ClipOval(
                          child: Image.network(
                            userAvatarUrl,
                            width: avatarRadius * 2,
                            height: avatarRadius * 2,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              // Fallback to initial if image fails
                              return Center(
                                child: Text(
                                  userName.isNotEmpty ? userName[0].toUpperCase() : '',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: avatarRadius,
                                    color: Colors.black54,
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : Text(
                          userName.isNotEmpty ? userName[0].toUpperCase() : '',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: avatarRadius,
                            color: Colors.black54,
                          ),
                        ),
                ),
                SizedBox(width: 8),
                Text(
                  userName,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: userFontSize,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(width: 12),
                Icon(Icons.star, color: Color(0xFFFFA726), size: starSize),
                SizedBox(width: 2),
                Text(
                  "$points points",
                  style: TextStyle(
                    color: Color(0xFFFFA726),
                    fontWeight: FontWeight.w500,
                    fontSize: pointsFontSize,
                  ),
                ),
                SizedBox(width: 12),
                Icon(Icons.calendar_today, color: Colors.black38, size: iconSize),
                SizedBox(width: 2),
                Text(
                  date,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: dateFontSize,
                  ),
                ),
              ],
            ),
            // Confirm button at the bottom, full width
            if (needsConfirmation)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF16C98D),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    icon: Icon(Icons.check, size: iconSize + 2),
                    label: Text(
                      "Confirm",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: buttonFontSize + 2,
                      ),
                    ),
                    onPressed: onConfirm,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}