import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ekart/c_dashboard/screens/b_wishlist/wishlist_loading_screen.dart';
import 'package:ekart/widgets/back_screen_button.dart';
import 'package:ekart/widgets/custom_text_form_field.dart';
import 'package:ekart/widgets/error_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class PaymentDetailsScreen extends HookWidget {
  const PaymentDetailsScreen({
    super.key,
    required this.email,
  });
  final String email;

  @override
  Widget build(BuildContext context) {
    final fireRef = FirebaseFirestore.instance;
    final userName = useTextEditingController();
    final userEmail = useTextEditingController();
    // final userIsEmailVerified = useState<bool?>(false);
    // final userPhoto = useState<String?>('');
    final userPhoneNo = useTextEditingController();
    final userAddress = useTextEditingController();
    final detailsKey = GlobalKey<FormState>();

    return StreamBuilder<Object>(
      stream: fireRef.collection("user").doc(email).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CustomLoadingScreen(title: 'Personal Details');
        } else if (snapshot.hasData) {
          dynamic data = snapshot.data;
          userName.text = data['displayName'];
          userEmail.text = data['email'];
          userPhoneNo.text = data['phoneNo'];
          userAddress.text = data['address'];

          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Personal Details',
              ),
              leading: const BackScreenButton(),
            ),
            body: Form(
              autovalidateMode: AutovalidateMode.always, // TODO
              key: detailsKey,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  CustomTextFormField(
                    controller: userName,
                    labelText: 'Full name',
                    textInputType: TextInputType.name,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your name';
                      }
                      if (value.trim().length < 4) {
                        return 'Name must be at least 4 characters';
                      }
                      return null;
                    },
                  ),
                  CustomTextFormField(
                    controller: userEmail,
                    labelText: 'Email',
                    textInputType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your email address';
                      }
                      if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  CustomTextFormField(
                    controller: userPhoneNo,
                    labelText: 'Mobile number',
                    textInputType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your mobile number';
                      }
                      if (value.trim().length < 10) {
                        return 'Mobile numbers must be at least 10 numbers';
                      }
                      return null;
                    },
                  ),
                  CustomTextFormField(
                    controller: userAddress,
                    labelText: 'Address',
                    textInputType: TextInputType.streetAddress,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your address';
                      }
                      if (value.trim().length < 4) {
                        return 'Address must be at least 4 characters';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          );
        } else {
          return const ErrorScreen();
        }
      },
    );
  }
}
