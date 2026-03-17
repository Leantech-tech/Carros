import '/backend/supabase/database/database.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'ordem_servico_page_model.dart';
export 'ordem_servico_page_model.dart';

class OrdemServicoPageWidget extends StatefulWidget {
  const OrdemServicoPageWidget({super.key});

  static String routeName = 'OrdemServicoPage';
  static String routePath = '/ordemServicoPage';

  @override
  State<OrdemServicoPageWidget> createState() => _OrdemServicoPageWidgetState();
}

class _OrdemServicoPageWidgetState extends State<OrdemServicoPageWidget> {
  late OrdemServicoPageModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OrdemServicoPageModel());
    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
    _model.statusSelecionado = 'Todos';
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.pushNamed('OrdemServicoCadastroPage');
          },
          backgroundColor: Color(0xFF1A1C1E),
          elevation: 8.0,
          child: Icon(
            Icons.add_rounded,
            color: Colors.white,
            size: 28.0,
          ),
        ),
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
                padding: EdgeInsetsDirectional.fromSTEB(24.0, 60.0, 24.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Text(
                        'Ordens de Serviço',
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
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(24.0, 30.0, 24.0, 0.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 12.0,
                        color: Color(0x33000000),
                        offset: Offset(0.0, 5.0),
                      )
                    ],
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 4.0, 16.0, 4.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(
                          Icons.search_rounded,
                          color: FlutterFlowTheme.of(context).secondaryText,
                          size: 24.0,
                        ),
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                12.0, 0.0, 0.0, 0.0),
                            child: TextFormField(
                              controller: _model.textController,
                              focusNode: _model.textFieldFocusNode,
                              onChanged: (_) => setState(() {}),
                              autofocus: false,
                              obscureText: false,
                              decoration: InputDecoration(
                                hintText: 'Número, Modelo ou Placa...',
                                hintStyle: FlutterFlowTheme.of(context)
                                    .bodyLarge
                                    .override(
                                      fontFamily: 'Inter',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      letterSpacing: 0.0,
                                      fontSize: 14.0,
                                    ),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyLarge
                                  .override(
                                    fontFamily: 'Inter',
                                    letterSpacing: 0.0,
                                  ),
                              validator: _model.textControllerValidator
                                  .asValidator(context),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Container(
                            width: 1.0,
                            height: 30.0,
                            color: Color(0xFFE0E3E7),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: _model.statusSelecionado,
                                isExpanded: true,
                                icon: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: FlutterFlowTheme.of(context).secondaryText,
                                ),
                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                      fontFamily: 'Inter',
                                      letterSpacing: 0.0,
                                    ),
                                items: <String>[
                                  'Todos',
                                  'Pendente',
                                  'Em Andamento',
                                  'Concluido',
                                  'Cancelado'
                                ].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _model.statusSelecionado = newValue;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(24.0, 20.0, 24.0, 0.0),
                      child: FutureBuilder<List<dynamic>>(
                        future: Future.wait([
                          OsTable().queryRows(queryFn: (q) => q),
                          VeiculoTable().queryRows(queryFn: (q) => q),
                        ]),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(
                                color: FlutterFlowTheme.of(context).primary,
                              ),
                            );
                          }
                          List<OsRow> ordensServico = snapshot.data![0] as List<OsRow>;
                          List<VeiculoRow> veiculos = snapshot.data![1] as List<VeiculoRow>;
                          
                          final veiculoMap = {for (var v in veiculos) v.id: v};

                          // Apply local filtering
                          if (_model.textController?.text != null &&
                              _model.textController!.text.isNotEmpty) {
                            final searchText = _model.textController!.text.toLowerCase();
                            ordensServico = ordensServico.where((os) {
                              final veiculo = veiculoMap[os.veiculoId];
                              final matchesNumero = os.numero.toLowerCase().contains(searchText);
                              final matchesModelo = veiculo?.modelo.toLowerCase().contains(searchText) ?? false;
                              final matchesPlaca = veiculo?.placa.toLowerCase().contains(searchText) ?? false;
                              return matchesNumero || matchesModelo || matchesPlaca;
                            }).toList();
                          }

                          if (_model.statusSelecionado != null &&
                              _model.statusSelecionado != 'Todos') {
                            ordensServico = ordensServico
                                .where((os) => 
                                    os.status == _model.statusSelecionado)
                                .toList();
                          }


                          if (ordensServico.isEmpty) {
                            return Center(
                              child: Text('Nenhuma ordem de serviço encontrada.'),
                            );
                          }

                          return ListView.separated(
                            padding: const EdgeInsets.only(bottom: 100.0),
                            itemCount: ordensServico.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 16.0),
                            itemBuilder: (context, index) {
                              final ordemServico = ordensServico[index];
                              final veiculo = veiculoMap[ordemServico.veiculoId];
                              
                              return GestureDetector(
                                onTap: () {
                                  context.pushNamed(
                                    'OrdemServicoCadastroPage',
                                    extra: <String, dynamic>{
                                      'ordemServico': ordemServico,
                                    },
                                  );
                                },
                                onLongPress: () async {
                                  final confirm = await showDialog<bool>(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text('Confirmar Exclusão'),
                                      content: Text('Deseja excluir a OS #${ordemServico.numero}?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(context, false),
                                          child: Text('Cancelar'),
                                        ),
                                        TextButton(
                                          onPressed: () => Navigator.pop(context, true),
                                          child: Text('Excluir', style: TextStyle(color: Colors.red)),
                                        ),
                                      ],
                                    ),
                                  );
                                  if (confirm == true) {
                                    await OsTable().delete(
                                      matchingRows: (q) => q.eq('id', ordemServico.id),
                                    );
                                    setState(() {});
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('OS excluída com sucesso!'),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 10.0,
                                        color: Color(0x11000000),
                                        offset: Offset(0.0, 4.0),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(20.0),
                                    border: Border.all(
                                      color: Color(0x0D000000),
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Container(
                                          width: 60.0,
                                          height: 60.0,
                                          decoration: BoxDecoration(
                                            color: Color(0xFFF1F4F8),
                                            borderRadius:
                                                BorderRadius.circular(16.0),
                                          ),
                                          child: Icon(
                                            Icons.assignment_rounded,
                                            color: Color(0xFF1D2428),
                                            size: 30.0,
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(16.0, 0.0, 0.0, 0.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    if (veiculo != null)
                                                      Text(
                                                        veiculo.placa,
                                                        style: FlutterFlowTheme.of(context).headlineSmall.override(
                                                          fontFamily: 'Inter Tight',
                                                          fontSize: 20.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    Text(
                                                      'OS #${ordemServico.numero}',
                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                        fontFamily: 'Inter',
                                                        fontSize: 14.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight: FontWeight.normal,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                if (veiculo != null)
                                                  Padding(
                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 2.0, 0.0, 0.0),
                                                    child: Text(
                                                      veiculo.modelo,
                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                        fontFamily: 'Inter',
                                                        color: FlutterFlowTheme.of(context).primary,
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 14.0,
                                                      ),
                                                    ),
                                                  ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 4.0, 0.0, 0.0),
                                                  child: Text(
                                                    ordemServico.descricao ?? 'Sem descrição',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          color:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .secondaryText,
                                                          letterSpacing: 0.0,
                                                        ),
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 8.0, 0.0, 0.0),
                                                  child: Container(
                                                    padding: EdgeInsets.symmetric(
                                                      horizontal: 8.0,
                                                      vertical: 4.0,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: _getStatusColor(ordemServico.status),
                                                      borderRadius: BorderRadius.circular(8.0),
                                                    ),
                                                    child: Text(
                                                      ordemServico.status ?? 'Pendente',
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodySmall
                                                              .override(
                                                                fontFamily:
                                                                    'Inter',
                                                                color: Colors.white,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FontWeight.w500,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 1,
          onTap: (index) {
            if (index == 0) {
              context.pushNamed('HomePage');
            } else if (index == 2) {
              context.pushNamed('VeiculosPage');
            } else if (index == 3) {
              context.pushNamed('PerfilPage');
            }
          },
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_rounded),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment_rounded),
              label: 'OS',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.directions_car),
              label: 'Veículos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Perfil',
            ),
          ],
          selectedItemColor: FlutterFlowTheme.of(context).primary,
          unselectedItemColor: FlutterFlowTheme.of(context).secondaryText,
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        ),
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'concluído':
      case 'concluido':
        return Color(0xFF10B981);
      case 'em andamento':
        return Color(0xFF3B82F6);
      case 'cancelado':
        return Color(0xFFEF4444);
      case 'pendente':
      default:
        return Color(0xFFF59E0B);
    }
  }
}
