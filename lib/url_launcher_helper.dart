import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherHelper {
  // WhatsApp launcher
  static Future<void> launchWhatsApp(String phoneNumber) async {
    final Uri uri = Uri.parse('https://wa.me/$phoneNumber');
    await _launchUri(uri);
  }

  // Phone call launcher
  static Future<void> launchPhoneCall(String phoneNumber) async {
    final Uri uri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await _launchUri(uri);
  }

  // Email launcher (simple)
  static Future<void> launchEmail(String emailAddress) async {
    final Uri uri = Uri(
      scheme: 'mailto',
      path: emailAddress,
    );
    await _launchUri(uri);
  }

  // Email launcher (with subject and body)
  static Future<void> composeEmail(
      String emailAddress, String subject, String body) async {
    final Uri uri = Uri(
      scheme: 'mailto',
      path: emailAddress,
      queryParameters: {
        'subject': subject,
        'body': body,
      },
    );
    await _launchUri(uri);
  }

  // SMS launcher
  static Future<void> sendSms(String phoneNumber, {String? message}) async {
    final Uri uri = Uri(
      scheme: 'sms',
      path: phoneNumber,
      queryParameters: message != null ? {'body': message} : null,
    );
    await _launchUri(uri);
  }

  // Website launcher
  static Future<void> launchWebsite(String websiteUrl) async {
    final Uri uri = Uri.parse(websiteUrl);
    await _launchUri(uri);
  }

  // Open Maps with latitude and longitude
  static Future<void> openMaps(double latitude, double longitude) async {
    final Uri uri = Platform.isIOS
        ? Uri(
            scheme: 'https',
            host: 'maps.apple.com',
            path: 'maps',
            queryParameters: {'q': '$latitude,$longitude'},
          )
        : Uri(
            scheme: 'https',
            host: 'www.google.com',
            path: 'maps/search/',
            queryParameters: {'api': '1', 'query': '$latitude,$longitude'},
          );
    await _launchUri(uri);
  }

  // Open directions in Maps (from and to locations)
  static Future<void> getDirections({
    required double startLatitude,
    required double startLongitude,
    required double endLatitude,
    required double endLongitude,
  }) async {
    final Uri uri = Platform.isIOS
        ? Uri(
            scheme: 'https',
            host: 'maps.apple.com',
            path: 'maps',
            queryParameters: {
              'saddr': '$startLatitude,$startLongitude',
              'daddr': '$endLatitude,$endLongitude',
            },
          )
        : Uri(
            scheme: 'https',
            host: 'www.google.com',
            path: 'maps/dir/',
            queryParameters: {
              'api': '1',
              'origin': '$startLatitude,$startLongitude',
              'destination': '$endLatitude,$endLongitude',
            },
          );
    await _launchUri(uri);
  }

  // Open YouTube video
  static Future<void> openYouTubeVideo(String videoId) async {
    final Uri uri = Uri(
      scheme: 'https',
      host: 'www.youtube.com',
      path: 'watch',
      queryParameters: {'v': videoId},
    );
    await _launchUri(uri);
  }

  // General method to launch a URI
  static Future<void> _launchUri(Uri uri) async {
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw Exception('Could not launch $uri');
    }
  }
}
