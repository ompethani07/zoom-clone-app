import 'dart:math';

import 'package:flutter/material.dart';
import 'package:zoom_clone/resources/jisti_mettings.dart';
import 'package:zoom_clone/widgets/home_metting_buttons.dart';

class MettingScreen extends StatelessWidget {
  MettingScreen({super.key});

  final JistiMettingsMethods _jistiMettingsMethods = JistiMettingsMethods();
  createNewMeeting() async {
    var random = Random();
    String roomName = (random.nextInt(100000000) + 10000000).toString();
    _jistiMettingsMethods.createMetting(
      roomNAme: roomName,
      isAudioMuted: true,
      isVideoMuted: true,
    );
  }

  joinMeeting(BuildContext context) {
    Navigator.pushNamed(context, "/video-call");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              HomeMettingButtons(
                onPressed: createNewMeeting,
                icon: Icons.videocam,
                text: "New Metting",
              ),
              HomeMettingButtons(
                onPressed: () => joinMeeting(context),
                icon: Icons.add_box_rounded,
                text: "Join Metting",
              ),
              HomeMettingButtons(
                onPressed: () {},
                icon: Icons.calendar_today,
                text: "Schedule",
              ),
              HomeMettingButtons(
                onPressed: () {},
                icon: Icons.screen_share_outlined,
                text: "Share Screen",
              ),
            ],
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              "Create/Join Mettings with just a click!",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
