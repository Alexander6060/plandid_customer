import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // Example preferences:
  DateTime? _weddingDate;
  String _location = 'Clayton, 3168';
  bool _notificationsEnabled = true;
  bool _locationSuggestions = true;

  Future<void> _pickWeddingDate() async {
    final now = DateTime.now();
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: _weddingDate ?? now,
      firstDate: now,
      lastDate: DateTime(now.year + 5),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            datePickerTheme: DatePickerThemeData(
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.grey[600],
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      setState(() {
        _weddingDate = selectedDate;
      });
    }
  }

  void _editLocation() async {
    // For demonstration: show an AlertDialog where user can edit location
    final controller = TextEditingController(text: _location);

    await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Edit Location'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(labelText: 'Location'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, null),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, controller.text.trim());
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    ).then((newLocation) {
      if (newLocation != null && newLocation.isNotEmpty) {
        setState(() {
          _location = newLocation;
        });
      }
    });
  }

  Widget _buildSettingsRow({
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 16)),
                  if (subtitle != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        subtitle,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 13,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            if (trailing != null) trailing,
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: const Divider(height: 1, thickness: 0.5),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dateText =
        _weddingDate == null
            ? 'Select'
            : DateFormat('MMM dd, yyyy').format(_weddingDate!);

    return Scaffold(
      appBar: AppBar(
        elevation: 0, // Keep it minimal
        backgroundColor: Colors.white,
        title: const Text('Settings', style: TextStyle(color: Colors.black)),
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          // Wedding Date
          _buildSettingsRow(
            title: 'Wedding Date',
            subtitle: dateText,
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: _pickWeddingDate,
          ),
          _buildDivider(),

          // Location
          _buildSettingsRow(
            title: 'Location',
            subtitle: _location.isEmpty ? 'Add Location' : _location,
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: _editLocation,
          ),
          _buildDivider(),

          // Notifications toggle
          _buildSettingsRow(
            title: 'Notifications',
            subtitle: 'Receive updates & reminders',
            trailing: Switch(
              activeColor: Colors.white,
              activeTrackColor: Colors.grey[800],
              inactiveThumbColor: Colors.grey[600],
              inactiveTrackColor: Colors.white,
              splashRadius: 0,
              value: _notificationsEnabled,
              onChanged: (bool value) {
                setState(() => _notificationsEnabled = value);
              },
            ),
          ),
          _buildDivider(),

          // Location-based suggestions toggle
          _buildSettingsRow(
            title: 'Location-based Suggestions',
            subtitle: 'Get vendor recommendations in your area',
            trailing: Switch(
              activeColor: Colors.white,
              activeTrackColor: Colors.grey[800],
              inactiveThumbColor: Colors.grey[600],
              inactiveTrackColor: Colors.white,
              splashRadius: 0,
              value: _locationSuggestions,
              onChanged: (bool value) {
                setState(() => _locationSuggestions = value);
              },
            ),
          ),
          _buildDivider(),

          // Account / Profile
          _buildSettingsRow(
            title: 'Edit Profile',
            subtitle: 'Update your name, photo, and bio',
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Navigate to an edit-profile page or open a bottom sheet
            },
          ),
          _buildDivider(),

          // Some extra space
          const SizedBox(height: 30),

          // Logout (or any other CTA)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              onPressed: () {
                // Handle logout
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text(
                'Log Out',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
