import '/backend/supabase/database/database.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'veiculos_page_model.dart';
export 'veiculos_page_model.dart';

class VeiculosPageWidget extends StatefulWidget {
  const VeiculosPageWidget({super.key});

  static String routeName = 'VeiculosPage';
  static String routePath = '/veiculosPage';

  @override
  State<VeiculosPageWidget> createState() => _VeiculosPageWidgetState();
}

class _VeiculosPageWidgetState extends State<VeiculosPageWidget> {
  late VeiculosPageModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => VeiculosPageModel());
    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
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
            context.pushNamed('VeiculoCadastroPage');
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
                        'Veículos',
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
                                hintText: 'Filtrar por placa ou modelo...',
                                hintStyle: FlutterFlowTheme.of(context)
                                    .bodyLarge
                                    .override(
                                      fontFamily: 'Inter',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      letterSpacing: 0.0,
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
                      child: FutureBuilder<List<VeiculoRow>>(
                        future: VeiculoTable().queryRows(
                          queryFn: (q) => q,
                        ),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(
                                color: FlutterFlowTheme.of(context).primary,
                              ),
                            );
                          }
                          List<VeiculoRow> veiculos = snapshot.data!;

                          
                          // Filter out excluded vehicles (Soft Delete)
                          veiculos = veiculos.where((v) => !v.isExcluido).toList();

                          // Apply local filtering
                          if (_model.textController?.text != null &&
                              _model.textController!.text.isNotEmpty) {
                            final searchText = _model.textController!.text.toLowerCase();
                            veiculos = veiculos
                                .where((v) => 
                                    v.placa.toLowerCase().contains(searchText) ||
                                    v.modelo.toLowerCase().contains(searchText))
                                .toList();
                          }


                          if (veiculos.isEmpty) {
                            return Center(
                              child: Text('Nenhum veículo encontrado.'),
                            );
                          }

                          return ListView.separated(
                            padding: const EdgeInsets.only(bottom: 100.0),
                            itemCount: veiculos.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 16.0),
                            itemBuilder: (context, index) {
                              final veiculo = veiculos[index];
                              return Container(
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
                                          Icons.directions_car_rounded,
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
                                              Text(
                                                veiculo.modelo,
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .headlineSmall
                                                    .override(
                                                      fontFamily: 'Inter Tight',
                                                      fontSize: 18.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 4.0, 0.0, 0.0),
                                                child: Text(
                                                  'Placa: ${veiculo.placa}',
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
                                                  ),
                                                ),
                                              ],
                                            ),
                                        ),
                                      ),
                                      PopupMenuButton<String>(
                                        icon: Icon(
                                          Icons.more_vert_rounded,
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          size: 24.0,
                                        ),
                                        onSelected: (value) async {
                                          if (value == 'edit') {
                                            await context.pushNamed(
                                              'VeiculoCadastroPage',
                                              extra: <String, dynamic>{
                                                'veiculo': veiculo,
                                              },
                                            );
                                            setState(() {});
                                            } else if (value == 'delete') {
                                              final confirm = await showDialog<
                                                  bool>(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                  title: const Text(
                                                      'Confirmar Exclusão'),
                                                  content: const Text(
                                                      'Tem certeza que deseja excluir este veículo?'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context, false),
                                                      child: const Text(
                                                          'Cancelar'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context, true),
                                                      child: const Text(
                                                        'Excluir',
                                                        style: TextStyle(
                                                            color: Colors.red),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );

                                                if (confirm == true) {
                                                  // Soft delete implementation
                                                  await VeiculoTable().update(
                                                    data: {'is_excluido': true},
                                                    matchingRows: (q) =>
                                                        q.eq('id', veiculo.id),
                                                  );
                                                  showSnackbar(context,
                                                      'Veículo excluído com sucesso!');
                                                  setState(() {});
                                                }
                                              } else if (value == 'history') {
                                                _showVehicleHistoryDialog(veiculo);
                                              }
                                          },
                                          itemBuilder: (context) => [
                                            const PopupMenuItem(
                                              value: 'history',
                                              child: Row(
                                                children: [
                                                  Icon(Icons.history_rounded,
                                                      size: 20),
                                                  SizedBox(width: 8),
                                                  Text('Histórico'),
                                                ],
                                              ),
                                            ),
                                            const PopupMenuItem(
                                              value: 'edit',
                                              child: Row(
                                                children: [
                                                  Icon(Icons.edit_outlined,
                                                      size: 20),
                                                  SizedBox(width: 8),
                                                  Text('Editar'),
                                                ],
                                              ),
                                            ),
                                            const PopupMenuItem(
                                              value: 'delete',
                                              child: Row(
                                                children: [
                                                  Icon(Icons.delete_outline,
                                                      size: 20,
                                                      color: Colors.red),
                                                  SizedBox(width: 8),
                                                  Text('Excluir',
                                                      style: TextStyle(
                                                          color: Colors.red)),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                    ],
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
          currentIndex: 2,
          onTap: (index) {
            if (index == 0) {
              context.pushNamed('HomePage');
            } else if (index == 1) {
              context.pushNamed('OrdemServicoPage');
            } else if (index == 3) {
              context.pushNamed('CarrosPage');
            } else if (index == 4) {
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
              icon: Icon(Icons.airport_shuttle),
              label: 'Carros',
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

  void _showVehicleHistoryDialog(VeiculoRow veiculo) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24.0),
            topRight: Radius.circular(24.0),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Histórico de Serviços',
                        style: FlutterFlowTheme.of(context).headlineSmall,
                      ),
                      Text(
                        '${veiculo.modelo} - ${veiculo.placa}',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Inter',
                              color: FlutterFlowTheme.of(context).secondaryText,
                            ),
                      ),
                      if (veiculo.kmAtual != null || (veiculo.observacao != null && veiculo.observacao!.isNotEmpty))
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (veiculo.kmAtual != null)
                                Text(
                                  'KM Atual: ${veiculo.kmAtual}',
                                  style: FlutterFlowTheme.of(context).bodySmall.override(
                                        fontFamily: 'Inter',
                                        color: FlutterFlowTheme.of(context).secondaryText,
                                      ),
                                ),
                              if (veiculo.observacao != null && veiculo.observacao!.isNotEmpty)
                                Text(
                                  'Obs: ${veiculo.observacao}',
                                  style: FlutterFlowTheme.of(context).bodySmall.override(
                                        fontFamily: 'Inter',
                                        color: FlutterFlowTheme.of(context).secondaryText,
                                      ),
                                ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: FutureBuilder<List<OsRow>>(
                future: OsTable().queryRows(
                  queryFn: (q) => q
                      .eq('veiculo_id', veiculo.id)
                      .order('data_entrada', ascending: false),
                ),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final ordens = snapshot.data!;

                  if (ordens.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.history_rounded,
                            size: 64,
                            color: FlutterFlowTheme.of(context).secondaryText,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Nenhuma passagem registrada.',
                            style: FlutterFlowTheme.of(context).bodyLarge,
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.all(24.0),
                    itemCount: ordens.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final os = ordens[index];
                      return Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primaryBackground,
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(
                            color: FlutterFlowTheme.of(context).alternate,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'OS #${os.numero}',
                                  style: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context).primary,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    os.status ?? 'Pendente',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            _buildHistoryItem(
                              icon: Icons.login_rounded,
                              label: 'Entrada',
                              value: os.dataEntrada != null
                                  ? dateTimeFormat('dd/MM/yyyy', os.dataEntrada!)
                                  : '-',
                            ),
                            _buildHistoryItem(
                              icon: Icons.check_circle_outline_rounded,
                              label: 'Conclusão',
                              value: os.dataEntrada != null
                                  ? dateTimeFormat('dd/MM/yyyy', os.dataEntrada!)
                                  : 'Em aberto',
                            ),
                            _buildHistoryItem(
                              icon: Icons.person_outline_rounded,
                              label: 'Mecânico',
                              value: os.mecanicoResponsavel ?? 'Não informado',
                            ),
                            _buildHistoryItem(
                              icon: Icons.speed_rounded,
                              label: 'KM na Entrada',
                              value: os.kmVeiculo?.toString() ?? 'Não informado',
                            ),
                            if (os.observacao != null && os.observacao!.isNotEmpty)
                              _buildHistoryItem(
                                icon: Icons.info_outline_rounded,
                                label: 'Obs da OS',
                                value: os.observacao!,
                              ),
                            const Divider(height: 24),
                            Text(
                              'Serviço Realizado:',
                              style: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .override(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              os.descricao ?? 'Sem descrição',
                              style: FlutterFlowTheme.of(context).bodyMedium,
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        children: [
          Icon(icon, size: 16, color: FlutterFlowTheme.of(context).secondaryText),
          const SizedBox(width: 8),
          Text(
            '$label: ',
            style: FlutterFlowTheme.of(context).bodySmall.override(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.bold,
                ),
          ),
          Text(
            value,
            style: FlutterFlowTheme.of(context).bodySmall,
          ),
        ],
      ),
    );
  }
}
