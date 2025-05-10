import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meal_planner/screens/support_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Profile Info
          Row(
            children: const [
              CircleAvatar(
                backgroundImage: AssetImage("assets/images/profile.webp"),
                radius: 30,
              ),
              SizedBox(width: 16),
              Text(
                "Hello, Rebecca",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 30),

          // Settings Options
          _buildSettingItem(
            icon: Icons.person_outline,
            title: "Account",
            subtitle: "Profile, password, etc.",
            onTap: () {},
          ),
          _buildSettingItem(
            icon: Icons.notifications_none,
            title: "Notifications",
            subtitle: "Meal reminders & updates",
            onTap: () {},
          ),
          _buildSettingItem(
            icon: Icons.palette_outlined,
            title: "Appearance",
            subtitle: "Theme, font size",
            onTap: () {},
          ),
          _buildSettingItem(
            icon: Icons.privacy_tip_outlined,
            title: "Privacy & Security",
            subtitle: "Permissions, password",
            onTap: () {},
          ),

          // Support Page
          _buildSettingItem(
            icon: Icons.support_agent,
            title: "Support",
            subtitle: "FAQ, contact us",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SupportScreen(),
                ),
              );
            },
          ),

          // Log Out with AlertDialog and Toast
          _buildSettingItem(
            icon: Icons.logout,
            title: "Log Out",
            subtitle: "Sign out of your account",
            iconColor: Colors.red,
            titleColor: Colors.red,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Confirm Logout"),
                  content: const Text("Are you sure you want to log out?"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Fluttertoast.showToast(
                          msg: "Logged out successfully",
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          gravity: ToastGravity.BOTTOM,
                        );
                      },
                      child: const Text("Log Out"),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required String subtitle,
    Color iconColor = const Color(0xFF8649FF),
    Color titleColor = Colors.black,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
          color: titleColor,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(color: Colors.grey),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      contentPadding: const EdgeInsets.symmetric(vertical: 8),
      onTap: onTap,
    );
  }
}
