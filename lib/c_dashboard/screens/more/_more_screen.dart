import 'package:ekart/b_authentication/authentication_controller.dart';
import 'package:ekart/c_dashboard/screens/more/a_more_screen_data.dart';
import 'package:ekart/utils/app_constant.dart';
import 'package:ekart/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MoreScreen extends HookWidget {
  const MoreScreen({
    super.key,
    required this.email,
  });

  final String email;

  @override
  Widget build(BuildContext context) {
    final isAuthActive = useState<bool>(false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('More'),
        leading: const BackScreenButton(),
      ),
      body: StreamBuilder<Object>(
        stream: fireRef.collection('user').doc(email).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: LoadingAnimationWidget.dotsTriangle(
                color: AppConstant.titlecolor,
                size: 40.sp,
              ),
            );
          } else if (snapshot.hasData) {
            return MoreScreenData(
              userData: snapshot.data,
              email: email,
              isAuthActive: isAuthActive,
            );
          } else {
            return const Text('An error occured');
          }
        },
      ),
    );
  }
}
