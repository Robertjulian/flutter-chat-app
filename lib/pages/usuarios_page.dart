import 'package:chat_app/models/usuario.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/chat_service.dart';
import 'package:chat_app/services/socket_service.dart';
import 'package:chat_app/services/usuarios._service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsuariosPage extends StatefulWidget {
  @override
  _UsuariosPageState createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  final usuariosServices = UsuariosService();
  List<Usuario> usuarios = [];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    _cargarUsuarios();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);
    final usuario = authService.usuario;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          usuario.nombre,
          style: TextStyle(
            color: Colors.black54,
          ),
        ),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, 'login');
            AuthService.deleteToken();
            socketService.disconnect();
          },
          icon: Icon(
            Icons.exit_to_app,
            color: Colors.black54,
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            // child: Icon(
            //   Icons.offline_bolt,
            //   color: Colors.red,
            // ),
            child: socketService.serverStatus == ServerStatus.Online
                ? Icon(
                    Icons.check_circle,
                    color: Colors.blue.shade400,
                  )
                : Icon(
                    Icons.offline_bolt,
                    color: Colors.red,
                  ),
          )
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _cargarUsuarios,
        header: WaterDropHeader(
          complete: Icon(
            Icons.check,
            color: Colors.blue.shade400,
          ),
          waterDropColor: Colors.blue.shade200,
        ),
        child: _listViewUsuarios(),
      ),
    );
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (_, i) => _usuarioListTile(usuarios[i]),
        separatorBuilder: (_, i) => Divider(),
        itemCount: usuarios.length);
  }

  ListTile _usuarioListTile(Usuario usuario) {
    return ListTile(
      title: Text(usuario.nombre),
      subtitle: Text(usuario.email),
      leading: CircleAvatar(
        backgroundColor: Colors.blue.shade100,
        child: Text(usuario.nombre.substring(0, 2)),
      ),
      trailing: Container(
        height: 10,
        width: 10,
        decoration: BoxDecoration(
          color: usuario.online ? Colors.green.shade400 : Colors.red,
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      onTap: () {
        final chatService = Provider.of<ChatService>(context, listen: false);
        chatService.usuarioFrom = usuario;
        Navigator.pushNamed(context, 'chat');
      },
    );
  }

  void _cargarUsuarios() async {
    usuarios = await usuariosServices.getUsuarios();
    setState(() {});
    _refreshController.refreshCompleted();
  }
}
