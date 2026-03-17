import '/backend/supabase/database/database.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'veiculo_cadastro_page_model.dart';
export 'veiculo_cadastro_page_model.dart';

class VeiculoCadastroPageWidget extends StatefulWidget {
  const VeiculoCadastroPageWidget({
    super.key,
    this.veiculo,
  });

  final VeiculoRow? veiculo;

  static String routeName = 'VeiculoCadastroPage';
  static String routePath = '/veiculoCadastroPage';

  @override
  State<VeiculoCadastroPageWidget> createState() =>
      _VeiculoCadastroPageWidgetState();
}

class _VeiculoCadastroPageWidgetState extends State<VeiculoCadastroPageWidget> {
  late VeiculoCadastroPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => VeiculoCadastroPageModel());

    _model.placaController ??= TextEditingController();
    _model.placaFocusNode ??= FocusNode();

    _model.modeloController ??= TextEditingController();
    _model.modeloFocusNode ??= FocusNode();

    if (widget.veiculo != null) {
      _model.setFromVeiculo(widget.veiculo!);
    }
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF1D2428),
                Color(0xFF262D34),
              ],
              stops: [0.0, 1.0],
              begin: AlignmentDirectional(0.87, -1.0),
              end: AlignmentDirectional(-0.87, 1.0),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 60.0, 24.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.white,
                        size: 24.0,
                      ),
                      onPressed: () => context.pop(),
                    ),
                    Expanded(
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 0.0),
                        child: Text(
                          widget.veiculo != null
                              ? 'Editar Veículo'
                              : 'Cadastro de Veículo',
                          style: FlutterFlowTheme.of(context)
                              .displaySmall
                              .override(
                                fontFamily: 'Inter Tight',
                                color: Colors.white,
                                fontSize: 24.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 0.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0.0),
                        bottomRight: Radius.circular(0.0),
                        topLeft: Radius.circular(32.0),
                        topRight: Radius.circular(32.0),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            24.0, 30.0, 24.0, 40.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Informações do Veículo',
                              style: FlutterFlowTheme.of(context)
                                  .headlineSmall
                                  .override(
                                    fontFamily: 'Inter Tight',
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                            const SizedBox(height: 20.0),
                            _buildField(
                              label: 'Placa',
                              controller: _model.placaController,
                              focusNode: _model.placaFocusNode,
                              hint: 'Ex: ABC-1234',
                            ),
                            const SizedBox(height: 16.0),
                            _buildField(
                              label: 'Modelo',
                              controller: _model.modeloController,
                              focusNode: _model.modeloFocusNode,
                              hint: 'Ex: Corolla',
                            ),
                            const SizedBox(height: 40.0),
                            FFButtonWidget(
                              onPressed: () async {
                                if (_model.placaController!.text.isEmpty ||
                                    _model.modeloController!.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Preencha Placa e Modelo.'),
                                    ),
                                  );
                                  return;
                                }

                                try {
                                  if (widget.veiculo != null) {
                                    // Update logic
                                    await VeiculoTable().update(
                                      data: {
                                        'placa': _model.placaController!.text,
                                        'modelo': _model.modeloController!.text,
                                        'atualizado_em':
                                            DateTime.now().toUtc().toIso8601String(),
                                      },
                                      matchingRows: (q) =>
                                          q.eq('id', widget.veiculo!.id),
                                    );
                                  } else {
                                    // Insert logic
                                    await VeiculoTable().insert({
                                      'placa': _model.placaController!.text,
                                      'marca': '', // Mandatory field in Supabase? Setting to empty.
                                      'modelo': _model.modeloController!.text,
                                      'criado_em':
                                          DateTime.now().toUtc().toIso8601String(),
                                      'atualizado_em':
                                          DateTime.now().toUtc().toIso8601String(),
                                    });
                                  }

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(widget.veiculo != null
                                          ? 'Veículo atualizado com sucesso!'
                                          : 'Veículo cadastrado com sucesso!'),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                  context.pop();
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Erro ao salvar: $e'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              },
                              text: widget.veiculo != null
                                  ? 'Salvar Alterações'
                                  : 'Salvar Veículo',
                              options: FFButtonOptions(
                                width: double.infinity,
                                height: 55.0,
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    24.0, 0.0, 24.0, 0.0),
                                iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: Color(0xFF1A1C1E),
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'Inter Tight',
                                      color: Colors.white,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                elevation: 3.0,
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField({
    required String label,
    required TextEditingController? controller,
    required FocusNode? focusNode,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                letterSpacing: 0.0,
              ),
        ),
        const SizedBox(height: 8.0),
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          autofocus: false,
          obscureText: false,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          style: FlutterFlowTheme.of(context).bodyLarge.override(
                fontFamily: 'Inter',
                letterSpacing: 0.0,
              ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                  fontFamily: 'Inter',
                  letterSpacing: 0.0,
                ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: FlutterFlowTheme.of(context).alternate,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFF1D2428),
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: FlutterFlowTheme.of(context).error,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: FlutterFlowTheme.of(context).error,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            filled: true,
            fillColor: FlutterFlowTheme.of(context).secondaryBackground,
            contentPadding:
                EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
          ),
        ),
      ],
    );
  }
}
