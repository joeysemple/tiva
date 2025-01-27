import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/user.dart' as app_models;

class AuthService extends ChangeNotifier {
  final firebase_auth.FirebaseAuth _auth = firebase_auth.FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'profile',
    ],
  );
  app_models.User? _currentUser;

  app_models.User? get currentUser => _currentUser;
  bool get isAnonymous => _currentUser?.isAnonymous ?? true;

  AuthService() {
    _auth.authStateChanges().listen(_onAuthStateChanged);
  }

  Future<void> _onAuthStateChanged(firebase_auth.User? firebaseUser) async {
    if (firebaseUser == null) {
      _currentUser = null;
    } else {
      // Get user data from Firestore
      final doc = await _firestore.collection('users').doc(firebaseUser.uid).get();
      if (doc.exists) {
        _currentUser = app_models.User.fromJson(doc.data()!..['id'] = doc.id);
      } else {
        // Create user profile
        _currentUser = app_models.User(
          id: firebaseUser.uid,
          username: firebaseUser.displayName,
          email: firebaseUser.email,
          photoUrl: firebaseUser.photoURL,
          isAnonymous: firebaseUser.isAnonymous,
          createdAt: DateTime.now(),
        );
        await _firestore.collection('users').doc(firebaseUser.uid).set(_currentUser!.toJson());
      }
    }
    notifyListeners();
  }

  Future<void> signInAnonymously() async {
    try {
      await _auth.signInAnonymously();
    } catch (e) {
      throw Exception('Failed to sign in anonymously: $e');
    }
  }

  Future<void> signInWithEmail(String email, String password) async {
    try {
      print('Starting email/password sign in...');
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user;

      if (user != null) {
        print('Successfully signed in: ${user.email}');
        final userDoc = await _firestore.collection('users').doc(user.uid).get();
        
        if (userDoc.exists) {
          final userData = userDoc.data()!;
          _currentUser = app_models.User(
            id: user.uid,
            email: user.email ?? '',
            username: userData['username'] ?? email.split('@')[0],
            photoUrl: userData['photoUrl'],
            isAnonymous: false,
            createdAt: (userData['createdAt'] as Timestamp?)?.toDate(),
          );
        } else {
          // Create user document if it doesn't exist
          await _firestore.collection('users').doc(user.uid).set({
            'id': user.uid,
            'email': user.email,
            'username': email.split('@')[0],
            'photoUrl': null,
            'isAnonymous': false,
            'createdAt': FieldValue.serverTimestamp(),
            'followers': [],
            'following': [],
          });

          _currentUser = app_models.User(
            id: user.uid,
            email: user.email ?? '',
            username: email.split('@')[0],
            isAnonymous: false,
            createdAt: DateTime.now(),
          );
        }
        notifyListeners();
      } else {
        print('Failed to get user after sign in');
        throw 'Sign in failed';
      }
    } catch (e) {
      print('Error during sign in: $e');
      if (e.toString().contains('user-not-found')) {
        throw 'No account found with this email';
      } else if (e.toString().contains('wrong-password')) {
        throw 'Incorrect password';
      }
      rethrow;
    }
  }

  Future<void> register(String email, String password, String username) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      final user = app_models.User(
        id: credential.user!.uid,
        email: email,
        username: username,
        isAnonymous: false,
        createdAt: DateTime.now(),
      );

      await _firestore.collection('users').doc(user.id).set(user.toJson());
    } catch (e) {
      throw Exception('Failed to register: $e');
    }
  }

  Future<void> registerWithEmailAndPassword(String email, String password) async {
    try {
      print('Starting email/password registration...');
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user;

      if (user != null) {
        print('Successfully registered: ${user.email}');
        await _firestore.collection('users').doc(user.uid).set({
          'id': user.uid,
          'email': user.email,
          'username': email.split('@')[0], // Default username from email
          'photoUrl': null,
          'isAnonymous': false,
          'createdAt': FieldValue.serverTimestamp(),
          'followers': [],
          'following': [],
        });

        _currentUser = app_models.User(
          id: user.uid,
          email: user.email ?? '',
          username: email.split('@')[0],
          isAnonymous: false,
          createdAt: DateTime.now(),
        );
        notifyListeners();
      } else {
        print('Failed to get user after registration');
        throw 'Registration failed';
      }
    } catch (e) {
      print('Error during registration: $e');
      if (e.toString().contains('email-already-in-use')) {
        throw 'This email is already registered. Please try logging in.';
      }
      rethrow;
    }
  }

  Future<void> convertAnonymousToRegistered(
    String email,
    String password,
    String username,
  ) async {
    try {
      final credential = firebase_auth.EmailAuthProvider.credential(
        email: email,
        password: password,
      );
      
      await _auth.currentUser?.linkWithCredential(credential);
      
      final user = _currentUser?.copyWith(
        email: email,
        username: username,
        isAnonymous: false,
      );

      if (user?.id != null) {
        await _firestore.collection('users').doc(user!.id).update(user.toJson());
      }
    } catch (e) {
      throw Exception('Failed to convert anonymous account: $e');
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      print('Starting Google Sign In...');
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      
      if (googleUser == null) {
        print('Google Sign In cancelled by user');
        throw 'Sign in cancelled';
      }

      print('Getting Google Auth credentials...');
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      print('Creating Firebase credential...');
      final credential = firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      print('Signing in with Firebase...');
      final userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user;

      if (user != null) {
        print('Successfully signed in with Google: ${user.email}');
        // Create or update user document in Firestore
        await _firestore.collection('users').doc(user.uid).set({
          'id': user.uid,
          'email': user.email,
          'username': user.displayName,
          'photoUrl': user.photoURL,
          'isAnonymous': false,
          'createdAt': FieldValue.serverTimestamp(),
          'followers': [],
          'following': [],
        }, SetOptions(merge: true));

        _currentUser = app_models.User(
          id: user.uid,
          email: user.email,
          username: user.displayName,
          photoUrl: user.photoURL,
          isAnonymous: false,
          createdAt: DateTime.now(),
        );
        notifyListeners();
      } else {
        print('Failed to get user after Google Sign In');
        throw 'Failed to sign in with Google';
      }
    } catch (e) {
      print('Error during Google Sign In: $e');
      rethrow;
    }
  }

  Future<void> linkAnonymousAccountWithGoogle() async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser == null || !currentUser.isAnonymous) return;

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await currentUser.linkWithCredential(credential);
      
      // Update user profile
      final updatedUser = _currentUser?.copyWith(
        username: googleUser.displayName,
        email: googleUser.email,
        photoUrl: googleUser.photoUrl,
        isAnonymous: false,
      );

      if (updatedUser?.id != null) {
        await _firestore.collection('users').doc(updatedUser!.id).update(updatedUser.toJson());
      }
    } catch (e) {
      throw Exception('Failed to link account with Google: $e');
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception('Failed to sign out: $e');
    }
  }
}
