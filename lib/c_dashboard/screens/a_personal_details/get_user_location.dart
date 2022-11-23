import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
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
    Future.delayed(Duration.zero, () {
      Fluttertoast.showToast(
        msg:
            'An error occured, Please make sure the Location service is turned on',
      );
    });
    return Future.value(null);
  }
  return Geolocator.getCurrentPosition();
}

Future<Placemark> getCurrentAddress(
  double lat,
  double long,
) async {
  List<Placemark> newPlace = await placemarkFromCoordinates(lat, long);
  return newPlace[0];
}
