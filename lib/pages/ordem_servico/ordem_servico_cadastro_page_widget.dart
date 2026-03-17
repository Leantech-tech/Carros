import '/backend/supabase/database/database.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'ordem_servico_cadastro_page_model.dart';
export 'ordem_servico_cadastro_page_model.dart';

class OrdemServicoCadastroPageWidget extends StatefulWidget {
  const OrdemServicoCadastroPageWidget({
    super.key,
    this.ordemServico,
  });

  final OsRow? ordemServico;

  static String routeName = 'OrdemServicoCadastroPage';
  static String routePath = '/ordemServicoCadastroPage';

  @override
  State<OrdemServicoCadastroPageWidget> createState() =>
      _OrdemServicoCadastroPageWidgetState();
}

class _OrdemServicoCadastroPageWidgetState extends State<OrdemServicoCadastroPageWidget> {
  late OrdemServicoCadastroPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  
  List<VeiculoRow> _veiculos = [];
  VeiculoRow? _veiculoSelecionado;
  final TextEditingController _veiculoSearchController = TextEditingController();

  final List<String> _statusOptions = [
    'Pendente',
    'Em Andamento',
    'Concluido',
    'Cancelado',
  ];

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OrdemServicoCadastroPageModel());

    _model.kmVeiculoController ??= TextEditingController();
    _model.kmVeiculoFocusNode ??= FocusNode();

    _model.descricaoController ??= TextEditingController();
    _model.descricaoFocusNode ??= FocusNode();

    _model.valorMaoObraController ??= TextEditingController();
    _model.valorMaoObraFocusNode ??= FocusNode();

    _model.valorPecaController ??= TextEditingController();
    _model.valorPecaFocusNode ??= FocusNode();

    _model.valorTotalController ??= TextEditingController();
    _model.valorTotalFocusNode ??= FocusNode();

    _model.observacaoController ??= TextEditingController();
    _model.observacaoFocusNode ??= FocusNode();

    _model.mecanicoResponsavelController ??= TextEditingController();
    _model.mecanicoResponsavelFocusNode ??= FocusNode();

    _model.statusSelecionado = 'Concluido';
    _model.dataEntrada = DateTime.now();
    _model.dataConclusao = _model.dataEntrada;

    if (widget.ordemServico != null) {
      _model.setFromOrdemServico(widget.ordemServico!);
    }

    // Add listeners to calculate total automatically
    _model.valorMaoObraController!.addListener(_calcularValorTotal);
    _model.valorPecaController!.addListener(_calcularValorTotal);
    
    _loadVeiculos();
  }

  Future<void> _loadVeiculos() async {
    try {
      final veiculos = await VeiculoTable().queryRows(queryFn: (q) => q.neq('is_excluido', true));
      setState(() {
        _veiculos = veiculos;
        // If editing, find the selected vehicle
        if (widget.ordemServico?.veiculoId != null) {
          try {
            _veiculoSelecionado = _veiculos.firstWhere(
              (v) => v.id == widget.ordemServico!.veiculoId,
            );
            if (_veiculoSelecionado != null) {
              _veiculoSearchController.text = '${_veiculoSelecionado!.modelo} - ${_veiculoSelecionado!.placa}';
            }
          } catch (_) {
            _veiculoSelecionado = null;
          }
        }
      });
    } catch (e) {
      // Handle error
    }
  }

  void _calcularValorTotal() {
    final maoObra = double.tryParse(_model.valorMaoObraController!.text) ?? 0.0;
    final peca = double.tryParse(_model.valorPecaController!.text) ?? 0.0;
    final total = maoObra + peca;
    _model.valorTotalController!.text = total.toStringAsFixed(2);
  }

  @override
  void dispose() {
    _model.dispose();
    _veiculoSearchController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, String tipo) async {
    DateTime initialDate;
    switch (tipo) {
      case 'entrada':
        initialDate = _model.dataEntrada ?? DateTime.now();
        break;
      case 'previsao':
        initialDate = _model.dataPrevisao ?? DateTime.now();
        break;
      case 'conclusao':
        initialDate = _model.dataConclusao ?? DateTime.now();
        break;
      default:
        initialDate = DateTime.now();
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      locale: const Locale('pt', 'BR'),
      helpText: 'SELECIONAR DATA',
      cancelText: 'CANCELAR',
      confirmText: 'OK',
      fieldLabelText: 'Insira a data',
      fieldHintText: 'dd/mm/aaaa',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Color(0xFF1D2428),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Color(0xFF1D2428),
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final normalizedPicked = DateTime(picked.year, picked.month, picked.day, 12, 0, 0);
      setState(() {
        switch (tipo) {
          case 'entrada':
            _model.dataEntrada = normalizedPicked;
            _model.dataConclusao = normalizedPicked;
            break;
          case 'previsao':
            _model.dataPrevisao = normalizedPicked;
            break;
          case 'conclusao':
            _model.dataConclusao = normalizedPicked;
            _model.dataEntrada = normalizedPicked;
            break;
        }
      });
    }
  }

  Future<void> _salvarOS() async {
    try {
      // Validate if vehicle is selected
      if (_veiculoSelecionado == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Por favor, selecione um veículo.'),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }

      // Let the database generate the number using the trigger
    final String? numero = widget.ordemServico?.numero;
      
      if (widget.ordemServico != null) {
        // Update existing
        await OsTable().update(
          matchingRows: (q) => q.eq('id', widget.ordemServico!.id),
          data: {
            'numero': numero,
            'veiculo_id': _veiculoSelecionado?.id,
            'km_veiculo': int.tryParse(_model.kmVeiculoController!.text),
            'data_entrada': _model.dataEntrada?.toUtc().toIso8601String(),
            'data_previsao': _model.dataPrevisao?.toUtc().toIso8601String(),
            'data_conclusao': _model.dataConclusao?.toUtc().toIso8601String(),
            'status': _model.statusSelecionado,
            'descricao': _model.descricaoController!.text,
            'valor_mao_obra': double.tryParse(_model.valorMaoObraController!.text),
            'valor_peca': double.tryParse(_model.valorPecaController!.text),
            'valor_total': double.tryParse(_model.valorTotalController!.text),
            'mecanico_responsavel': _model.mecanicoResponsavelController!.text,
            'observacao': _model.observacaoController!.text,
            'atualizado_em': DateTime.now().toUtc().toIso8601String(),
          },
        );
      } else {
        // Insert new
        await OsTable().insert({
          'numero': numero,
          'veiculo_id': _veiculoSelecionado?.id,
          'km_veiculo': int.tryParse(_model.kmVeiculoController!.text),
          'data_entrada': _model.dataEntrada?.toUtc().toIso8601String(),
          'data_previsao': _model.dataPrevisao?.toUtc().toIso8601String(),
          'data_conclusao': _model.dataConclusao?.toUtc().toIso8601String(),
          'status': _model.statusSelecionado,
          'descricao': _model.descricaoController!.text,
          'valor_mao_obra': double.tryParse(_model.valorMaoObraController!.text),
          'valor_peca': double.tryParse(_model.valorPecaController!.text),
          'valor_total': double.tryParse(_model.valorTotalController!.text),
          'mecanico_responsavel': _model.mecanicoResponsavelController!.text,
          'observacao': _model.observacaoController!.text,
          'criado_em': DateTime.now().toUtc().toIso8601String(),
          'atualizado_em': DateTime.now().toUtc().toIso8601String(),
        });
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('OS salva com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
      context.pop();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao salvar OS: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'Selecionar data';
    return DateFormat('dd/MM/yyyy').format(date);
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
                          widget.ordemServico != null
                              ? 'Editar OS'
                              : 'Nova Ordem de Serviço',
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
                              'Informações da OS',
                              style: FlutterFlowTheme.of(context)
                                  .headlineSmall
                                  .override(
                                    fontFamily: 'Inter Tight',
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                            const SizedBox(height: 20.0),
                            // Veículo
                            _buildVeiculoSearch(),
                            const SizedBox(height: 16.0),
                            // Row: Km + Data Entrada
                            Row(
                              children: [
                                Expanded(
                                  child: _buildField(
                                    label: 'Km do Veículo',
                                    controller: _model.kmVeiculoController,
                                    focusNode: _model.kmVeiculoFocusNode,
                                    hint: 'Ex: 50000',
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                                const SizedBox(width: 12.0),
                                Expanded(
                                  child: _buildDateField(
                                    label: 'Data Entrada',
                                    value: _model.dataEntrada,
                                    onTap: () => _selectDate(context, 'entrada'),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 32.0),
                            Text(
                              'Serviço',
                              style: FlutterFlowTheme.of(context)
                                  .headlineSmall
                                  .override(
                                    fontFamily: 'Inter Tight',
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                            const SizedBox(height: 20.0),
                            _buildDescricaoField(),
                            const SizedBox(height: 32.0),
                            Text(
                              'Responsável',
                              style: FlutterFlowTheme.of(context)
                                  .headlineSmall
                                  .override(
                                    fontFamily: 'Inter Tight',
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                            const SizedBox(height: 16.0),
                            _buildField(
                              label: 'Mecânico Responsável',
                              controller: _model.mecanicoResponsavelController,
                              focusNode: _model.mecanicoResponsavelFocusNode,
                              hint: 'Nome do mecânico',
                            ),
                            const SizedBox(height: 16.0),
                            _buildField(
                              label: 'Observações',
                              controller: _model.observacaoController,
                              focusNode: _model.observacaoFocusNode,
                              hint: 'Observações adicionais...',
                              maxLines: 3,
                            ),
                            const SizedBox(height: 40.0),
                            FFButtonWidget(
                              onPressed: _salvarOS,
                              text: 'Salvar',
                              options: FFButtonOptions(
                                width: double.infinity,
                                height: 56.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: Color(0xFF1D2428),
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

  Widget _buildVeiculoSearch() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Veículo',
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                letterSpacing: 0.0,
              ),
        ),
        const SizedBox(height: 8.0),
        InkWell(
          onTap: () => _showVeiculoSearchDialog(),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            decoration: BoxDecoration(
              color: Color(0xFFF1F4F8),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _veiculoSelecionado != null
                        ? '${_veiculoSelecionado!.modelo} - ${_veiculoSelecionado!.placa}'
                        : 'Selecione um veículo',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Inter',
                          color: _veiculoSelecionado == null
                              ? FlutterFlowTheme.of(context).secondaryText
                              : FlutterFlowTheme.of(context).primaryText,
                        ),
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: FlutterFlowTheme.of(context).secondaryText,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showVeiculoSearchDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.7,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: 50,
                    height: 5,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: TextField(
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: 'Pesquisar por modelo ou placa...',
                        prefixIcon: Icon(Icons.search),
                        filled: true,
                        fillColor: Color(0xFFF1F4F8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (value) {
                        setModalState(() {
                          // Filter list
                        });
                      },
                      controller: _veiculoSearchController,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _veiculos.length,
                      itemBuilder: (context, index) {
                        final veiculo = _veiculos[index];
                        final searchText = _veiculoSearchController.text.toLowerCase();
                        if (searchText.isNotEmpty &&
                            !veiculo.modelo.toLowerCase().contains(searchText) &&
                            !veiculo.placa.toLowerCase().contains(searchText)) {
                          return SizedBox.shrink();
                        }
                        return ListTile(
                          title: Text('${veiculo.modelo} - ${veiculo.placa}'),
                          subtitle: Text(veiculo.marca),
                          onTap: () {
                            setState(() {
                              _veiculoSelecionado = veiculo;
                            });
                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    ).then((_) {
      // Clear search when closed
      _veiculoSearchController.clear();
      // If we have a selection, we could put it back in the controller, 
      // but we use _veiculoSelecionado for the UI anyway
    });
  }

  Widget _buildField({
    required String label,
    TextEditingController? controller,
    FocusNode? focusNode,
    String? hint,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
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
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Color(0xFFF1F4F8),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide.none,
            ),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          ),
          maxLines: maxLines,
          keyboardType: keyboardType,
        ),
      ],
    );
  }

  Widget _buildReadOnlyField({
    required String label,
    required String value,
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
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
          decoration: BoxDecoration(
            color: Color(0xFFE0E3E7),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Text(
            value,
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Inter',
                  color: FlutterFlowTheme.of(context).secondaryText,
                  letterSpacing: 0.0,
                ),
          ),
        ),
      ],
    );
  }

  Widget _buildReadOnlyDateField({
    required String label,
    DateTime? value,
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
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
          decoration: BoxDecoration(
            color: Color(0xFFE0E3E7),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  value != null ? _formatDate(value) : 'Automático',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Inter',
                        color: FlutterFlowTheme.of(context).secondaryText,
                        letterSpacing: 0.0,
                      ),
                ),
              ),
              Icon(
                Icons.lock_outline,
                size: 16.0,
                color: FlutterFlowTheme.of(context).secondaryText,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDateField({
    required String label,
    DateTime? value,
    required VoidCallback onTap,
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
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.0),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
            decoration: BoxDecoration(
              color: Color(0xFFF1F4F8),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _formatDate(value),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Inter',
                          letterSpacing: 0.0,
                        ),
                  ),
                ),
                Icon(
                  Icons.calendar_today_rounded,
                  size: 18.0,
                  color: FlutterFlowTheme.of(context).secondaryText,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _previousDescricaoText = '';

  Widget _buildDescricaoField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Descrição',
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                letterSpacing: 0.0,
              ),
        ),
        const SizedBox(height: 8.0),
        TextFormField(
          controller: _model.descricaoController,
          focusNode: _model.descricaoFocusNode,
          decoration: InputDecoration(
            hintText: 'Descreva detalhes do serviço...\nPressione Enter para criar lista',
            filled: true,
            fillColor: Color(0xFFF1F4F8),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide.none,
            ),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          ),
          maxLines: 6,
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
          onChanged: (value) {
            // Detect if a new line was just added
            if (value.length > _previousDescricaoText.length) {
              final cursorPos = _model.descricaoController!.selection.baseOffset;
              
              // Check if the character before cursor is a newline (just typed Enter)
              if (cursorPos > 0 && value[cursorPos - 1] == '\n') {
                // Insert dash after the newline
                final beforeCursor = value.substring(0, cursorPos);
                final afterCursor = value.substring(cursorPos);
                final newText = '$beforeCursor- $afterCursor';
                
                _model.descricaoController!.text = newText;
                _model.descricaoController!.selection = TextSelection.collapsed(
                  offset: cursorPos + 2, // +2 for "- "
                );
                _previousDescricaoText = newText;
                return;
              }
            }
            _previousDescricaoText = value;
          },
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    String? value,
    required List<String> items,
    required Function(String?) onChanged,
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
        Container(
          decoration: BoxDecoration(
            color: Color(0xFFF1F4F8),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: DropdownButtonFormField<String>(
            value: value,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            ),
            items: items.map((item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
