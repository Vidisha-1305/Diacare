import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyScreen extends StatelessWidget {
  EmergencyScreen({super.key});

  final List<Map<String, String>> emergencyContacts = [
    {"name": "Doctor", "phone": "+911234567890"},
    {"name": "Family", "phone": "+919876543210"},
    {"name": "Friend", "phone": "+911112223334"},
  ];

  // ✅ Function to make a phone call
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri uri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Emergency"),
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 🚨 Big Emergency Call Button
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(vertical: 20),
              ),
              icon: const Icon(Icons.call, color: Colors.white, size: 28),
              label: const Text(
                "Call Emergency",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              onPressed: () => _makePhoneCall(emergencyContacts[0]["phone"]!),
            ),
            const SizedBox(height: 30),

            const Text(
              "Emergency Contacts",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // 📞 List of contacts
            Expanded(
              child: ListView.builder(
                itemCount: emergencyContacts.length,
                itemBuilder: (context, index) {
                  final contact = emergencyContacts[index];
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.person, color: Colors.blue),
                      title: Text(contact["name"]!),
                      subtitle: Text(contact["phone"]!),
                      trailing: IconButton(
                        icon: const Icon(Icons.call, color: Colors.green),
                        onPressed: () =>
                            _makePhoneCall(contact["phone"]!),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
