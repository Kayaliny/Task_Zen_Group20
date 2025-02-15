import 'package:flutter/material.dart';
import '/widgets/profile_icon.dart';
import '/widgets/toggle_button.dart';
import '/widgets/footer.dart';
import '/widgets/profile_details.dart';
import '/widgets/setting.dart';

class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({super.key});

  @override
  _PersonalInfoPageState createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  int _selectedIndex = 0;

  void _onButtonPressed(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
        centerTitle: true,
        actions: [
          PopupMenuButton<int>(
            icon: const Icon(Icons.more_vert), // Three-dot menu icon
            onSelected: (value) {
              // Add menu functionality here if needed
            },
            itemBuilder: (context) => [], // Empty menu for now
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Center(
              child: ProfileIcon(
                imageUrl: "assets/images/profile.png",
                name: "Aisha Silva",
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: ToggleButton(
                selectedIndex: _selectedIndex,
                onButtonPressed: _onButtonPressed,
              ),
            ),
            const SizedBox(height: 20),
            _selectedIndex == 0 ? const ProfileDetails() : const SettingsPage(),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}
