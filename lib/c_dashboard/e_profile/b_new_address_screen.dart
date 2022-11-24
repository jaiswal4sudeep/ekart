import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ekart/c_dashboard/e_profile/get_user_location.dart';
import 'package:ekart/utils/app_constant.dart';
import 'package:ekart/widgets/back_screen_button.dart';
import 'package:ekart/widgets/custom_button.dart';
import 'package:ekart/widgets/custom_divider.dart';
import 'package:ekart/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class NewAddressScreen extends HookWidget {
  const NewAddressScreen({
    super.key,
    required this.email,
  });

  final String email;

  @override
  Widget build(BuildContext context) {
    final fireRef = FirebaseFirestore.instance;
    final newAddressKey = GlobalKey<FormState>();
    final countryCon = useTextEditingController();
    final pinCodeCon = useTextEditingController();
    final stateCon = useTextEditingController();
    final cityCon = useTextEditingController();
    final addressCon = useTextEditingController();
    final isHome = useState<bool>(true);
    final isGettigAddress = useState<bool>(false);
    final isLoading = useState<bool>(false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Address'),
        leading: const BackScreenButton(),
      ),
      body: Form(
        key: newAddressKey,
        child: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    CustomTextFormField(
                      minLines: 3,
                      controller: addressCon,
                      labelText: 'Address (Area and Street)',
                      textInputType: TextInputType.streetAddress,
                      textInputAction: TextInputAction.newline,
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
                    CustomTextFormField(
                      controller: cityCon,
                      labelText: 'City/District/Town',
                      textInputType: TextInputType.streetAddress,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your city';
                        }
                        if (value.trim().length < 3) {
                          return 'City must be at least 3 characters';
                        }
                        return null;
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextFormField(
                            controller: stateCon,
                            labelText: 'State',
                            textInputType: TextInputType.streetAddress,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter your State';
                              }
                              if (value.trim().length < 3) {
                                return 'State must be at least 3 characters';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Expanded(
                          child: CustomTextFormField(
                            controller: pinCodeCon,
                            labelText: 'Pincode',
                            textInputType:
                                const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(','),
                              FilteringTextInputFormatter.deny('-'),
                              FilteringTextInputFormatter.deny(' '),
                              FilteringTextInputFormatter.deny('.'),
                            ],
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter your pincode';
                              }
                              if (value.trim().length != 6) {
                                return 'Pincode must be 6 characters';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    CustomTextFormField(
                      controller: countryCon,
                      labelText: 'Country',
                      textInputType: TextInputType.streetAddress,
                      textInputAction: TextInputAction.done,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your country';
                        }
                        if (value.trim().length < 3) {
                          return 'Country must be at least 3 characters';
                        }
                        return null;
                      },
                    ),
                    Text(
                      'Address Type',
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile(
                            value: true,
                            groupValue: isHome.value,
                            onChanged: (data) {
                              isHome.value = data!;
                            },
                            activeColor: AppConstant.subtitlecolor,
                            title: Text(
                              'Home',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ),
                        ),
                        Expanded(
                          child: RadioListTile(
                            value: false,
                            groupValue: isHome.value,
                            onChanged: (data) {
                              isHome.value = data!;
                            },
                            activeColor: AppConstant.subtitlecolor,
                            title: Text(
                              'Work',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const OrDivider(),
                    SizedBox(
                      height: 10.h,
                    ),
                    Center(
                      child: SizedBox(
                        width: 0.6.sw,
                        height: 40.h,
                        child: CustomElevatedButton(
                          hvIcon: true,
                          isLaoding: isGettigAddress.value,
                          icon: Image.asset(
                            'assets/icons/location.png',
                            height: 18.sp,
                            color: AppConstant.backgroundColor,
                          ),
                          onTap: () async {
                            isGettigAddress.value = true;
                            Position? cord = await getCurrentLongLat();
                            if (cord != null) {
                              List<Placemark> currentAddress =
                                  await placemarkFromCoordinates(
                                cord.latitude,
                                cord.longitude,
                              );
                              if (currentAddress.isNotEmpty) {
                                addressCon.text = currentAddress[0]
                                        .subLocality!
                                        .isNotEmpty
                                    ? '${currentAddress[0].street!}, ${currentAddress[0].subLocality!}'
                                    : currentAddress[0].street!;
                                cityCon.text = currentAddress[0].locality!;
                                stateCon.text =
                                    currentAddress[0].administrativeArea!;
                                pinCodeCon.text = currentAddress[0].postalCode!;
                                countryCon.text = currentAddress[0].country!;
                              }
                            } else {
                              Fluttertoast.showToast(
                                  msg: 'An error occured, Please try again.');
                            }
                            isGettigAddress.value = false;
                          },
                          title: 'Use my current location',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 0.9.sw,
              height: 40.h,
              child: GradientButton(
                isLaoding: isLoading.value,
                onTap: () {
                  if (newAddressKey.currentState!.validate()) {
                    isLoading.value = true;
                    fireRef.collection('user').doc(email).update({
                      isHome.value ? 'homeAddress' : 'workAddress': {
                        'address': addressCon.text.trim(),
                        'city': cityCon.text.trim(),
                        'state': stateCon.text.trim(),
                        'pincode': pinCodeCon.text.trim(),
                        'country': countryCon.text.trim(),
                      }
                    }).then((value) {
                      return Fluttertoast.showToast(msg: 'Saved');
                    }, onError: (error) {
                      Fluttertoast.showToast(msg: 'An error occured');
                    });
                    isLoading.value = false;
                  }
                },
                title: 'Save',
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
          ],
        ),
      ),
    );
  }
}
