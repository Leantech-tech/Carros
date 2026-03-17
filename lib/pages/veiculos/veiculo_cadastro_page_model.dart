import '/backend/supabase/database/database.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class VeiculoCadastroPageModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Property to hold the vehicle being edited
  VeiculoRow? veiculo;

  // State field(s) for placa widget.
  FocusNode? placaFocusNode;
  TextEditingController? placaController;
  String? Function(BuildContext, String?)? placaControllerValidator;

  // State field(s) for modelo widget.
  FocusNode? modeloFocusNode;
  TextEditingController? modeloController;
  String? Function(BuildContext, String?)? modeloControllerValidator;

  @override
  void initState(BuildContext context) {}

  void setFromVeiculo(VeiculoRow v) {
    veiculo = v;
    placaController?.text = v.placa;
    modeloController?.text = v.modelo;
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    placaFocusNode?.dispose();
    placaController?.dispose();

    modeloFocusNode?.dispose();
    modeloController?.dispose();
  }
}
