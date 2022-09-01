import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nche/services/provider/userdata.dart';
import 'package:nche/widget/button.dart';
import 'package:nche/components/colors.dart';
//import 'package:nche/components/imageDisplay.dart';
import 'package:nche/widget/popover.dart';
import 'package:nche/components/const_values.dart';
import 'package:nche/components/tag.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:audioplayers/audioplayers.dart' as audio;
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class WritePost extends StatefulWidget {
  const WritePost({Key? key}) : super(key: key);

  @override
  State<WritePost> createState() => _WritePostState();
}

class _WritePostState extends State<WritePost> {
  final TextEditingController _post = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool isAnonymous = false;
  bool isRecorderReady = false;
  bool isAudio = false;
  XFile? _capturedImage;
  bool cameraImage = false;
  final picker = ImagePicker();
  final recorder = FlutterSoundRecorder();
  // for audio player
  final audioPlayer = audio.AudioPlayer();
  bool isplaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  // file picker
  bool isvideoPost = false;
  VideoPlayerController? _controller;
  List<File>? files = [];

  @override
  void initState() {
    super.initState();

    // setAudio();
    // initRecorder();
    // listen to states: playing, paused, stoped
    // audioPlayer.onPlayerStateChanged.listen((state) {
    //   setState(() {
    //     isplaying = state == audio.PlayerState.playing;
    //   });
    // });
    // // listen to audio duration
    // audioPlayer.onDurationChanged.listen((newDuration) {
    //   setState(() {
    //     duration = newDuration;
    //   });
    // });

    // // Listen to audio position
    // audioPlayer.onPositionChanged.listen((newPosition) {
    //   setState(() {
    //     position = newPosition;
    //   });
    // });
  }

  // Future setAudio() async {
  //   // Repeat Song when completed
  //   audioPlayer.setReleaseMode(audio.ReleaseMode.loop);

  //   // load audio from URL
  //   //final file = File();
  //   audioPlayer.setSourceUrl(//file.path);
  //       'https://cdn.trendybeatz.com/audio/Wizkid-Ft-Chris-Brown-Call-Me-Every-Day-(TrendyBeatz.com).mp3');
  // }

  @override
  void dispose() {
    recorder.closeRecorder();
    audioPlayer.dispose();
    super.dispose();
  }

  // Future initRecorder() async {
  //   final status = await Permission.microphone.request();

  //   if (status != PermissionStatus.granted) {
  //     throw 'Microphone permission not granted';
  //   }
  //   await recorder.openRecorder();

  //   isRecorderReady = true;
  //   recorder.setSubscriptionDuration(
  //     const Duration(milliseconds: 500),
  //   );
  // }

  // Future record() async {
  //   if (!isRecorderReady) return;
  //   await recorder.startRecorder(toFile: 'audio');
  // }

  // Future stop() async {
  //   if (!isRecorderReady) return;
  //   await recorder.stopRecorder();
  //   //final audioFile = File(path!);
  // }

  List<String> tags = <String>[];

  // _WritePostState() {
  //   for (int i = 0; i < 10; i++) {
  //     tags.add('Tag  ${i + 1}');
  //   }
  // }

  String formatTime(Duration duration) {
    String twoDigite(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigite(duration.inHours);
    final minutes = twoDigite(duration.inMinutes.remainder(60));
    final seconds = twoDigite(duration.inSeconds.remainder(60));
    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }

// Image file picker
  Future imageFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.image,
    );

    if (result == null) return;
    files = result.paths.map((path) => File(path!)).toList();
    setState(() {
      isvideoPost = false;
      cameraImage = false;
    });
  }

