import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        children: [
          _buildSectionHeader("App Information"),
          _buildInfoTile(
            title: "App Name",
            subtitle: "Health",
            icon: Icons.health_and_safety,
            iconColor: Colors.blueAccent,
          ),

          const SizedBox(height: 12,),
          _buildInfoTile(
            title: "Version",
            subtitle: "1.0.0",
            icon: Icons.info_outline,
            iconColor: Colors.greenAccent,
          ),

          const SizedBox(height: 32),

          _buildSectionHeader("Team", ),
          _buildInfoTile(
            title: "Developed by",
            subtitle: "Useless8000B",
            icon: Icons.group,
            iconColor: Colors.orangeAccent,
          ),
          const SizedBox(height: 32),

          _buildSectionHeader("Description", ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Text(
              "Health is designed to help you manage your health records efficiently, ensuring you and your loved ones are always up-to-date.",
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, left: 4),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildInfoTile( {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          _buildIconBubble(icon, iconColor),
          const SizedBox(width: 16),
          Expanded(child: _buildTileText(title, subtitle, )),
        ],
      ),
    );
  }

  Widget _buildIconBubble(IconData icon, Color color) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: color, size: 24),
    );
  }

  Widget _buildTileText(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}