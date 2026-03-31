import '/backend/supabase/database/database.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'home_page_model.dart';
export 'home_page_model.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  static String routeName = 'HomePage';
  static String routePath = '/homePage';

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  int _totalVeiculos = 0;
  int _totalOS = 0;
  int _osEmAndamento = 0;
  int _osConcluidas = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());
    _loadStats();
  }

  Future<void> _loadStats() async {
    try {
      // Load vehicles
      final veiculos = await VeiculoTable().queryRows(queryFn: (q) => q);
      
      // Load OS
      final ordensServico = await OsTable().queryRows(queryFn: (q) => q);

      setState(() {
        _totalVeiculos = veiculos.length;
        _totalOS = ordensServico.length;
        
        // Count OS by status
        _osEmAndamento = ordensServico.where((os) {
          final status = os.status?.toLowerCase() ?? '';
          return status == 'em andamento' || status == 'pendente';
        }).length;
        
        _osConcluidas = ordensServico.where((os) {
          final status = os.status?.toLowerCase() ?? '';
          return status == 'concluído' || status == 'concluido';
        }).length;
        
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
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
      onTap: () => FocusScope.of(context).unfocus(),
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
                padding: EdgeInsetsDirectional.fromSTEB(24.0, 60.0, 24.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Dashboard',
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
                    Text(
                      'v1.0.0',
                      style: FlutterFlowTheme.of(context)
                          .bodyLarge
                          .override(
                            fontFamily: 'Inter',
                            color: Color(0x99FFFFFF),
                            fontSize: 16.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w500,
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
                      color: Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0.0),
                        bottomRight: Radius.circular(0.0),
                        topLeft: Radius.circular(32.0),
                        topRight: Radius.circular(32.0),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16.0, 30.0, 16.0, 0.0),
                      child: _isLoading
                          ? Center(
                              child: CircularProgressIndicator(
                                color: Color(0xFF1D2428),
                              ),
                            )
                          : SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  // First row of cards
                                  Row(
                                    children: [
                                      Expanded(
                                        child: _buildStatCard(
                                          icon: Icons.directions_car_rounded,
                                          iconColor: Color(0xFF3B82F6),
                                          value: _totalVeiculos.toString(),
                                          label: 'Total de Veículos',
                                        ),
                                      ),
                                      SizedBox(width: 12.0),
                                      Expanded(
                                        child: _buildStatCard(
                                          icon: Icons.pending_actions_rounded,
                                          iconColor: Color(0xFFF59E0B),
                                          value: _osEmAndamento.toString(),
                                          label: 'OS Em Andamento',
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 12.0),
                                  // Second row of cards
                                  Row(
                                    children: [
                                      Expanded(
                                        child: _buildStatCard(
                                          icon: Icons.check_circle_rounded,
                                          iconColor: Color(0xFF10B981),
                                          value: _osConcluidas.toString(),
                                          label: 'OS Concluídas',
                                        ),
                                      ),
                                      SizedBox(width: 12.0),
                                      Expanded(
                                        child: _buildStatCard(
                                          icon: Icons.assignment_rounded,
                                          iconColor: Color(0xFF8B5CF6),
                                          value: _totalOS.toString(),
                                          label: 'Total de OS',
                                        ),
                                      ),
                                    ],
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
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 0,
          onTap: (index) {
            if (index == 1) {
              context.pushNamed('OrdemServicoPage');
            } else if (index == 2) {
              context.pushNamed('VeiculosPage');
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

  Widget _buildStatCard({
    required IconData icon,
    required Color iconColor,
    required String value,
    required String label,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            blurRadius: 10.0,
            color: Color(0x0D000000),
            offset: Offset(0.0, 4.0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: iconColor,
            size: 32.0,
          ),
          SizedBox(height: 12.0),
          Text(
            value,
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Inter Tight',
                  color: iconColor,
                  fontSize: 28.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: 4.0),
          Text(
            label,
            textAlign: TextAlign.center,
            style: FlutterFlowTheme.of(context).bodySmall.override(
                  fontFamily: 'Inter',
                  color: FlutterFlowTheme.of(context).secondaryText,
                  fontSize: 12.0,
                  letterSpacing: 0.0,
                ),
          ),
        ],
      ),
    );
  }
}
