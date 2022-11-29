import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:package_info_plus/package_info_plus.dart';

Future<bool> checkAppLatestVersion() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  int currentVersion = int.parse(packageInfo.buildNumber);

  FirebaseRemoteConfig? remoteConfig = FirebaseRemoteConfig.instance;
  await remoteConfig.fetch();
  await remoteConfig.activate();
  int latestVersion = remoteConfig.getInt('latestBuildCode');

  return latestVersion > currentVersion;
}
