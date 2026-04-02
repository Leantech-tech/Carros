import '/backend/supabase/database/database.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'carros_page_model.dart';
export 'carros_page_model.dart';
import 'carro_cadastro_page_widget.dart';

class CarrosPageWidget extends StatefulWidget {
  const CarrosPageWidget({super.key});

  static String routeName = 'CarrosPage';
  static String routePath = '/carrosPage';

  @override
  State<CarrosPageWidget> createState() => _CarrosPageWidgetState();
}

class _CarrosPageWidgetState extends State<CarrosPageWidget> {
  late CarrosPageModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  CarroRow? _selectedCarro;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CarrosPageModel());
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
        endDrawer: Drawer(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          width: MediaQuery.of(context).size.width > 600 ? MediaQuery.of(context).size.width * 0.5 : MediaQuery.of(context).size.width * 0.9,
          child: CarroCadastroPageWidget(
            carro: _selectedCarro,
            onUpdate: () {
              Navigator.of(context).pop();
              setState(() {});
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _selectedCarro = null;
            });
            WidgetsBinding.instance.addPostFrameCallback((_) {
              scaffoldKey.currentState?.openEndDrawer();
            });
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
                        'Carros',
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
                                    hintText: 'Filtrar por nome, placa ou data...',
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
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
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
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width > 800
                              ? MediaQuery.of(context).size.width * 0.5
                              : double.infinity,
                        ),
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                          child: FutureBuilder<List<CarroRow>>(
                            future: CarroTable().queryRows(
                              queryFn: (q) => q.order('data', ascending: false),
                            ),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: FlutterFlowTheme.of(context).primary,
                                  ),
                                );
                              }
                              List<CarroRow> carros = snapshot.data!;

                              if (_model.textController?.text != null &&
                                  _model.textController!.text.isNotEmpty) {
                                final searchText = _model.textController!.text.toLowerCase();
                                carros = carros.where((c) {
                                  final dataStr = DateFormat('dd/MM/yyyy').format(c.dataServico);
                                  return c.nomeVeiculo.toLowerCase().contains(searchText) ||
                                         c.placa.toLowerCase().contains(searchText) ||
                                         dataStr.contains(searchText);
                                }).toList();
                              }

                              if (carros.isEmpty) {
                                return Center(
                                  child: Text('Nenhum registro encontrado.'),
                                );
                              }

                              return LayoutBuilder(
                                builder: (context, constraints) {
                                  return SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        ConstrainedBox(
                                          constraints: BoxConstraints(minWidth: constraints.maxWidth),
                                          child: Theme(
                                            data: Theme.of(context).copyWith(
                                              cardColor: Colors.white,
                                              dividerColor: Colors.transparent,
                                            ),
                                            child: PaginatedDataTable(
                                              header: null,
                                              rowsPerPage: carros.length > 10 ? 10 : (carros.isEmpty ? 1 : carros.length),
                                              availableRowsPerPage: const [10, 25, 50, 100],
                                              showCheckboxColumn: false,
                                              columnSpacing: 20,
                                              horizontalMargin: 12,
                                              columns: const [
                                                DataColumn(label: Text('Nome do Veículo')),
                                                DataColumn(label: Text('Data')),
                                                DataColumn(label: Text('Contato')),
                                              ],
                                              source: CarrosTableSource(
                                                carros: carros,
                                                context: context,
                                                onSelect: (carro) {
                                                  setState(() {
                                                    _selectedCarro = carro;
                                                  });
                                                  WidgetsBinding.instance.addPostFrameCallback((_) {
                                                    scaffoldKey.currentState?.openEndDrawer();
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 16.0, 20.0),
                                          child: Text(
                                            'Total de registros: ${carros.length}',
                                            textAlign: TextAlign.end,
                                            style: FlutterFlowTheme.of(context).bodySmall.override(
                                              fontFamily: 'Inter',
                                              color: FlutterFlowTheme.of(context).secondaryText,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
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
              icon: Icon(Icons.directions_car_filled),
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
}

class CarrosTableSource extends DataTableSource {
  final List<CarroRow> carros;
  final BuildContext context;
  final Function(CarroRow) onSelect;

  CarrosTableSource({
    required this.carros,
    required this.context,
    required this.onSelect,
  });

  @override
  DataRow? getRow(int index) {
    if (index >= carros.length) return null;
    final carro = carros[index];
    return DataRow.byIndex(
      index: index,
      onSelectChanged: (selected) {
        if (selected == true) {
          onSelect(carro);
        }
      },
      cells: [
        DataCell(Text(carro.nomeVeiculo)),
        DataCell(Text(DateFormat('dd/MM/yyyy').format(carro.dataServico))),
        DataCell(Text(carro.getField<String>('contato') ?? 'N/A')),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => carros.length;

  @override
  int get selectedRowCount => 0;
}
