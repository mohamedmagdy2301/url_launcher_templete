import 'package:flutter/material.dart';
import 'package:url_launcher_templete/url_launcher_helper.dart';

class UrlLauncherHelperUI extends StatefulWidget {
  const UrlLauncherHelperUI({super.key});

  @override
  _UrlLauncherHelperUIState createState() => _UrlLauncherHelperUIState();
}

class _UrlLauncherHelperUIState extends State<UrlLauncherHelperUI> {
  final TextEditingController phoneController = TextEditingController();
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
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: 'Enter Phone Number',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final phone = phoneController.text.trim();
                if (phone.isNotEmpty) {
                  await UrlLauncherHelper.launchPhoneCall(phone);
                }
              },
              child: const Text('Make a Phone Call'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Enter Email Address',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final email = emailController.text.trim();
                if (email.isNotEmpty) {
                  await UrlLauncherHelper.composeEmail(
                    email,
                    'Subject: Example',
                    'Body: This is an example email.',
                  );
                }
              },
              child: const Text('Compose Email'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: websiteController,
              decoration: const InputDecoration(
                labelText: 'Enter Website URL',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.url,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final website = websiteController.text.trim();
                if (website.isNotEmpty) {
                  await UrlLauncherHelper.launchWebsite(website);
                }
              },
              child: const Text('Open Website'),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: latitudeController,
                    decoration: const InputDecoration(
                      labelText: 'Latitude',
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
                  await UrlLauncherHelper.openMaps(latitude, longitude);
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