// Video file picker
  Future videoFilePicker() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(allowMultiple: true, type: FileType.video);
    if (result == null) return;
    files = result.paths.map((path) => File(path!)).toList();
    setState(() {
      isvideoPost = true;
      cameraImage = false;
    });
  }

  // image picker with camera
  Future captureImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxHeight: 700,
      maxWidth: 650,
    );

    setState(() {
      _capturedImage = pickedFile;
      cameraImage = true;
    });
  }

  String stateValue = allNigeriaStates[23];

  String? agencyDropdown;
  String postTypeReport = 'Incident Report';
  var agency = [
    'Police',
    'Fire-Service',
    'Army',
    'EFCC',
  ];

  var postype = [
    'Incident Report',
    'Accident Report',
    'Hazard Report',
    'kidnapping Report',
    'Armed Robbery Report',
    'Fire Report',
  ];

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var provider = Provider.of<UserData>(context);
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        backgroundColor: AppColor.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(
          children: [
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back,
                color: AppColor.black,
              ),
            ),
            Expanded(child: Container()),
            Text(
              'Write Post',
              style: style.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            Expanded(flex: 2, child: Container())
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    color: AppColor.lightGrey,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 5,
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Post As Anonymous',
                          style: style.copyWith(
                            color: AppColor.darkerGrey,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        Expanded(child: Container()),
                        Switch(
                          activeColor: AppColor.darkerYellow,
                          value: isAnonymous,
                          onChanged: (value) {
                            setState(
                              () {
                                isAnonymous = value;
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  // textfield for post
                  Container(
                    height: screenSize.height * 0.31,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      controller: _post,
                      validator: (input) => (input!.isEmpty)
                          ? "Please write what is happening"
                          : null,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: style.copyWith(color: AppColor.grey),
                        hintText: 'What is happening?',
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 0),
                      ),
                    ),
                  ),
                ],
              ),

              // media attachment
              Container(
                margin: EdgeInsets.only(bottom: screenSize.height * 0.1),
                width: double.infinity,
                color: AppColor.lightGrey,
                child: Column(
                  children: [
                    // display media container,
                    Container(
                      color: AppColor.lightGrey,
                      padding: const EdgeInsets.only(
                        top: 10,
                        left: 10,
                        right: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          cameraImage
                              ? Container(
                                  height: 85,
                                  width: 85,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    image: DecorationImage(
                                      image:
                                          FileImage(File(_capturedImage!.path)),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              : files!.isNotEmpty
                                  ? GridView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 4,
                                        crossAxisSpacing: 5.0,
                                        mainAxisSpacing: 5.0,
                                      ),
                                      itemCount: files!.isEmpty
                                          ? 0
                                          : files!.length > 4
                                              ? 4
                                              : files!.length,
                                      // : videoFiles!.isEmpty
                                      //     ? 0
                                      //     : videoFiles!.length > 4
                                      //         ? 4
                                      //         : videoFiles!.length,
                                      itemBuilder: (context, index) {
                                        return isvideoPost
                                            ? Stack(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                      child: VideoPlayer(_controller =
                                                          VideoPlayerController
                                                              .file(File(
                                                                  files![index]
                                                                      .path))),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 0,
                                                    left: 0,
                                                    right: 0,
                                                    bottom: 0,
                                                    child: IconButton(
                                                      icon: Icon(
                                                        _controller!
                                                                .value.isPlaying
                                                            ? Icons
                                                                .pause_circle_outlined
                                                            : Icons
                                                                .play_circle_outline,
                                                        color: AppColor.white,
                                                      ),
                                                      onPressed: () {
                                                        setState(
                                                          () {
                                                            _controller!.value
                                                                    .isPlaying
                                                                ? _controller!
                                                                    .pause()
                                                                : _controller!
                                                                    .play();
                                                          },
                                                        );
                                                      },
                                                    ),
                                                  )
                                                ],
                                              )
                                            : Stack(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                      image: DecorationImage(
                                                        image: FileImage(File(
                                                            files![index]
                                                                .path)),
                                                        // : const AssetImage('assets/white.jpg')
                                                        //     as ImageProvider,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  index == 3
                                                      ? Positioned(
                                                          top: 0,
                                                          left: 0,
                                                          child: Container(
                                                            width: 80,
                                                            height: 80,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors
                                                                  .transparent
                                                                  .withOpacity(
                                                                      0.5),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          6),
                                                            ),
                                                            child: Align(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Text(
                                                                '+ ${files!.length - 4} ',
                                                                style: style
                                                                    .copyWith(
                                                                  fontSize: 30,
                                                                  color: AppColor
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      : Container(),
                                                ],
                                              );
                                      },
                                    )
                                  : Container(),

                          FlutterTagView(
                            tagBackgroundColor: AppColor.black,
                            tags: tags,
                            maxTagViewHeight: 100,
                            deletableTag: true,
                          ),

                          // audio player
                          // Container(
                          //   color: AppColor.white,
                          //   width: screenSize.width / 1.5,
                          //   padding: const EdgeInsets.all(2),
                          //   child: Column(
                          //     mainAxisAlignment: MainAxisAlignment.start,
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       Row(
                          //         children: [
                          //           Slider(
                          //             min: 0,
                          //             max: duration.inSeconds.toDouble(),
                          //             value: position.inSeconds.toDouble(),
                          //             onChanged: (value) async {
                          //               final position =
                          //                   Duration(seconds: value.toInt());
                          //               await audioPlayer.seek(position);

                          //               /// opptional Player if was paused
                          //               await audioPlayer.resume();
                          //             },
                          //           ),
                          //           CircleAvatar(
                          //             radius: 15,
                          //             child: IconButton(
                          //               icon: Icon(
                          //                 isplaying
                          //                     ? Icons.pause
                          //                     : Icons.play_arrow,
                          //                 size: 15,
                          //               ),
                          //               onPressed: () async {
                          //                 if (isplaying) {
                          //                   await audioPlayer.pause();
                          //                 } else {
                          //                   await audioPlayer.resume();
                          //                 }
                          //                 setState(() {});
                          //               },
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //       Padding(
                          //         padding:
                          //             const EdgeInsets.symmetric(horizontal: 16),
                          //         child: Row(
                          //           mainAxisAlignment:
                          //               MainAxisAlignment.spaceBetween,
                          //           children: [
                          //             Text(formatTime(position)),
                          //             Text(formatTime(duration - position)),
                          //           ],
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ),

                    // import media/ video and picture
                    ListTile(
                      leading: const Icon(
                        Icons.photo_library,
                        color: Colors.green,
                      ),
                      horizontalTitleGap: 0,
                      title: Text(
                        ' Photo/video',
                        style: style.copyWith(fontSize: 17),
                      ),
                      onTap: () => showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Popover(
                            mainAxisSize: MainAxisSize.min,
                            child: Column(children: [
                              InkWell(
                                onTap: () {
                                  imageFilePicker();
                                  Navigator.pop(context);
                                },
                                child: Row(
                                  children: [
                                    const Icon(Icons.photo_library),
                                    const SizedBox(width: 10),
                                    Text('Pictures', style: style)
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Divider(),
                              const SizedBox(height: 10),
                              InkWell(
                                onTap: () {
                                  videoFilePicker();

                                  Navigator.pop(context);
                                },
                                child: Row(
                                  children: [
                                    const Icon(Icons.video_library),
                                    const SizedBox(width: 10),
                                    Text('Videos', style: style)
                                  ],
                                ),
                              ),
                            ]),
                          );
                        },
                      ),
                    ),
                    const Divider(height: 1, thickness: 1),

                    // post Type
                    ListTile(
                      leading: Icon(
                        Icons.report_outlined,
                        color: AppColor.orange,
                      ),
                      horizontalTitleGap: 0,
                      title: DropdownButton<String>(
                        isExpanded: true,
                        value: postTypeReport,
                        underline: const Divider(color: Colors.transparent),
                        hint: Text(
                          'Post type',
                          style: style,
                        ),
                        items: postype
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            child: Text(value),
                            value: value,
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            postTypeReport = value!;
                          });
                        },
                      ),
                    ),

                    const Divider(height: 1, thickness: 1),
                    // add location
                    ListTile(
                      leading: Icon(
                        Icons.location_on_outlined,
                        color: AppColor.red,
                      ),
                      horizontalTitleGap: 0,
                      title: DropdownButton<String>(
                        isExpanded: true,
                        underline: const Divider(color: Colors.transparent),
                        hint: Text(
                          'Add Location',
                          style: style,
                        ),
                        value: stateValue,
                        items: allNigeriaStates
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            child: Text(value),
                            value: value,
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            stateValue = value!;
                          });
                        },
                      ),
                    ),

                    const Divider(height: 1, thickness: 1),
                    // tag Agency
                    ListTile(
                      leading: Icon(
                        Icons.person_add_alt_outlined,
                        color: AppColor.blue,
                      ),
                      horizontalTitleGap: 0,
                      title: DropdownButton<String>(
                        isExpanded: true,
                        underline: const Divider(color: Colors.transparent),
                        hint: Text(
                          'Tag Agency',
                          style: style,
                        ),
                        items: agency.map((String value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            agencyDropdown = newValue!;
                          });
                          tags.add(agencyDropdown!);
                        },
                      ),
                    ),

                    const Divider(height: 1, thickness: 1),

                    // camera
                    ListTile(
                      leading: Icon(
                        Icons.camera_enhance_outlined,
                        color: AppColor.darkerYellow,
                      ),
                      horizontalTitleGap: 0,
                      minVerticalPadding: 2,
                      title: Text(
                        'Camera',
                        style: style.copyWith(fontSize: 17),
                      ),
                      onTap: () => captureImage(),
                    ),
                    //
                    //const Divider(height: 1, thickness: 1),

                    // record audio
                    // ListTile(
                    //   leading: Icon(
                    //     Icons.mic,
                    //     color: AppColor.black,
                    //   ),
                    //   horizontalTitleGap: 0,
                    //   title: Text(
                    //     'Record Audio',
                    //     style: style.copyWith(fontSize: 17),
                    //   ),
                    //   onTap: () {
                    //     showModalBottomSheet(
                    //       context: context,
                    //       isScrollControlled: true,
                    //       builder: (_) {
                    //         return StatefulBuilder(
                    //             builder: (context, StateSetter setState) {
                    //           return Container(
                    //             width: double.infinity,
                    //             // height: screenSize.height * 0.22,
                    //             padding: EdgeInsets.only(
                    //               left: 30,
                    //               right: 30,
                    //               bottom:
                    //                   MediaQuery.of(context).viewInsets.bottom,
                    //             ),
                    //             child: Column(
                    //               mainAxisSize: MainAxisSize.min,
                    //               children: [
                    //                 Row(
                    //                   children: [
                    //                     IconButton(
                    //                       onPressed: () => Navigator.pop(context),
                    //                       icon: const Icon(Icons.arrow_back),
                    //                     ),
                    //                     Expanded(child: Container()),
                    //                     Text(
                    //                       'Record Audio',
                    //                       style: style.copyWith(
                    //                         fontSize: 18,
                    //                         fontWeight: FontWeight.w500,
                    //                       ),
                    //                     ),
                    //                     Expanded(flex: 2, child: Container()),
                    //                   ],
                    //                 ),
                    //                 const Icon(
                    //                   Icons.mic_none_outlined,
                    //                   size: 150,
                    //                 ),
                    //                 StreamBuilder<RecordingDisposition>(
                    //                   stream: recorder.onProgress,
                    //                   builder: (context, snapshot) {
                    //                     final duration = snapshot.hasData
                    //                         ? snapshot.data!.duration
                    //                         : Duration.zero;

                    //                     String twoDigits(int n) =>
                    //                         n.toString().padLeft(2, '0');
                    //                     final twoDigitMinutes = twoDigits(
                    //                         duration.inMinutes.remainder(60));
                    //                     final twoDigitSeconds = twoDigits(
                    //                         duration.inSeconds.remainder(60));

                    //                     return Text(
                    //                       '$twoDigitMinutes: $twoDigitSeconds',
                    //                       style: style.copyWith(fontSize: 50),
                    //                     );
                    //                   },
                    //                 ),
                    //                 Padding(
                    //                   padding: const EdgeInsets.symmetric(
                    //                       vertical: 20),
                    //                   child: ElevatedButton(
                    //                     child: Icon(
                    //                       recorder.isRecording
                    //                           ? Icons.stop_circle_outlined
                    //                           : Icons.mic,
                    //                       size: 40,
                    //                       color: AppColor.black,
                    //                     ),
                    //                     onPressed: () async {
                    //                       if (recorder.isRecording) {
                    //                         await stop();
                    //                       } else {
                    //                         await record();
                    //                       }
                    //                       setState(() {});
                    //                     },
                    //                     style: ElevatedButton.styleFrom(
                    //                       elevation: 0,
                    //                       primary: AppColor.grey,
                    //                       fixedSize: const Size(80, 80),
                    //                       shape: const CircleBorder(),
                    //                     ),
                    //                   ),
                    //                 ),
                    //                 Padding(
                    //                   padding: const EdgeInsets.symmetric(
                    //                     vertical: 20,
                    //                   ),
                    //                   child: MainButton(
                    //                     borderColor: Colors.transparent,
                    //                     child: Text(
                    //                       'SAVE',
                    //                       style: style.copyWith(
                    //                         fontSize: 14,
                    //                         color: AppColor.black,
                    //                         fontWeight: FontWeight.bold,
                    //                       ),
                    //                     ),
                    //                     backgroundColor: AppColor.darkerYellow,
                    //                     onTap: () {
                    //                       Navigator.pop(context);
                    //                     },
                    //                   ),
                    //                 )
                    //               ],
                    //             ),
                    //           );
                    //         });
                    //       },
                    //     );
                    //   },
                    // ),
                    //
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        color: AppColor.lightGrey,
        child: MainButton(
            borderColor: Colors.transparent,
            child: provider.isPosting
                ? buttonCircularIndicator
                : Text(
                    'POST',
                    style: style.copyWith(
                      fontSize: 14,
                      color: AppColor.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            backgroundColor: AppColor.darkerYellow,
            onTap: () async {
              if (_formkey.currentState!.validate()) {
                await provider
                    .writePost(
                      context: context,
                      writeUp: _post.text,
                      isAnonymous: isAnonymous,
                      location: stateValue,
                      incidentType: postTypeReport,
                      avarter: files,
                      camImage: _capturedImage,
                    )
                    .then(
                      (value) => Navigator.pop(context),
                    );
              }
            }),
      ),
    );
  }
}
