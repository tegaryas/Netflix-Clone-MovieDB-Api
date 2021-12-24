import 'package:url_launcher/url_launcher.dart';

class Helper {
  static String convertHoursMinutes(int minutes) {
    Duration d = Duration(minutes: minutes);
    List<String> parts = d.toString().split(':');
    return '${parts[0]} Jam ${parts[1]} Menit';
  }

  static Future<void> launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
