import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

Future<List<double>> getCurrentLongLat() async {
  LocationPermission permission;
  permission = await Geolocator.checkPermission();
  double latitude = 0;
  double longitude = 0;
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      Fluttertoast.showToast(msg: 'Permission Denied');
    } else {
      var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      latitude = position.latitude;
      longitude = position.longitude;
      return [latitude, longitude];
    }
    return [latitude, longitude];
  } else {
    var position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    latitude = position.latitude;
    longitude = position.longitude;
    return [latitude, longitude];
  }
}

Future<List<String>> getCurrentAddress(
  double lat,
  double long,
) async {
  List<Placemark> newPlace = await placemarkFromCoordinates(lat, long);
  Placemark placeMark = newPlace[0];
  String addressCon = '${placeMark.street!}, ${placeMark.subLocality!}';
  String cityCon = placeMark.locality!;
  String stateCon = placeMark.administrativeArea!;
  String pinCodeCon = placeMark.postalCode!;
  return [addressCon, cityCon, stateCon, pinCodeCon];
}
