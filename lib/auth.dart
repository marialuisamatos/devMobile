import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  caduser({
    required String email, 
    required String senha, 
    required String nome,
    })async {
    UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: senha,
    );
    await userCredential.user!.updateDisplayName(nome);
    }
}
