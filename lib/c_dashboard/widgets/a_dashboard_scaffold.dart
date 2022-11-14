import 'package:ekart/c_dashboard/screens/cart_screen.dart';
import 'package:ekart/c_dashboard/screens/favorites/favorites_screen.dart';
import 'package:ekart/c_dashboard/widgets/b_dashboard_body.dart';
import 'package:ekart/c_dashboard/widgets/c_dashboard_drawer.dart';
import 'package:ekart/utils/app_constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardScaffold extends HookWidget {
  const DashboardScaffold({
    Key? key,
    required this.productData,
    required this.appName,
    required this.appVersion,
    required this.userData,
    required this.user,
    required this.selCategoryIndex,
  }) : super(key: key);
  final dynamic productData;
  final dynamic userData;
  final String appName;
  final String appVersion;
  final User user;
  final ValueNotifier<int> selCategoryIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'EKart',
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => FavoritesScreen(
                    user: user,
                  ),
                ),
              );
            },
            icon: const Icon(
              Icons.favorite_rounded,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CartScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.shopping_bag_outlined,
            ),
          ),
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(),
              );
            },
            icon: const Icon(
              Icons.search_rounded,
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
        ],
      ),
      drawer: DashboardDrawer(
        userData: userData,
        appName: appName,
        appVersion: appVersion,
        user: user,
      ),
      body: DashboardBody(
        productData: productData,
        selCategoryIndex: selCategoryIndex,
        user: user,
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  List<String> searchTerm = [
    'clothes',
    'all',
    'books',
  ];

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme;
  }

  @override
  TextStyle get searchFieldStyle => TextStyle(
        color: AppConstant.titlecolor,
        fontSize: 12.sp,
      );

  @override
  String? get searchFieldLabel => 'Search products';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(
            Icons.clear_rounded,
          ),
        )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(
        Icons.keyboard_arrow_left_rounded,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var item in searchTerm) {
      if (item.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(
            result,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var item in searchTerm) {
      if (item.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(
            result,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        );
      },
    );
  }
}
