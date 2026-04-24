import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _faceIdEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        children: [
          _buildSectionHeader("Account"),
          _buildSettingsTile(
            title: "Profile Information",
            subtitle: "Name, Email, and Medical ID",
            icon: Icons.person_outline,
            iconColor: Colors.blueAccent,
          ),
          const SizedBox(height: 12),
          _buildSettingsTile(
            title: "Insurance Card",
            subtitle: "Digital copy of your health card",
            icon: Icons.badge_outlined,
            iconColor: Colors.orangeAccent,
          ),

          const SizedBox(height: 12),

          _buildToggleTile(
            title: "Biometric Login",
            subtitle: "Secure app with Face ID/Fingerprint",
            icon: Icons.fingerprint,
            iconColor: Colors.cyanAccent,
            value: _faceIdEnabled,
            onChanged: (val) => setState(() => _faceIdEnabled = val),
          ),

          const SizedBox(height: 32),
          _buildSectionHeader("Support"),
          _buildSettingsTile(
            title: "Help Center",
            subtitle: "FAQ and Contact Support",
            icon: Icons.help_outline,
            iconColor: Colors.greenAccent,
          ),
          const SizedBox(height: 12),
          _buildSettingsTile(
            title: "Privacy Policy",
            subtitle: "How we protect your medical data",
            icon: Icons.lock_outline,
            iconColor: Colors.grey,
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
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildSettingsTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Color(0xF724262C)),
      child: Row(
        children: [
          _buildIconBubble(icon, iconColor),
          const SizedBox(width: 16),
          Expanded(child: _buildTileText(title, subtitle)),
          Icon(Icons.arrow_forward_ios, size: 14),
        ],
      ),
    );
  }

  Widget _buildToggleTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xF724262C)
      ),
      child: Row(
        children: [
          _buildIconBubble(icon, iconColor),
          const SizedBox(width: 16),
          Expanded(child: _buildTileText(title, subtitle)),
          Switch(
            value: value,
            onChanged: onChanged,
            activeTrackColor: iconColor.withValues(alpha: 0.3),
            activeThumbColor: iconColor,
          ),
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
