import '/flutter_flow/flutter_flow_util.dart';
import 'ordem_servico_page_widget.dart' show OrdemServicoPageWidget;
import 'package:flutter/material.dart';

class OrdemServicoPageModel extends FlutterFlowModel<OrdemServicoPageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  String? statusSelecionado;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
