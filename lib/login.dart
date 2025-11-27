import 'package:flutter/material.dart';
import 'package:flutterfirebaselogin/auth.dart';

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
      backgroundColor: (entrar) ? Colors.black : Colors.brown[900],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: (entrar) ? Colors.red : Colors.deepOrangeAccent,
        title: Text(
          (entrar) ? "Tela de login" : "Tela de cadastro",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Icon(
                  (entrar)
                      ? Icons.account_circle_rounded
                      : Icons.account_circle_outlined,
                  color: Colors.white,
                  size: 110,
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: _emailController,
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
                    if (value.length < 5) {
                      return "O campo E-mail precisa ter no mínimo 5 caracteres.";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "E-mail",
                    fillColor: Colors.white,
                    filled: true,
                    hintStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w200,
                      fontSize: 16,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w200,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: _senhaController,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "O campo senha precisa ser preenchido.";
                    }
                    if (value.length < 8) {
                      return "O campo E-mail precisa ter no mínimo 8 caracteres.";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Senha",
                    fillColor: Colors.white,
                    filled: true,
                    hintStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w200,
                      fontSize: 16,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w200,
                    fontSize: 16,
                  ),
                  obscureText: true,
                ),
                Visibility(
                  visible: !entrar,
                  child: Column(
                    children: [
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: _nomeController,
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
                          fillColor: Colors.white,
                          filled: true,
                          hintStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w200,
                            fontSize: 16,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w200,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                  child: SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        botaoEntrar();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: (entrar)
                            ? Colors.red
                            : Colors.deepOrangeAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
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
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      entrar = !entrar;
                    });
                  },
                  child: Text(
                    (entrar) ? "Cadastre-se" : "Entre",
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ],
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

    if (_formKey.currentState!.validate()){
      if(entrar){
        print("entrada validada");
      }else{
        print("cadastro validado");
        print("${_emailController.text}");
        print("${_senhaController.text}");
        print("${_nomeController.text}");
        _authServ.caduser(
          email: email,
          senha: senha,
          nome: nome,
        );
      }
    } else {
      print("Formulario invalido");
    }
  }
}
