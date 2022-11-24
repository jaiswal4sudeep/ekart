import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';

Future<Position?> getCurrentLongLat() async {
  LocationPermission permission;
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.deniedForever ||
        permission == LocationPermission.denied) {
      Future.delayed(Duration.zero, () {
        Fluttertoast.showToast(
          msg: 'Loction access permission denied',
        );
      });
      return Future.value(null);
    }
  } else {
    return Geolocator.getCurrentPosition();
  }
  return Geolocator.getCurrentPosition();
}
