import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:nche/widget/button.dart';
import 'package:nche/components/colors.dart';
import 'package:nche/widget/datefield.dart';
import 'package:nche/widget/mytextform.dart';
import 'package:nche/widget/popover.dart';
import 'package:nche/components/const_values.dart';
import 'package:nche/ui/homepage/bottom_navbar.dart';

class ReportIncident extends StatefulWidget {
  const ReportIncident({Key? key}) : super(key: key);

  @override
  State<ReportIncident> createState() => _ReportIncidentState();
}

class _ReportIncidentState extends State<ReportIncident> {
  DateTime incidentDate = DateTime.now();
  String _incidentType = 'Select incident type';
  final TextEditingController _incidentLocation = TextEditingController();
  final TextEditingController _amount = TextEditingController();

  _incidentDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      confirmText: 'SET DATE',
      initialDate: incidentDate,
      firstDate: DateTime(2016),
      lastDate: DateTime(2030),
    );
    if (selected != null && selected != incidentDate) {
      setState(() {
        incidentDate = selected;
      });
    }
  }

  bool ischecked = false;

  List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  List<File>? imageFiles = [];
  List<File>? videoFiles = [];

  // Image file picker
  Future imageFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.image,
    );

    if (result == null) return;
    imageFiles = result.paths.map((path) => File(path!)).toList();
    setState(() {
      //isvideoPost = false;
    });
  }

