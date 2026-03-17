import 'dart:typed_data';
import 'package:flutter/material.dart';
import '/backend/api_requests/api_manager.dart';
import 'backend/supabase/supabase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  String _varAppState = '';
  String get varAppState => _varAppState;
  set varAppState(String value) {
    _varAppState = value;
  }

  // Profile photo bytes for persistence during session
  Uint8List? _profilePhotoBytes;
  Uint8List? get profilePhotoBytes => _profilePhotoBytes;
  set profilePhotoBytes(Uint8List? value) {
    _profilePhotoBytes = value;
    notifyListeners();
  }
}

