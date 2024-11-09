import 'package:csgo_skins_app/main.dart';
import 'package:csgo_skins_app/screens/home_page_screen.dart';
import 'package:csgo_skins_app/screens/user_skins_screen.dart';
import 'package:flutter/material.dart';
import 'package:csgo_skins_app/services/auth_service.dart';
import 'package:csgo_skins_app/services/user_service.dart';
import 'package:csgo_skins_app/domain/entities/user.dart';
import 'package:http/http.dart' as http;

class Menu extends StatelessWidget {
  final User? user;
  final VoidCallback onLogout;

  const Menu({super.key, required this.user, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 20, 20, 20),
      child: ListView(
        children: [
          ListTile(
            title: const Text('Home', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
          if (user != null)
            ListTile(
              title: const Text('Minhas Skins',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserSkinsScreen(userId: user!.id),
                  ),
                );
              },
            ),
          if (user == null) ...[
            ListTile(
              title:
                  const Text('Entrar', style: TextStyle(color: Colors.white)),
              onTap: () {
                _showLoginModal(context);
              },
            ),
            ListTile(
              title: const Text('Registrar-se',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                _showRegisterModal(context);
              },
            ),
          ] else
            ListTile(
              title:
                  const Text('Deslogar', style: TextStyle(color: Colors.white)),
              onTap: onLogout,
            ),
        ],
      ),
    );
  }

  void _showLoginModal(BuildContext context) {
    final authService = AuthService(http.Client());

    showDialog(
      context: context,
      builder: (context) {
        String email = '';
        String password = '';
        return AlertDialog(
          title: const Text('Entrar'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Email'),
                onChanged: (value) {
                  email = value;
                },
              ),
              TextField(
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Senha'),
                onChanged: (value) {
                  password = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  final user =
                      await authService.login(email: email, pass: password);
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Bem-vindo, ${user.name}!')),
                  );

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(user: user),
                    ),
                  );
                } catch (e) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Falha ao fazer login')),
                  );
                }
              },
              child: const Text('Entrar'),
            ),
          ],
        );
      },
    );
  }

  void _showRegisterModal(BuildContext context) {
    final userService = UserService(http.Client());

    showDialog(
      context: context,
      builder: (context) {
        String name = '';
        String email = '';
        String password = '';
        return AlertDialog(
          title: const Text('Registrar-se'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Nome'),
                onChanged: (value) {
                  name = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Email'),
                onChanged: (value) {
                  email = value;
                },
              ),
              TextField(
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Senha'),
                onChanged: (value) {
                  password = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  final newUser =
                      User(name: name, email: email, password: password);
                  await userService.create(newUser);
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Cadastro realizado com sucesso!')),
                  );
                } catch (e) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Falha ao registrar')),
                  );
                }
              },
              child: const Text('Registrar'),
            ),
          ],
        );
      },
    );
  }
}
