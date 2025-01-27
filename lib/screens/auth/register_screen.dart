import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/auth_service.dart';
import '../../themes/app_theme.dart';

class RegisterScreen extends StatefulWidget {
  final bool isConverting;

  const RegisterScreen({Key? key, this.isConverting = false}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool get isConverting => widget.isConverting;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      await context.read<AuthService>().registerWithEmailAndPassword(
            _emailController.text.trim(),
            _passwordController.text.trim(),
          );
      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _handleGoogleSignIn() async {
    if (_isLoading) return;
    
    setState(() => _isLoading = true);
    try {
      print('Starting Google Sign-In from register screen...');
      final authService = context.read<AuthService>();
      await authService.signInWithGoogle();
      
      if (mounted) {
        print('Google Sign-In successful, navigating...');
        // Pop only once and use replacement to avoid black screen
        Navigator.of(context).pushReplacementNamed('/home');
      }
    } catch (e) {
      print('Register screen Google Sign-In error: $e');
      if (mounted) {
        String errorMessage = e.toString();
        if (errorMessage.contains('network_error')) {
          errorMessage = 'Network error. Please check your internet connection.';
        } else if (errorMessage.contains('sign_in_canceled') || errorMessage.contains('Sign in cancelled')) {
          errorMessage = 'Sign in was canceled';
        } else if (errorMessage.contains('popup_closed')) {
          errorMessage = 'Sign in window was closed';
        } else {
          errorMessage = 'Google Sign In Error: $errorMessage';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            duration: const Duration(seconds: 5),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isConverting ? 'Create Account' : 'Register'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 32),
              Text(
                isConverting
                    ? 'Convert to Full Account'
                    : 'Create Your Account',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                enabled: !_isLoading,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                enabled: !_isLoading,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isLoading ? null : _register,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: AppTheme.accentColor,
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Text(isConverting ? 'Create Account' : 'Register'),
              ),
              if (!isConverting) ...[
                const SizedBox(height: 16),
                TextButton(
                  onPressed: _isLoading ? null : () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Already have an account? Login'),
                ),
              ],
              if (isConverting) ...[
                const SizedBox(height: 16),
                const Row(
                  children: [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text('OR'),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 16),
                OutlinedButton.icon(
                  onPressed: _isLoading ? null : _handleGoogleSignIn,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: BorderSide(color: Theme.of(context).primaryColor),
                  ),
                  icon: Image.asset(
                    'assets/icons/google_logo.png',
                    height: 24,
                  ),
                  label: const Text('Continue with Google'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
