import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;

  const Footer({
    super.key,
    this.icon = Icons.close,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        BottomAppBar(
          color: Colors.black,
          shape: const CircularNotchedRectangle(),
          notchMargin: 8.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildFooterItem(context, Icons.home, "Home", '/'),
                _buildFooterItem(context, Icons.task, "Task List", '/taskList'),
                const SizedBox(width: 40),
                _buildFooterItem(
                    context, Icons.calendar_today, "Calendar", '/calendar'),
                _buildFooterItem(context, Icons.person, "Profile", '/profile'),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 30,
          child: InkWell(
            onTap: onPressed ?? () => Navigator.pushNamed(context, '/taskForm'),
            borderRadius: BorderRadius.circular(30),
            child: Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                color: Color(0xFF90B9A4),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5,
                    spreadRadius: 2,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Icon(icon, color: Colors.white, size: 30),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFooterItem(
      BuildContext context, IconData icon, String label, String route) {
    bool isActive = ModalRoute.of(context)?.settings.name == route;

    return GestureDetector(
      onTap: () {
        if (ModalRoute.of(context)?.settings.name != route) {
          Navigator.pushNamed(context, route);
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: isActive ? Colors.greenAccent : Colors.white),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.greenAccent : Colors.white,
              fontSize: 12,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
