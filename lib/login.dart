import 'package:flutter/material.dart';
import 'package:flutterfirebaselogin/auth.dart';
import 'dart:ui'; // ADICIONE ESTA LINHA

void main() {
  runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: Login()));
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool entrar = true;

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _nomeController = TextEditingController();

  final _authServ = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration( // removido const aqui
          image: const DecorationImage(
            image: AssetImage('assets/img/coffeeKat_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(15, 24, 15, 24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 0.8, sigmaY: 0.8),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        // antigo: color: Colors.white.withOpacity(0.12),
                        color: Color.fromRGBO(255, 255, 255, 0.12), // vidro translúcido
                        borderRadius: BorderRadius.circular(20),
                        // antigo: Border.all(color: Colors.white.withOpacity(0.18), width: 1.0),
                        border: Border.all(color: Color.fromRGBO(255, 255, 255, 0.18), width: 1.0),
                        boxShadow: [
                          // antigo: color: Colors.black.withOpacity(0.25),
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          )
                        ],
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Logo com destaque
                            Center(
                              child: SizedBox(
                                width: 140,
                                height: 140,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Image.asset(
                                    'assets/img/coffeeKat_logo.png',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            const Center(
                              child: Text(
                                'Coffee Kat',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black45,
                                      offset: Offset(0, 2),
                                      blurRadius: 4,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 18),
                            // Campos com fundo semi-transparente
                            TextFormField(
                              controller: _emailController,
                              cursorColor: Colors.white,
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return "O campo E-mail é obrigatório.";
                                }
                                if (value.length < 5) {
                                  return "O campo E-mail precisa ter no mínimo 5 caracteres.";
                                }
                                if (value.contains("@") == false ||
                                    value.contains(".") == false) {
                                  return "O campo E-mail precisa ter o domínio válido.";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: "E-mail",
                                filled: true,
                                fillColor: Color.fromARGB(50, 0, 0, 0),
                                hintStyle: const TextStyle(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              style: const TextStyle( // CORRIGIDO: texto do input em branco
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: _senhaController,
                              cursorColor: Colors.white,
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return "O campo senha precisa ser preenchido.";
                                }
                                if (value.length < 8) {
                                  return "O campo Senha precisa ter no mínimo 8 caracteres.";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: "Senha",
                                filled: true,
                                fillColor: Color.fromARGB(50, 0, 0, 0),
                                hintStyle: const TextStyle(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              style: const TextStyle(
                                color: Colors.white, // CORRIGIDO
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                              obscureText: true,
                            ),
                            Visibility(
                              visible: !entrar,
                              child: Column(
                                children: [
                                  const SizedBox(height: 10),
                                  TextFormField(
                                    controller: _nomeController,
                                    cursorColor: Colors.white,
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return "O campo nome é obrigatório.";
                                      }
                                      if (value.length < 3) {
                                        return "O campo nome precisa ter no mínimo 3 caracteres.";
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Nome Completo",
                                      filled: true,
                                      fillColor: Color.fromARGB(50, 0, 0, 0),
                                      hintStyle: const TextStyle(
                                        color: Colors.white70,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                    style: const TextStyle(
                                      color: Colors.white, // CORRIGIDO
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 18),
                            SizedBox(
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  botaoEntrar();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      (entrar) ? const Color.fromARGB(50, 0, 0, 0) : Color.fromARGB(50, 0, 0, 0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 6,
                                ),
                                child: Text(
                                  (entrar) ? "Entrar" : "Cadastrar",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Center(
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    entrar = !entrar;
                                  });
                                },
                                child: Text(
                                  (entrar) ? "Cadastre-se" : "Entre",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
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
              ),
            ),
          ),
        ),
      ),
    );
  }

  botaoEntrar() {
    String email = _emailController.text;
    String senha = _senhaController.text;
    String nome = _nomeController.text;

    if (_formKey.currentState!.validate()) {
      if (entrar) {
        debugPrint("entrada validada");
        _authServ.logUser(email: email, senha: senha);
      } else {
        debugPrint("cadastro validado");
        debugPrint(email);
        debugPrint(senha);
        debugPrint(nome);
        _authServ.caduser(email: email, senha: senha, nome: nome);
      }
    } else {
      debugPrint("Formulario invalido");
    }
  }
}
