import 'dart:typed_data';
import 'dart:convert';
import '/auth/supabase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'perfil_page_model.dart';
export 'perfil_page_model.dart';

class PerfilPageWidget extends StatefulWidget {
  const PerfilPageWidget({super.key});

  static String routeName = 'PerfilPage';
  static String routePath = '/perfilPage';

  @override
  State<PerfilPageWidget> createState() => _PerfilPageWidgetState();
}

class _PerfilPageWidgetState extends State<PerfilPageWidget> {
  late PerfilPageModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PerfilPageModel());
    _loadProfilePhoto();
  }

  Future<void> _loadProfilePhoto() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'profile_photo_${currentUserEmail}';
    final base64Photo = prefs.getString(key);
    if (base64Photo != null && base64Photo.isNotEmpty) {
      final bytes = base64Decode(base64Photo);
      FFAppState().profilePhotoBytes = bytes;
      setState(() {});
    }
  }

  Future<void> _saveProfilePhoto(Uint8List bytes) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'profile_photo_${currentUserEmail}';
    final base64Photo = base64Encode(bytes);
    await prefs.setString(key, base64Photo);
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  Future<void> _showImageSourceDialog() async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40.0,
                height: 4.0,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2.0),
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'Escolher foto',
                style: FlutterFlowTheme.of(context).headlineSmall.override(
                      fontFamily: 'Inter Tight',
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.0,
                    ),
              ),
              SizedBox(height: 20.0),
              ListTile(
                leading: Container(
                  width: 45.0,
                  height: 45.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFF1F4F8),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Icon(
                    Icons.photo_library_rounded,
                    color: Color(0xFF1D2428),
                    size: 24.0,
                  ),
                ),
                title: Text(
                  'Galeria',
                  style: FlutterFlowTheme.of(context).bodyLarge.override(
                        fontFamily: 'Inter',
                        letterSpacing: 0.0,
                      ),
                ),
                onTap: () async {
                  Navigator.pop(context);
                  final XFile? image = await _picker.pickImage(
                    source: ImageSource.gallery,
                  );
                  if (image != null) {
                    final bytes = await image.readAsBytes();
                    FFAppState().profilePhotoBytes = bytes;
                    await _saveProfilePhoto(bytes);
                    setState(() {});
                  }
                },
              ),
              SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    final profilePhotoBytes = FFAppState().profilePhotoBytes;
    
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
                  children: [
                    Expanded(
                      child: Text(
                        'Meu Perfil',
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
                      padding: EdgeInsetsDirectional.fromSTEB(24.0, 30.0, 24.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          GestureDetector(
                            onTap: _showImageSourceDialog,
                            child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                Container(
                                  width: 120.0,
                                  height: 120.0,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF1F4F8),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Color(0xFF1D2428),
                                      width: 3.0,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(60.0),
                                      child: profilePhotoBytes != null
                                          ? Image.memory(
                                              profilePhotoBytes,
                                              fit: BoxFit.cover,
                                              width: 112.0,
                                              height: 112.0,
                                            )
                                          : currentUserPhoto.isNotEmpty
                                              ? Image.network(
                                                  currentUserPhoto,
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error, stackTrace) =>
                                                      Icon(
                                                    Icons.person_rounded,
                                                    size: 60.0,
                                                    color: Color(0xFF1D2428),
                                                  ),
                                                )
                                              : Icon(
                                                  Icons.person_rounded,
                                                  size: 60.0,
                                                  color: Color(0xFF1D2428),
                                                ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 36.0,
                                  height: 36.0,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF1D2428),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2.0,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.camera_alt_rounded,
                                    color: Colors.white,
                                    size: 18.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                            child: Text(
                              currentUserEmail,
                              style: FlutterFlowTheme.of(context).headlineSmall.override(
                                    fontFamily: 'Inter Tight',
                                    fontSize: 18.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 40.0, 0.0, 0.0),
                            child: InkWell(
                              onTap: () async {
                                await authManager.signOut();
                                if (Navigator.of(context).canPop()) {
                                  context.pop();
                                }
                                context.pushNamedAuth('LoginPage', context.mounted);
                              },
                              child: Container(
                                width: 180.0,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 10.0,
                                      color: Color(0x11000000),
                                      offset: Offset(0.0, 4.0),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(16.0),
                                  border: Border.all(
                                    color: Color(0x0D000000),
                                    width: 1.0,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.logout_rounded,
                                        color: Colors.red,
                                        size: 20.0,
                                      ),
                                      SizedBox(width: 8.0),
                                      Text(
                                        'Sair da Conta',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Inter Tight',
                                              color: Colors.red,
                                              fontSize: 14.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 4,
          onTap: (index) {
            if (index == 0) {
              context.pushNamed('HomePage');
            } else if (index == 1) {
              context.pushNamed('OrdemServicoPage');
            } else if (index == 2) {
              context.pushNamed('VeiculosPage');
            } else if (index == 3) {
              context.pushNamed('CarrosPage');
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
}
