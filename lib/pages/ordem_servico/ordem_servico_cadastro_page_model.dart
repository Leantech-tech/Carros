import '/backend/supabase/database/database.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class OrdemServicoCadastroPageModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Property to hold the OS being edited
  OsRow? ordemServico;

  // State field(s) for numero widget.
  FocusNode? numeroFocusNode;
  TextEditingController? numeroController;
  String? Function(BuildContext, String?)? numeroControllerValidator;
  

  
  // State field(s) for kmVeiculo widget.
  FocusNode? kmVeiculoFocusNode;
  TextEditingController? kmVeiculoController;
  String? Function(BuildContext, String?)? kmVeiculoControllerValidator;
  
  // State field(s) for dataEntrada widget.
  DateTime? dataEntrada;
  
  // State field(s) for dataPrevisao widget.
  DateTime? dataPrevisao;
  
  // State field(s) for dataConclusao widget.
  DateTime? dataConclusao;
  

  
  // State field(s) for descricao widget.
  FocusNode? descricaoFocusNode;
  TextEditingController? descricaoController;
  String? Function(BuildContext, String?)? descricaoControllerValidator;
  
  // State field(s) for valorMaoObra widget.
  FocusNode? valorMaoObraFocusNode;
  TextEditingController? valorMaoObraController;
  String? Function(BuildContext, String?)? valorMaoObraControllerValidator;
  
  // State field(s) for valorPeca widget.
  FocusNode? valorPecaFocusNode;
  TextEditingController? valorPecaController;
  String? Function(BuildContext, String?)? valorPecaControllerValidator;
  
  // State field(s) for valorTotal widget.
  FocusNode? valorTotalFocusNode;
  TextEditingController? valorTotalController;
  String? Function(BuildContext, String?)? valorTotalControllerValidator;
  
  // State field(s) for observacao widget.
  FocusNode? observacaoFocusNode;
  TextEditingController? observacaoController;
  String? Function(BuildContext, String?)? observacaoControllerValidator;

  // State field(s) for mecanicoResponsavel widget.
  FocusNode? mecanicoResponsavelFocusNode;
  TextEditingController? mecanicoResponsavelController;
  String? Function(BuildContext, String?)? mecanicoResponsavelControllerValidator;

  // Status selecionado
  String? statusSelecionado;

  @override
  void initState(BuildContext context) {}

  void setFromOrdemServico(OsRow os) {
    ordemServico = os;
    numeroController?.text = os.numero;
    kmVeiculoController?.text = os.kmVeiculo?.toString() ?? '';
    dataEntrada = os.dataEntrada;
    dataPrevisao = os.dataPrevisao;
    dataConclusao = os.dataConclusao;

    descricaoController?.text = os.descricao ?? '';
    valorMaoObraController?.text = os.valorMaoObra?.toString() ?? '';
    valorPecaController?.text = os.valorPeca?.toString() ?? '';
    valorTotalController?.text = os.valorTotal?.toString() ?? '';
    observacaoController?.text = os.observacao ?? '';
    mecanicoResponsavelController?.text = os.mecanicoResponsavel ?? '';
    statusSelecionado = os.status;
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    numeroFocusNode?.dispose();
    numeroController?.dispose();



    kmVeiculoFocusNode?.dispose();
    kmVeiculoController?.dispose();



    descricaoFocusNode?.dispose();
    descricaoController?.dispose();

    valorMaoObraFocusNode?.dispose();
    valorMaoObraController?.dispose();

    valorPecaFocusNode?.dispose();
    valorPecaController?.dispose();

    valorTotalFocusNode?.dispose();
    valorTotalController?.dispose();

    observacaoFocusNode?.dispose();
    observacaoController?.dispose();

    mecanicoResponsavelFocusNode?.dispose();
    mecanicoResponsavelController?.dispose();
  }
}
