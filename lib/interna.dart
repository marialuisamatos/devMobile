import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebaselogin/auth.dart';
import 'dart:ui'; // Necessário para o BackdropFilter (efeito de vidro)

class Interna extends StatefulWidget {
  const Interna({super.key});

  @override
  State<Interna> createState() => _InternaState();
}

class _InternaState extends State<Interna> {
  // Dados de exemplo para os 6 quadrados
  final List<Map<String, dynamic>> coffeeItems = [
    {'image': 'assets/img/coffee.png', 'name': 'Kat Expresso'},
    {'image': 'assets/img/FarinhaKat.png', 'name': 'Kat Cookies'},
    {'image': 'assets/img/PudimKat.png', 'name': 'kat Pudim'},
    {'image': 'assets/img/OvoKat.png', 'name': 'Kat pão com ovo'},
    {'image': 'assets/img/intrometidoKat.png', 'name': 'Kat Sonho'},
    {'image': 'assets/img/waffleKat.png', 'name': 'Kat Waffle'},
  ];

  @override
  Widget build(BuildContext context) {
    final usuario = FirebaseAuth.instance.currentUser;
    final nome = usuario?.displayName ?? "Usuário";

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/img/coffeeKat_background2.jpg',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(color: const Color(0xFF613b27));
            },
          ),
          Container(color: const Color.fromARGB(11, 0, 0, 0)),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 20.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Bem vindo(a) ao Coffee Kat',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          blurRadius: 4,
                          color: Colors.black54,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'O que gostaria de pedir hoje?',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      shadows: [
                        Shadow(
                          blurRadius: 4,
                          color: Colors.black54,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    nome,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // AQUI COMEÇA A GRADE DE ITENS
                  Expanded(
                    child: GridView.builder(
                      padding: EdgeInsets.zero,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // 2 colunas
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio:
                                1.0, // Para manter os itens quadrados
                          ),
                      itemCount: coffeeItems.length,
                      itemBuilder: (context, index) {
                        final item = coffeeItems[index];
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(255, 255, 255, 0.18),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: Color.fromRGBO(255, 255, 255, 0.2),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Image.asset(
                                      item['image'],
                                      fit: BoxFit.contain, // Adapta a imagem ao espaço sem cortar
                                      errorBuilder: (context, error, stackTrace) {
                                        return const Icon(Icons.image_not_supported, color: Colors.white54, size: 40);
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    item['name'],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // AQUI TERMINA A GRADE
                  const SizedBox(height: 20),

                  SizedBox(
                    width: 220,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        AuthService().logOut();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(255, 255, 255, 0.18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 6,
                      ),
                      child: const Text(
                        "Logout",
                        style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
