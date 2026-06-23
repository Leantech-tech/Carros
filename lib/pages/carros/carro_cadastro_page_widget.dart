import '/backend/api/database.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'carro_cadastro_page_model.dart';
export 'carro_cadastro_page_model.dart';

class CarroCadastroPageWidget extends StatefulWidget {
  const CarroCadastroPageWidget({
    super.key,
    this.carro,
    this.onUpdate,
  });

  final CarroRow? carro;
  final VoidCallback? onUpdate;

  static String routeName = 'CarroCadastroPage';
  static String routePath = '/carroCadastroPage';

  @override
  State<CarroCadastroPageWidget> createState() =>
      _CarroCadastroPageWidgetState();
}

class _CarroCadastroPageWidgetState extends State<CarroCadastroPageWidget> {
  late CarroCadastroPageModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CarroCadastroPageModel());

    _model.nomeController ??= TextEditingController();
    _model.nomeFocusNode ??= FocusNode();

    _model.placaController ??= TextEditingController();
    _model.placaFocusNode ??= FocusNode();

    _model.dataController ??= TextEditingController();
    _model.dataFocusNode ??= FocusNode();

    _model.descricaoController ??= TextEditingController();
    _model.descricaoFocusNode ??= FocusNode();

    _model.contatoController ??= TextEditingController();
    _model.contatoFocusNode ??= FocusNode();

    if (widget.carro != null) {
      _model.setFromCarro(widget.carro!);
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
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 20.0, 24.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 24.0,
                      ),
                      onPressed: () {
                        if (widget.onUpdate != null) {
                          widget.onUpdate!();
                        } else {
                          context.pop();
                        }
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.check,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 28.0,
                      ),
                      onPressed: () async {
                        if (_model.nomeController!.text.isEmpty ||
                            _model.descricaoController!.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Preencha os campos obrigatórios.'),
                            ),
                          );
                          return;
                        }

                        try {
                          if (widget.carro != null) {
                            final nomeCompleto = _model.placaController!.text.isNotEmpty
                                ? '${_model.nomeController!.text} ${_model.placaController!.text}'
                                : _model.nomeController!.text;
                            await CarroTable().update(
                              data: {
                                'nome': nomeCompleto,
                                'data': DateFormat('yyyy-MM-dd').format(_model.selectedDate ?? DateTime.now()),
                                'historico': _model.descricaoController!.text,
                                'contato': _model.contatoController!.text,
                              },
                              matchingRows: (q) =>
                                  q.eq('id', widget.carro!.id),
                            );
                          } else {
                            final nomeCompleto = _model.placaController!.text.isNotEmpty
                                ? '${_model.nomeController!.text} ${_model.placaController!.text}'
                                : _model.nomeController!.text;
                             await CarroTable().insert({
                              'nome': nomeCompleto,
                              'data': DateFormat('yyyy-MM-dd').format(_model.selectedDate ?? DateTime.now()),
                              'historico': _model.descricaoController!.text,
                              'contato': _model.contatoController!.text,
                            });
                          }

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(widget.carro != null
                                  ? 'Registro atualizado com sucesso!'
                                  : 'Registro criado com sucesso!'),
                              backgroundColor: Colors.green,
                            ),
                          );
                          if (widget.onUpdate != null) {
                            widget.onUpdate!();
                          } else {
                            context.pop();
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Erro ao salvar: $e'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  child: Container(
                    width: double.infinity,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            24.0, 10.0, 24.0, 40.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            LayoutBuilder(
                              builder: (context, constraints) {
                                if (constraints.maxWidth < 600) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      _buildField(
                                        label: 'Nome do Veículo',
                                        controller: _model.nomeController,
                                        focusNode: _model.nomeFocusNode,
                                        hint: 'Ex: Corola ABC 1234',
                                      ),
                                      const SizedBox(height: 16.0),
                                      _buildDateField(),
                                    ],
                                  );
                                }
                                return Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: _buildField(
                                        label: 'Nome do Veículo',
                                        controller: _model.nomeController,
                                        focusNode: _model.nomeFocusNode,
                                        hint: 'Ex: Corola ABC 1234',
                                      ),
                                    ),
                                    const SizedBox(width: 16.0),
                                    Expanded(
                                      flex: 1,
                                      child: _buildDateField(),
                                    ),
                                  ],
                                );
                              },
                            ),
                            const SizedBox(height: 16.0),
                            _buildField(
                              label: 'Contato',
                              controller: _model.contatoController,
                              focusNode: _model.contatoFocusNode,
                              hint: 'Nome ou telefone do cliente',
                            ),
                            const SizedBox(height: 16.0),
                            _buildField(
                              label: 'Descrição do Serviço',
                              controller: _model.descricaoController,
                              focusNode: _model.descricaoFocusNode,
                              hint: 'Detalhes do que foi realizado...',
                              maxLines: 24,
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

  Widget _buildDateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Data do Serviço',
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                letterSpacing: 0.0,
              ),
        ),
        const SizedBox(height: 8.0),
        InkWell(
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: _model.selectedDate ?? DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
              locale: const Locale('pt', 'BR'),
              builder: (context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: ColorScheme.light(
                      primary: FlutterFlowTheme.of(context).secondaryText, // Header background color
                      onPrimary: Colors.white, // Header text color
                      onSurface: FlutterFlowTheme.of(context).primaryText, // Body text color
                    ),
                    textButtonTheme: TextButtonThemeData(
                      style: TextButton.styleFrom(
                        foregroundColor: FlutterFlowTheme.of(context).primaryText, // Button text color
                      ),
                    ),
                  ),
                  child: child!,
                );
              },
            );
            if (date != null) {
              setState(() {
                _model.selectedDate = date;
                _model.dataController?.text = DateFormat('dd/MM/yyyy').format(date);
              });
            }
          },
          child: TextFormField(
            controller: _model.dataController,
            focusNode: _model.dataFocusNode,
            autofocus: false,
            readOnly: true,
            enabled: false,
            style: FlutterFlowTheme.of(context).bodyLarge.override(
                  fontFamily: 'Inter',
                  letterSpacing: 0.0,
                ),
            decoration: InputDecoration(
              hintText: 'Selecione a data',
              hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                    fontFamily: 'Inter',
                    letterSpacing: 0.0,
                  ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: FlutterFlowTheme.of(context).alternate,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(12.0),
              ),
              filled: true,
              fillColor: FlutterFlowTheme.of(context).secondaryBackground,
              contentPadding:
                  EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildField({
    required String label,
    required TextEditingController? controller,
    required FocusNode? focusNode,
    required String hint,
    int maxLines = 1,
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
          maxLines: maxLines,
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
