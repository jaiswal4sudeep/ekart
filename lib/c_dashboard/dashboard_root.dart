import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ekart/c_dashboard/a_home/home_body.dart';
import 'package:ekart/c_dashboard/screens/more/_more_screen.dart';
import 'package:ekart/c_dashboard/screens/search_screen.dart';
import 'package:ekart/c_dashboard/b_wishlist/wishlist_body.dart';
import 'package:ekart/c_dashboard/c_cart/cart_body.dart';
import 'package:ekart/c_dashboard/widgets/bottom_navbar.dart';
import 'package:ekart/utils/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DashboardRoot extends StatefulHookConsumerWidget {
  const DashboardRoot({
    super.key,
    required this.email,
  });

  final String email;

  @override
  ConsumerState<DashboardRoot> createState() => _DashboardRootState();
}

class _DashboardRootState extends ConsumerState<DashboardRoot> {
  DateTime datetime = DateTime.now();
  final fireRef = FirebaseFirestore.instance;
  int todayDate = 0;

  @override
  Widget build(BuildContext context) {
    final dailyOff = useState<int>(0);
    final selIndex = useState<int>(0);

    getOffers() async {
      var document = fireRef.collection('offer').doc('daily_off');
      document.get().then((document) {
        var data = document.data();
        dailyOff.value = data!['current_day'][todayDate - 1];
      });
    }

    updateFCMToken() {
      fireRef.collection('user').doc(widget.email).update({
        'fcmToken': fcmToken,
      });
    }

    useEffect(() {
      todayDate = datetime.day;
      getOffers();
      updateFCMToken();
      return null;
    });

    final List<Widget> dashboardBodyItems = [
      HomeBody(
        email: widget.email,
        dailyOffValue: dailyOff.value,
      ),
      WishlistBody(
        email: widget.email,
        dailyOffValue: dailyOff.value,
      ),
      CartBody(
        email: widget.email,
      ),
    ];
    final List<String> appBarTitle = [
      'EKart',
      'Wishlist',
      'Cart',
    ];

    return WillPopScope(
      onWillPop: () async {
        if (DateTime.now().difference(datetime) >= const Duration(seconds: 2)) {
          Fluttertoast.showToast(msg: 'Tap again to exit');
          datetime = DateTime.now();
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            appBarTitle[selIndex.value],
          ),
          actions: [
            IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: HomeSearchScreen(),
                );
              },
              icon: Image.asset(
                'assets/icons/search.png',
                height: 18.sp,
                color: AppConstant.subtitlecolor,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MoreScreen(
                      email: widget.email,
                    ),
                  ),
                );
              },
              icon: Image.asset(
                'assets/icons/user.png',
                height: 22.5.sp,
                color: AppConstant.subtitlecolor,
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
          ],
        ),
        body: dashboardBodyItems[selIndex.value],
        bottomNavigationBar: BottomNavBar(
          selIndex: selIndex,
        ),
      ),
    );
  }
}
