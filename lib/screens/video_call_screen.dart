import 'package:flutter/material.dart';
import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';
import 'package:zoom_clone/resources/auth_methods.dart';
import 'package:zoom_clone/resources/jisti_mettings.dart';
import 'package:zoom_clone/utils/colors.dart';
import 'package:zoom_clone/widgets/metting_option.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  late TextEditingController mettingIdController;
  final AuthMethods _authMethods = AuthMethods();
  late TextEditingController nameController;
  final JistiMettingsMethods _jistiMettingsMethods = JistiMettingsMethods();
  bool isAudioMuted = true;
  bool isVideoMuted = true;
  @override
  void initState() {
    mettingIdController = TextEditingController();
    nameController = TextEditingController(text: _authMethods.user.displayName);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    mettingIdController.dispose();
    nameController.dispose();
    // JitsiMeetWrapper.removeAllJitsiMeetListeners();
  }

  _joinMetting() {
    _jistiMettingsMethods.createMetting(
      roomNAme: mettingIdController.text,
      isAudioMuted: isAudioMuted,
      isVideoMuted: isVideoMuted,
      userNAme: nameController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        title: const Text("Join a Meeting", style: TextStyle(fontSize: 18)),
        centerTitle: true,
      ),

      body: Column(
        children: [
          SizedBox(
            height: 60,
            child: TextField(
              controller: mettingIdController,
              maxLines: 1,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                fillColor: secondaryBackgroundColor,
                filled: true,
                border: InputBorder.none,
                hintText: "Room Id",
                contentPadding: EdgeInsets.fromLTRB(16, 8, 0, 0),
              ),
            ),
          ),
          SizedBox(
            height: 60,
            child: TextField(
              controller: nameController,
              maxLines: 1,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                fillColor: secondaryBackgroundColor,
                filled: true,
                border: InputBorder.none,
                hintText: "Name",
                contentPadding: EdgeInsets.fromLTRB(16, 8, 0, 0),
              ),
            ),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: _joinMetting,
            child: const Padding(
              padding: EdgeInsetsGeometry.all(8),
              child: Text("Join", style: TextStyle(fontSize: 16)),
            ),
          ),
          const SizedBox(height: 20),

          MettingOption(
            text: "Mute Audo",
            isMute: isAudioMuted,
            onChange: onAudoMuted,
          ),
          MettingOption(
            text: "Muted Video",
            isMute: isVideoMuted,
            onChange: onVideoMuted,
          ),
        ],
      ),
    );
  }

  onAudoMuted(bool val) {
    setState(() {
      isAudioMuted = val;
    });
  }

  onVideoMuted(bool val) {
    setState(() {
      isVideoMuted = val;
    });
  }
}
