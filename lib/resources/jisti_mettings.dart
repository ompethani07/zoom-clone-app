import 'package:flutter/material.dart';
import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';
import 'package:zoom_clone/resources/auth_methods.dart';
import 'dart:math';

import 'package:zoom_clone/resources/firestore_methods.dart';

class JistiMettingsMethods {
  final AuthMethods _authMethods = AuthMethods();
  final FirestoreMethods _firestoremethods = FirestoreMethods();

  String generateUniqueRoomName() {
    final random = Random();
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final userId = _authMethods.user.uid;
    return 'meeting_${userId}_$timestamp${random.nextInt(10000)}';
  }

  void createMetting({
    required String roomNAme,
    required bool isAudioMuted,
    required bool isVideoMuted,
    String userNAme = "",
  }) async {
    try {
      String name;
      if (userNAme.isEmpty) {
        name = _authMethods.user.displayName!;
      } else {
        name = userNAme;
      }
      String roomName;
      if (roomNAme.isNotEmpty) {
        roomName = roomNAme;
      } else {
        final uniqueRoomName = generateUniqueRoomName();
        roomName = uniqueRoomName;
      }
      var options = JitsiMeetingOptions(
        roomNameOrUrl: roomName,
        userDisplayName: name,
        userEmail: _authMethods.user.email,
        userAvatarUrl: _authMethods.user.photoURL,
        isAudioMuted: isAudioMuted,
        isVideoMuted: isVideoMuted,
      );
      _firestoremethods.addToMeetingHistory(roomNAme);
      await JitsiMeetWrapper.joinMeeting(
        options: options,
        listener: JitsiMeetingListener(),
      );
    } catch (error) {
      debugPrint("error: $error");
    }
  }
}
