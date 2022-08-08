import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nche/components/button.dart';
import 'package:nche/components/colors.dart';
import 'package:nche/components/imageDisplay.dart';
import 'package:nche/components/popover.dart';
import 'package:nche/components/style.dart';
import 'package:nche/components/tag.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:audioplayers/audioplayers.dart' as audio;
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class WritePost extends StatefulWidget {
  const WritePost({Key? key}) : super(key: key);

  @override
  State<WritePost> createState() => _WritePostState();
}

class _WritePostState extends State<WritePost> {
  final TextEditingController _post = TextEditingController();
  final TextEditingController _tag = TextEditingController();
  final TextEditingController _location = TextEditingController();
  bool ischecked = false;
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
  List<File>? imageFiles = [];
  List<File>? videoFiles = [];

  @override
  void initState() {
    super.initState();

    setAudio();
    initRecorder();
    // listen to states: playing, paused, stoped
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isplaying = state == audio.PlayerState.playing;
      });
    });
    // listen to audio duration
    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    // Listen to audio position
    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  Future setAudio() async {
    // Repeat Song when completed
    audioPlayer.setReleaseMode(audio.ReleaseMode.loop);

    // load audio from URL
    //final file = File();
    audioPlayer.setSourceUrl(//file.path);
        'https://cdn.trendybeatz.com/audio/Wizkid-Ft-Chris-Brown-Call-Me-Every-Day-(TrendyBeatz.com).mp3');
  }

  @override
  void dispose() {
    recorder.closeRecorder();
    audioPlayer.dispose();
    super.dispose();
  }

  Future initRecorder() async {
    final status = await Permission.microphone.request();

    if (status != PermissionStatus.granted) {
      throw 'Microphone permission not granted';
    }
    await recorder.openRecorder();

    isRecorderReady = true;
    recorder.setSubscriptionDuration(
      const Duration(milliseconds: 500),
    );
  }

  Future record() async {
    if (!isRecorderReady) return;
    await recorder.startRecorder(toFile: 'audio');
  }

  Future stop() async {
    if (!isRecorderReady) return;
    var recordedAudio = await recorder.stopRecorder();
    //final audioFile = File(path!);
  }

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
    imageFiles = result.paths.map((path) => File(path!)).toList();
    setState(() {
      isvideoPost = false;
    });
  }

