import 'package:flutter/material.dart';
import 'package:url_launcher_templete/url_launcher_helper.dart';

class UrlLauncherUI extends StatefulWidget {
  const UrlLauncherUI({super.key});

  @override
  _UrlLauncherUIState createState() => _UrlLauncherUIState();
}

class _UrlLauncherUIState extends State<UrlLauncherUI> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController phoneControllerSms = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController longitudeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Url Launcher Example'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Phone Number Input Field with Hint Text
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: 'Enter Phone Number',
                hintText: 'e.g. 01015415210',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final phone = phoneController.text.trim();
                if (phone.isNotEmpty) {
                  await UrlLauncherHelper.launchPhoneCall(context, phone);
                }
              },
              child: const Text('Make a Phone Call'),
            ),
            const SizedBox(height: 16),

            // Email Input Field with Hint Text
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Enter Email Address',
                hintText: 'e.g. example@example.com',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final email = emailController.text.trim();
                if (email.isNotEmpty) {
                  await UrlLauncherHelper.launchEmail(context, email);
                }
              },
              child: const Text('Send Email'),
            ),
            const SizedBox(height: 16),

            // Website Input Field with Hint Text
            TextField(
              controller: websiteController,
              decoration: const InputDecoration(
                labelText: 'Enter Website URL',
                hintText: 'e.g. https://www.example.com',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.url,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final website = websiteController.text.trim();
                if (website.isNotEmpty) {
                  await UrlLauncherHelper.launchWebsite(context, website);
                }
              },
              child: const Text('Open Website'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: phoneControllerSms,
              decoration: const InputDecoration(
                labelText: 'Enter Phone Number',
                hintText: 'e.g. 01015415210',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 6),
            // SMS Message Input Fields
            TextField(
              controller: messageController,
              decoration: const InputDecoration(
                labelText: 'Enter SMS Meaasge',
                hintText: 'Type your message here...',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final phone = "+2${phoneControllerSms.text.trim()}";
                final message = messageController.text.trim();
                if (phone.isNotEmpty && message.isNotEmpty) {
                  await UrlLauncherHelper.sendSms(
                    context,
                    phone,
                    message: message,
                  );
                }
              },
              child: const Text('Send SMS'),
            ),
            const SizedBox(height: 16),
            // Latitude and Longitude Input Fields
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: latitudeController,
                    decoration: const InputDecoration(
                      labelText: 'Latitude',
                      hintText: 'e.g. 37.7749',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: longitudeController,
                    decoration: const InputDecoration(
                      labelText: 'Longitude',
                      hintText: 'e.g. -122.4194',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final latitude =
                    double.tryParse(latitudeController.text.trim());
                final longitude =
                    double.tryParse(longitudeController.text.trim());
                if (latitude != null && longitude != null) {
                  await UrlLauncherHelper.openMaps(
                      context, latitude, longitude);
                }
              },
              child: const Text('Open Maps'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    phoneController.dispose();
    emailController.dispose();
    websiteController.dispose();
    messageController.dispose();
    latitudeController.dispose();
    longitudeController.dispose();
    super.dispose();
  }
}