// Video file picker
  Future videoFilePicker() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(allowMultiple: true, type: FileType.video);
    if (result == null) return;
    videoFiles = result.paths.map((path) => File(path!)).toList();
    setState(() {
      //isvideoPost = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 65,
        elevation: 0,
        backgroundColor: AppColor.white,
        title: Row(
          children: [
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back,
                color: AppColor.black,
              ),
            ),
            const SizedBox(width: 16),
            // Page title
            Text(
              'Report Incident',
              style: style.copyWith(
                fontSize: 18,
                color: AppColor.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 5,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 70,
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColor.lightOrange,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    Container(
                      height: 57,
                      width: 57,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        image: const DecorationImage(
                          image: AssetImage('assets/musk.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nweke Franklin',
                          style: style.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Independent layout, Enugu',
                          style: style.copyWith(fontSize: 12),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenSize.height * 0.025),
              Text(
                'What type of incident occured?:',
                style: style.copyWith(
                  fontSize: 12,
                  color: AppColor.darkerGrey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                height: 50,
                width: screenSize.width,
                decoration: BoxDecoration(
                  color: AppColor.lightGrey,
                  border: Border.all(color: AppColor.lightGrey),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30, right: 20),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      underline: const Divider(color: Colors.transparent),
                      value: _incidentType,
                      elevation: 0,
                      style: style.copyWith(fontSize: 14),
                      onChanged: (String? newValue) {
                        setState(() {
                          _incidentType = newValue!;
                        });
                      },
                      items: <String>[
                        'Select incident type',
                        'ACCIDENT',
                        'FIRE INCIDENT',
                        'ARMED ROBBERY',
                        'KIDNAPPING',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenSize.height * 0.025),
              //incident date
              Text(
                'Exact Incident Location?:',
                style: style.copyWith(
                  fontSize: 12,
                  color: AppColor.darkerGrey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              MyTextForm(
                controller: _incidentLocation,
                obscureText: false,
              ),
              SizedBox(height: screenSize.height * 0.025),
              //incident date
              Text(
                'Date of incident:',
                style: style.copyWith(
                  fontSize: 12,
                  color: AppColor.darkerGrey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              DateField(
                pickedDate:
                    '${incidentDate.day} ${months[incidentDate.month - 1]}, ${incidentDate.year}',
                onPressed: () => _incidentDate(context),
              ),

              SizedBox(height: screenSize.height * 0.025),
              //record audio
              Text(
                'Record Audio:',
                style: style.copyWith(
                  fontSize: 12,
                  color: AppColor.darkerGrey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                height: 50,
                width: screenSize.width,
                decoration: BoxDecoration(
                  color: AppColor.lightGrey,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: AppColor.lightGrey,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Tap to record audio',
                        style: style.copyWith(
                          color: AppColor.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(child: Container()),
                    Container(
                      height: 38,
                      width: 38,
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: AppColor.lightOrange,
                          borderRadius: BorderRadius.circular(6)),
                      child: Align(
                        alignment: Alignment.center,
                        child: IconButton(
                          icon: const Icon(
                            Icons.mic,
                            color: Color(0xffF57E5B),
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //

              SizedBox(height: screenSize.height * 0.025),
              //record audio
              Text(
                'Upload image and videos:',
                style: style.copyWith(
                  fontSize: 12,
                  color: AppColor.darkerGrey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                height: 50,
                width: screenSize.width,
                decoration: BoxDecoration(
                  color: AppColor.lightGrey,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: AppColor.lightGrey,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Tap to upload media',
                        style: style.copyWith(
                          color: AppColor.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(child: Container()),
                    Container(
                      height: 38,
                      width: 38,
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: AppColor.lightOrange,
                          borderRadius: BorderRadius.circular(6)),
                      child: Align(
                        alignment: Alignment.center,
                        child: IconButton(
                          icon: const Icon(
                            Icons.photo_library_outlined,
                            color: Color(0xffF57E5B),
                          ),
                          onPressed: () {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              backgroundColor: Colors.transparent,
                              builder: (_) {
                                return Container(
                                  padding: const EdgeInsets.all(20),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 50, vertical: 20),
                                  decoration: BoxDecoration(
                                    color: AppColor.white,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            imageFilePicker();
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            'Images',
                                            style: style,
                                          ),
                                        ),
                                        const Divider(),
                                        TextButton(
                                          onPressed: () {
                                            videoFilePicker();
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            'Videos',
                                            style: style,
                                          ),
                                        ),
                                      ]),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        width: double.infinity,
        height: screenSize.height * 0.17,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: AppColor.lightGrey,
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Report As Anonymous',
                  style: style.copyWith(
                    color: AppColor.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Expanded(child: Container()),
                Switch(
                  activeColor: AppColor.darkerYellow,
                  value: ischecked,
                  onChanged: (value) {
                    setState(() {
                      ischecked = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            MainButton(
              borderColor: Colors.transparent,
              child: Text(
                'CONTINUE',
                style: style.copyWith(
                  fontSize: 14,
                  color: AppColor.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: AppColor.darkerYellow,
              onTap: () {
                showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (_) {
                      return Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColor.white,
                        ),
                        child:
                            Column(mainAxisSize: MainAxisSize.min, children: [
                          Text(
                            'Almost There!',
                            style: style.copyWith(fontSize: 18),
                          ),
                          const SizedBox(height: 20),
                          MainButton(
                            borderColor: Colors.transparent,
                            child: Text(
                              'ATTACH A TOKEN / REWARD',
                              style: style.copyWith(
                                fontSize: 14,
                                color: AppColor.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            backgroundColor: const Color(0xffD9FFF8),
                            onTap: () {
                              Navigator.pop(context);
                              showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                isScrollControlled: true,
                                context: context,
                                builder: (_) {
                                  return Popover(
                                    mainAxisSize: MainAxisSize.min,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      decoration: const BoxDecoration(
                                        color: Colors.transparent,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          MyTextForm(
                                            controller: _amount,
                                            obscureText: false,
                                            keyboardType: TextInputType.number,
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Text(
                                                '1 NCE = ',
                                                style: style.copyWith(
                                                  color: AppColor.darkerGrey,
                                                ),
                                              ),
                                              Text(
                                                ' NGN 23456',
                                                style: style.copyWith(
                                                  color: AppColor.darkerGrey,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 30),
                                          Text(
                                            'NGN ${_amount.text}.00',
                                            style: style.copyWith(fontSize: 35),
                                          ),
                                          const SizedBox(height: 20),
                                          Text(
                                            'Your Balance: 0809873 NCE',
                                            style: style.copyWith(fontSize: 14),
                                          ),
                                          const SizedBox(height: 30),
                                          MainButton(
                                            borderColor: Colors.transparent,
                                            child: Text(
                                              'ATTACH REWARD',
                                              style: style.copyWith(
                                                fontSize: 14,
                                                color: AppColor.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            backgroundColor:
                                                AppColor.darkerYellow,
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                          TextButton(
                                            onPressed: () {},
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons
                                                      .account_balance_wallet_outlined,
                                                  color: AppColor.orange,
                                                ),
                                                Text(
                                                  'Fund wallet',
                                                  style: style.copyWith(
                                                      color: AppColor.orange),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 20),
                          MainButton(
                            borderColor: Colors.transparent,
                            child: Text(
                              'SUBMIT REPORT',
                              style: style.copyWith(
                                fontSize: 14,
                                color: AppColor.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            backgroundColor: AppColor.darkerYellow,
                            onTap: () {
                              Navigator.pop(context);
                              showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (_) {
                                  return Container(
                                    padding: const EdgeInsets.all(20),
                                    margin: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: AppColor.white,
                                      borderRadius: BorderRadius.circular(26),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: IconButton(
                                            onPressed: () =>
                                                Navigator.pushAndRemoveUntil(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (_) =>
                                                          const BottomNavBar(),
                                                    ),
                                                    (route) => false),
                                            icon: const Icon(
                                                Icons.cancel_outlined),
                                          ),
                                        ),
                                        Image.asset(
                                          'assets/musk.jpg',
                                          fit: BoxFit.cover,
                                          height: 60,
                                          width: 60,
                                        ),
                                        const SizedBox(height: 20),
                                        Text(
                                          'Thank you for reporting.\nReport has been sent successfully',
                                          style: style,
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 30),
                                        MainButton(
                                          borderColor: Colors.transparent,
                                          child: Text(
                                            'MAKE ANOTHER REPORT',
                                            style: style.copyWith(
                                              fontSize: 14,
                                              color: AppColor.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          backgroundColor:
                                              AppColor.darkerYellow,
                                          onTap: () => Navigator.pop(context),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ]),
                      );
                    });
              },
            )
          ],
        ),
      ),
    );
  }
}
