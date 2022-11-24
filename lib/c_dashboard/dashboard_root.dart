import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ekart/c_dashboard/a_home/_dashboard_screen.dart';
import 'package:ekart/c_dashboard/a_home/home_search_screen.dart';
import 'package:ekart/c_dashboard/c_cart/cart_body.dart';
import 'package:ekart/c_dashboard/d_order_history/order_history_body.dart';
import 'package:ekart/c_dashboard/e_profile/_profile_body.dart';
import 'package:ekart/c_dashboard/widgets/dashboard_bottom_navbar.dart';
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

    getOffers() async {
      var document = fireRef.collection('offer').doc('daily_off');
      document.get().then((document) {
        var data = document.data();
        dailyOff.value = data!['current_day'][todayDate - 1];
      });
    }

    useEffect(() {
      todayDate = datetime.day;
      getOffers();
      return null;
    });

    final selIndex = useState<int>(1);
    List<Widget> dashboardBodyItems = [
      HomeScreen(
        email: widget.email,
      ),
      CartBody(
        email: widget.email,
      ),
      const OrderHistoryBody(),
      ProfileBody(
        email: widget.email,
      ),
    ];

    return WillPopScope(
      onWillPop: () async {
        if (DateTime.now().difference(datetime) >= const Duration(seconds: 2)) {
          Fluttertoast.showToast(msg: 'Tap again to exit!');
          datetime = DateTime.now();
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'EKart',
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
            SizedBox(
              width: 10.w,
            ),
          ],
        ),
        extendBody: true,
        body: dashboardBodyItems[0],
        bottomNavigationBar: DashboardBottomNavbar(
          selIndex: selIndex,
        ),
      ),
    );
  }
}