// Video file picker
  Future videoFilePicker() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(allowMultiple: true, type: FileType.video);
    if (result == null) return;
    videoFiles = result.paths.map((path) => File(path!)).toList();
    setState(() {
      isvideoPost = true;
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

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Make post as anonymous',
                        style: style.copyWith(
                          color: AppColor.black,
                          //fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                      Expanded(child: Container()),
                      Switch(
                        activeColor: AppColor.darkerYellow,
                        value: ischecked,
                        onChanged: (value) {
                          setState(
                            () {
                              ischecked = value;
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  // textfield for post
                  SizedBox(
                    height: screenSize.height * 0.28,
                    child: TextFormField(
                      controller: _post,
                      validator: (input) =>
                          (input!.isEmpty) ? "Enter Your Statement" : null,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: style.copyWith(color: AppColor.darkerGrey),
                        hintText: 'Write on what has been happening?',
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 0),
                      ),
                    ),
                  ),
                ],
              ),
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
                        // cameraImage? Container(
                        //           decoration: BoxDecoration(
                        //             borderRadius: BorderRadius.circular(6),
                        //             image: DecorationImage(
                        //               image: _capturedImage!= null?
                        //                   FileImage(File(_capturedImage!.path))
                        //               : const AssetImage('assets/white.jpg')
                        //                   as ImageProvider,
                        //               fit: BoxFit.cover,
                        //             ),
                        //           ),
                        //         ): Container(),

                        imageFiles!.isNotEmpty
                            ? GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  crossAxisSpacing: 5.0,
                                  mainAxisSpacing: 5.0,
                                ),
                                itemCount: !isvideoPost
                                    ? imageFiles!.isEmpty
                                        ? 0
                                        : imageFiles!.length > 4
                                            ? 4
                                            : imageFiles!.length
                                    : videoFiles!.isEmpty
                                        ? 0
                                        : videoFiles!.length > 4
                                            ? 4
                                            : videoFiles!.length,
                                itemBuilder: (context, index) {
                                  return isvideoPost
                                      ? Stack(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                child: VideoPlayer(_controller =
                                                    VideoPlayerController.file(
                                                        File(videoFiles![index]
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
                                                  _controller!.value.isPlaying
                                                      ? Icons
                                                          .pause_circle_outlined
                                                      : Icons
                                                          .play_circle_outline,
                                                  color: AppColor.white,
                                                ),
                                                onPressed: () {
                                                  setState(
                                                    () {
                                                      _controller!
                                                              .value.isPlaying
                                                          ? _controller!.pause()
                                                          : _controller!.play();
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
                                                    BorderRadius.circular(6),
                                                image: DecorationImage(
                                                  image: FileImage(File(
                                                      imageFiles![index].path)),
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
                                                      decoration: BoxDecoration(
                                                        color: Colors
                                                            .transparent
                                                            .withOpacity(0.5),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                      ),
                                                      child: Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          '+ ${imageFiles!.length - 4} ',
                                                          style: style.copyWith(
                                                            fontSize: 30,
                                                            color:
                                                                AppColor.white,
                                                            fontWeight:
                                                                FontWeight.w500,
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

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: AppColor.red,
                              ),
                              Text(
                                _location.text,
                                style: style.copyWith(
                                    fontWeight: FontWeight.w500, fontSize: 14),
                              ),
                            ],
                          ),
                        ),
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
                  // camera
                  ListTile(
                    leading: Icon(
                      Icons.camera_enhance_outlined,
                      color: AppColor.black,
                    ),
                    horizontalTitleGap: 0,
                    minVerticalPadding: 2,
                    title: Text(
                      'Camera',
                      style: style.copyWith(fontSize: 17),
                    ),
                    onTap: () => captureImage(),
                  ),
                  const Divider(height: 1, thickness: 1),

                  // add location
                  ListTile(
                    leading: Icon(
                      Icons.location_on_outlined,
                      color: AppColor.black,
                    ),
                    horizontalTitleGap: 0,
                    title: Text(
                      'Add Location',
                      style: style.copyWith(fontSize: 17),
                    ),
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (_) {
                          return Container(
                            width: double.infinity,
                            // height: screenSize.height * 0.22,
                            padding: EdgeInsets.only(
                              left: 30,
                              right: 30,
                              top: 20,
                              bottom: MediaQuery.of(context).viewInsets.bottom,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  controller: _location,
                                  decoration: InputDecoration(
                                    hintText: 'eg. No 1 Example street',
                                    hintStyle: style.copyWith(
                                      color: AppColor.grey,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 30),
                                  child: ElevatedButton(
                                    style:
                                        ElevatedButton.styleFrom(elevation: 0),
                                    child: Text(
                                      'ADD LOCATION',
                                      style: style.copyWith(
                                        color: AppColor.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                  //
                  const Divider(height: 1, thickness: 1),

                  // import media
                  ListTile(
                    leading: Icon(
                      Icons.photo_library,
                      color: AppColor.black,
                    ),
                    horizontalTitleGap: 0,
                    title: Text(
                      ' Import Media',
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
                  //
                  const Divider(height: 1, thickness: 1),

                  // record audio
                  ListTile(
                    leading: Icon(
                      Icons.mic,
                      color: AppColor.black,
                    ),
                    horizontalTitleGap: 0,
                    title: Text(
                      'Record Audio',
                      style: style.copyWith(fontSize: 17),
                    ),
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (_) {
                          return StatefulBuilder(
                              builder: (context, StateSetter setState) {
                            return Container(
                              width: double.infinity,
                              // height: screenSize.height * 0.22,
                              padding: EdgeInsets.only(
                                left: 30,
                                right: 30,
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () => Navigator.pop(context),
                                        icon: const Icon(Icons.arrow_back),
                                      ),
                                      Expanded(child: Container()),
                                      Text(
                                        'Record Audio',
                                        style: style.copyWith(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Expanded(flex: 2, child: Container()),
                                    ],
                                  ),
                                  const Icon(
                                    Icons.mic_none_outlined,
                                    size: 150,
                                  ),
                                  StreamBuilder<RecordingDisposition>(
                                    stream: recorder.onProgress,
                                    builder: (context, snapshot) {
                                      final duration = snapshot.hasData
                                          ? snapshot.data!.duration
                                          : Duration.zero;

                                      String twoDigits(int n) =>
                                          n.toString().padLeft(2, '0');
                                      final twoDigitMinutes = twoDigits(
                                          duration.inMinutes.remainder(60));
                                      final twoDigitSeconds = twoDigits(
                                          duration.inSeconds.remainder(60));

                                      return Text(
                                        '$twoDigitMinutes: $twoDigitSeconds',
                                        style: style.copyWith(fontSize: 50),
                                      );
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: ElevatedButton(
                                      child: Icon(
                                        recorder.isRecording
                                            ? Icons.stop_circle_outlined
                                            : Icons.mic,
                                        size: 40,
                                        color: AppColor.black,
                                      ),
                                      onPressed: () async {
                                        if (recorder.isRecording) {
                                          await stop();
                                        } else {
                                          await record();
                                        }
                                        setState(() {});
                                      },
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        primary: AppColor.grey,
                                        fixedSize: const Size(80, 80),
                                        shape: const CircleBorder(),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 20,
                                    ),
                                    child: MainButton(
                                      borderColor: Colors.transparent,
                                      text: 'SAVE',
                                      backgroundColor: AppColor.darkerYellow,
                                      textColor: AppColor.black,
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  )
                                ],
                              ),
                            );
                          });
                        },
                      );
                    },
                  ),
                  //
                  const Divider(height: 1, thickness: 1),

                  // tag Agency
                  ListTile(
                    leading: Icon(
                      Icons.people_alt,
                      color: AppColor.black,
                    ),
                    horizontalTitleGap: 0,
                    title: Text(
                      'Tag Agency',
                      style: style.copyWith(fontSize: 17),
                    ),
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (_) {
                          return Container(
                            width: double.infinity,
                            // height: screenSize.height * 0.22,
                            padding: EdgeInsets.only(
                              top: 10,
                              left: 30,
                              right: 30,
                              bottom: MediaQuery.of(context).viewInsets.bottom,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  controller: _tag,
                                  decoration: InputDecoration(
                                    hintText: 'eg. Nigerial police',
                                    hintStyle: style.copyWith(
                                      color: AppColor.grey,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 30),
                                  child: ElevatedButton(
                                    child: Text(
                                      'TAG',
                                      style: style.copyWith(
                                        color: AppColor.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        tags.add(_tag.text);
                                      });
                                      _tag.clear();
                                      Navigator.pop(context);
                                    },
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        color: AppColor.white,
        child: MainButton(
          borderColor: Colors.transparent,
          text: 'POST',
          backgroundColor: AppColor.darkerYellow,
        ),
      ),
    );
  }
}
