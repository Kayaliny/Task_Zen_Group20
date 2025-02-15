import 'package:flutter/material.dart';

class ProfileDetails extends StatelessWidget {
  const ProfileDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.all(
          16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildSectionTitle('Name'),
            _buildBorderedSection('Aisha Silva'),
            const SizedBox(height: 20),
            _buildSectionTitle('Email'),
            _buildBorderedSection('aisha24silva@gmail.com'),
            const SizedBox(height: 20),
            _buildSectionTitle('Phone'),
            _buildBorderedSection('+94 76 123 4567'),
            const SizedBox(height: 20),
            _buildSectionTitle('Location'),
            _buildBorderedSection(
              '703, Elhena Rd, Kolonnava',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 5,
        left: 2,
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildBorderedSection(String content) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 12,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black54,
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        content,
        style: const TextStyle(fontSize: 14, color: Colors.black54),
      ),
    );
  }
}
