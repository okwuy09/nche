import 'package:flutter/material.dart';
import 'package:nche/widget/button.dart';
import 'package:nche/components/colors.dart';
import 'package:nche/widget/mytextform.dart';
import 'package:nche/components/style.dart';

handleAddContact(
    {BuildContext? context,
    TextEditingController? nameController,
    TextEditingController? phoneController,
    Function()? onTap}) {
  return showModalBottomSheet(
    context: context!,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) {
      return SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          margin: const EdgeInsets.only(
            bottom: 20,
            right: 20,
            left: 20,
          ),
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                ),
                child: Center(
                  child: Text(
                    'Add Emergency Contact',
                    style: style.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              MyTextForm(
                controller: nameController,
                obscureText: false,
                hintText: 'Fullname',
                validatior: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Fullname*';
                  }
                  return null;
                },
              ),
              //
              const SizedBox(height: 20),
              MyTextForm(
                controller: phoneController,
                obscureText: false,
                keyboardType: TextInputType.phone,
                hintText: 'Phone Number',
                validatior: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Phone Number*';
                  }
                  return null;
                },
              ),
              //
              const SizedBox(height: 30),
              MainButton(
                borderColor: Colors.transparent,
                child: Text(
                  'ADD CONTACT',
                  style: style.copyWith(
                    fontSize: 14,
                    color: AppColor.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: AppColor.primaryColor,
                onTap: onTap,
              ),

              //

              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 20,
                ),
                child: MainButton(
                  borderColor: Colors.transparent,
                  child: Text(
                    'CANCEL',
                    style: style.copyWith(
                      fontSize: 14,
                      color: AppColor.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  backgroundColor: AppColor.lightGrey,
                  onTap: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
