import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

openURLinWeb(
  String url,
) async {
  try {
    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication)) {
      await launchUrl(Uri.parse(url));
    }
  } catch (e) {
    Fluttertoast.showToast(msg: 'Something went wrong!');

    throw UnimplementedError();
  }
}
