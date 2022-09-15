import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:nche/components/alert.dart';
import 'package:nche/services/provider/userdata.dart';
import 'package:nche/widget/button.dart';
import 'package:nche/components/colors.dart';
import 'package:nche/widget/mytextform.dart';
import 'package:nche/components/const_values.dart';
import 'package:nche/widget/popover.dart';
import 'package:provider/provider.dart';

class AddEmergencyContact extends StatefulWidget {
  const AddEmergencyContact({
    Key? key,
  }) : super(key: key);

  @override
  State<AddEmergencyContact> createState() => _AddEmergencyContactState();
}

class _AddEmergencyContactState extends State<AddEmergencyContact> {
  final GlobalKey<FormState> _FormKey = GlobalKey<FormState>();
  final TextEditingController _fullName = TextEditingController();
  String phoneNumber = '';

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserData>(context);
    return SingleChildScrollView(
      child: Form(
        key: _FormKey,
        child: Container(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
          ),
          child: Popover(
            mainAxisSize: MainAxisSize.min,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Add Five(5) Emergency Contact',
                        style: style.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Center(
                          child: Text(
                            '${provider.userData!.emergencyContact!.isEmpty ? '0' : provider.userData!.emergencyContact!.length}',
                            style: style.copyWith(
                              fontSize: 20,
                              color: AppColor.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                MyTextForm(
                  controller: _fullName,
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
                IntlPhoneField(
                  style: style,
                  dropdownIcon: Icon(
                    Icons.arrow_drop_down,
                    color: AppColor.black,
                  ),
                  cursorColor: AppColor.black,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColor.white,
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6.0),
                      borderSide: BorderSide(
                        color: AppColor.red,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 10.0),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6.0),
                      borderSide: BorderSide(
                        color: AppColor.darkerGrey,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6.0),
                      borderSide: BorderSide(
                        color: AppColor.grey,
                      ),
                    ),
                    hintText: 'Phone Number',
                  ),
                  initialCountryCode: 'NG',
                  onChanged: (phone) {
                    //print(phone.completeNumber);
                    setState(() {
                      phoneNumber = phone.completeNumber;
                    });
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
                  onTap: () async {
                    if (_FormKey.currentState!.validate()) {
                      if (provider.userData!.emergencyContact!.length < 5) {
                        await provider.addEmergencyContact(
                          _fullName.text,
                          phoneNumber,
                        );
                      } else {
                        handleFireBaseAlert(
                          message:
                              ' Sorry You can\'t add more than Five(5) Emergency contact',
                          context: context,
                        );
                      }
                    }
                  },
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
        ),
      ),
    );
  }
}
