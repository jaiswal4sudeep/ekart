import 'package:ekart/widgets/back_screen_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    User? user = FirebaseAuth.instance.currentUser;
    final userName = useState<String?>('');
    final userEmail = useState<String?>('');
    final userIsEmailVerified = useState<bool?>(false);
    final userPhoto = useState<String?>('');
    final userPhoneNo = useState<String?>('');
    final userAddress = useState<String?>('');

    fetchData() {
      // userName.value = user?.displayName!.toString();
      // userEmail.value = user?.email!.toString();
      userIsEmailVerified.value = user?.emailVerified;
      // userPhoto.value = user?.photoURL!.toString();
      // userPhoneNo.value = user?.photoURL!.toString();
    }

    useEffect(() {
      fetchData();
      return null;
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Personal Details',
        ),
        leading: const BackScreenButton(),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Text(userIsEmailVerified.value.toString()),
        ],
      ),
    );
  }
}
