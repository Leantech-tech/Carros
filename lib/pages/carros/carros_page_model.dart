import '/flutter_flow/flutter_flow_util.dart';
import 'carros_page_widget.dart' show CarrosPageWidget;
import 'package:flutter/material.dart';

class CarrosPageModel extends FlutterFlowModel<CarrosPageWidget> {
  final unfocusNode = FocusNode();
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
