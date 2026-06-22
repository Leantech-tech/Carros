import '/backend/api/database.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class CarroCadastroPageModel extends FlutterFlowModel {
  final unfocusNode = FocusNode();
  CarroRow? carro;

  FocusNode? nomeFocusNode;
  TextEditingController? nomeController;

  FocusNode? placaFocusNode;
  TextEditingController? placaController;

  FocusNode? dataFocusNode;
  TextEditingController? dataController;
  
  FocusNode? contatoFocusNode;
  TextEditingController? contatoController;
  
  FocusNode? descricaoFocusNode;
  TextEditingController? descricaoController;
  
  DateTime? selectedDate;

  @override
  void initState(BuildContext context) {}

  void setFromCarro(CarroRow c) {
    carro = c;
    nomeController?.text = c.nomeVeiculo;
    placaController?.text = c.placa;
    selectedDate = c.dataServico;
    dataController?.text = DateFormat('dd/MM/yyyy').format(c.dataServico);
    contatoController?.text = c.contato ?? ''; 
    descricaoController?.text = c.descricao ?? '';
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    nomeFocusNode?.dispose();
    nomeController?.dispose();
    placaFocusNode?.dispose();
    placaController?.dispose();
    dataFocusNode?.dispose();
    dataController?.dispose();
    contatoFocusNode?.dispose();
    contatoController?.dispose();
    descricaoFocusNode?.dispose();
    descricaoController?.dispose();
  }
}
