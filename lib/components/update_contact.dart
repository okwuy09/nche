import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:nche/services/provider/userdata.dart';
import 'package:nche/widget/button.dart';
import 'package:nche/components/colors.dart';
import 'package:nche/widget/mytextform.dart';
import 'package:nche/components/const_values.dart';
import 'package:nche/widget/popover.dart';
import 'package:provider/provider.dart';

class UpdateEmergencyContact extends StatefulWidget {
  final String phoneNo;
  final String fullname;
  const UpdateEmergencyContact(
      {Key? key, required this.fullname, required this.phoneNo})
      : super(key: key);

  @override
  State<UpdateEmergencyContact> createState() => _UpdateEmergencyContactState();
}

class _UpdateEmergencyContactState extends State<UpdateEmergencyContact> {
  TextEditingController? _fullName;
  String? phoneNumber;
  @override
  void initState() {
    _fullName = TextEditingController(text: widget.fullname);
    phoneNumber = widget.phoneNo;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserData>(context);

    return SingleChildScrollView(
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
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Text(
                  'Update Contact',
                  style: style.copyWith(
                    color: AppColor.black.withOpacity(0.6),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              MyTextForm(
                controller: _fullName,
                obscureText: false,
                hintText: widget.fullname,
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
                  hintText: widget.phoneNo.substring(4),
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

              Padding(
                padding: const EdgeInsets.only(
                  top: 30,
                  bottom: 20,
                ),
                child: MainButton(
                  borderColor: Colors.transparent,
                  child: Text(
                    'Update Contact',
                    style: style.copyWith(
                      fontSize: 15,
                      color: AppColor.black,
                    ),
                  ),
                  backgroundColor: AppColor.primaryColor,
                  onTap: () {
                    provider.updateEmergencyContact(
                      names: _fullName!.text,
                      phones: phoneNumber!,
                      fname: widget.fullname,
                      fphone: widget.phoneNo,
                      context: context,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
