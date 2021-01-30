import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/chat_service.dart';
import 'package:chat_app/services/socket_service.dart';
import 'package:chat_app/services/usuario_service.dart';
import 'package:chat_app/shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:chat_app/models/usuario.dart';

class UsuariosPage extends StatefulWidget {
  static final String routeName = 'usuarios';
  @override
  _UsuariosPageState createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final usuarioService = new UsuariosService();

  final prefs = new PreferenciasUsuario();

  List<Usuario> usuarios = [];

  @override
  void initState() {
    this._cargarUsuarios();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);
    final usuario = authService.usuario;
    
    prefs.ultimaPagina = UsuariosPage.routeName;

    return Scaffold(
        appBar: AppBar(
          title: Align(
            child: Text(usuario.nombre,
                style: TextStyle(color: Colors.black87, fontSize: 24)),
          ),
          elevation: 9,
          backgroundColor: Colors.orange[600],
          leading: IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.black87,
            ),
            onPressed: () {
              socketService.disconnect();
              Navigator.pushReplacementNamed(context, 'login');
              AuthService.deleteToken();
            },
          ),
          actions: <Widget>[
            Container(
              height: 20,
              width: 20,
              margin: EdgeInsets.only(right: 10),
              child: (socketService.serverStatus == ServerStatus.Online)
                  ? Image.asset('assets/azu.png')
                  : Image.asset('assets/redball.png'),
            )
          ],
        ),
        body: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          onRefresh: _cargarUsuarios,
          header: WaterDropHeader(
            complete: Icon(Icons.check, color: Colors.blue[400]),
            waterDropColor: Colors.blue[400],
          ),
          child: _listViewUsuarios(),
        ));
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (_, i) => _usuarioListTile(usuarios[i]),
      separatorBuilder: (_, i) => Divider(),
      itemCount: usuarios.length,
    );
  }

  Widget _usuarioListTile(Usuario usuario) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Row(
      children: [
        Padding(padding: EdgeInsets.only(left: 8)),
        GestureDetector(
          child: CircleAvatar(
              backgroundImage: AssetImage('assets/tenista.gif'), radius: 30),
          onTap: () {
            mostrarCuadro(context, usuario);
          },
        ),
        Flexible(
          child: ListTile(
            title: Text(usuario.nombre),
            subtitle: Text(usuario.email),
            trailing: Container(
              width: 20,
              height: 20,
              child: usuario.online
                  ? Image.asset('assets/tennis_ball.png')
                  : Image.asset('assets/greyball.png'),
            ),
            onTap: () {
              final chatService =
                  Provider.of<ChatService>(context, listen: false);
              chatService.usuarioPara = usuario;
              Navigator.pushNamed(context, 'chat');
            },
          ),
        ),
      ],
    );
  }

  mostrarCuadro(BuildContext context, Usuario usuario) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        //title: Text('hola'),
        content: Image(
          image: AssetImage('assets/tenista.gif'),
          //fit: BoxFit.fill
        ),

        actions: <Widget>[
          Container(
            width: 295,
            //color: Colors.amber,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.chat),
                    iconSize: 32,
                    onPressed: () {
                      final chatService =
                          Provider.of<ChatService>(context, listen: false);
                      chatService.usuarioPara = usuario;
                      Navigator.popAndPushNamed(context, 'chat');
                    }),
                IconButton(
                    icon: Icon(Icons.info),
                    iconSize: 28,
                    onPressed: () {
                      final chatService =
                          Provider.of<ChatService>(context, listen: false);
                      chatService.usuarioPara = usuario;
                      Navigator.popAndPushNamed(context, 'chat');
                    }),
              ],
            ),
          )
        ],
      ),
    );
  }

  _cargarUsuarios() async {
    this.usuarios = await usuarioService.getUsuarios();
    // await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    setState(() {});
    _refreshController.refreshCompleted();
  }
}
