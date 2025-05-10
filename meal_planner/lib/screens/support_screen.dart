import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  Future<void> _callPhoneNumber() async {
    final Uri url = Uri.parse("tel:0530615014");
    if (!await launchUrl(url)) {
      throw Exception("Could not launch $url");
    }
  }

  Future<void> _openWhatsApp() async {
    final Uri url = Uri.parse("https://wa.me/966530615014");
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception("Could not launch $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Support"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            "Need help? Contact us via phone or WhatsApp.",
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
          const SizedBox(height: 30),

          // Phone Call
          ListTile(
            leading: const Icon(Icons.call, color: Color(0xFF8649FF)),
            title: const Text("Call Us"),
            subtitle: const Text("0530615014"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: _callPhoneNumber,
          ),

          // WhatsApp
          ListTile(
            leading: const Icon(Icons.chat, color: Color(0xFF8649FF)),
            title: const Text("WhatsApp"),
            subtitle: const Text("Chat with us directly"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: _openWhatsApp,
          ),
        ],
      ),
    );
  }
}
