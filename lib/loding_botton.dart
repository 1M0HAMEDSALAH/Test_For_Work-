import 'package:flutter/material.dart';

class AnimatedLoginButton extends StatefulWidget {
  final Future<void> Function() onLogin;
  final String text;
  final Color? successColor;
  final Color? failureColor;

  const AnimatedLoginButton({
    Key? key,
    required this.onLogin,
    this.text = 'Log In',
    this.successColor,
    this.failureColor,
  }) : super(key: key);

  @override
  _AnimatedLoginButtonState createState() => _AnimatedLoginButtonState();
}

class _AnimatedLoginButtonState extends State<AnimatedLoginButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _widthAnimation;
  late Animation<double> _opacityAnimation;
  LoginState _currentState = LoginState.initial;

  @override
  void initState() {
    super.initState();

    // Animation controller for button transformations
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    // Width animation to minimize the button
    _widthAnimation = Tween<double>(
      begin: 250.0, // Initial width
      end: 50.0, // Minimized width
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // Opacity animation for text
    _opacityAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(0.0, 0.5, curve: Curves.easeOut),
    ));
  }

  Future<void> _onLoginPressed() async {
    // Prevent multiple taps
    if (_currentState != LoginState.initial) return;

    // Change state to loading
    setState(() {
      _currentState = LoginState.loading;
    });

    // Trigger minimization animation
    await _controller.forward();

    try {
      // Perform login
      await widget.onLogin();

      // If login successful, change to success state
      setState(() {
        _currentState = LoginState.success;
      });

      // Optional: Delay and then reset or navigate
      await Future.delayed(const Duration(seconds: 2));
      _resetButton();
    } catch (e) {
      // If login fails, change to failure state
      setState(() {
        _currentState = LoginState.failure;
      });

      // Show error to user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: $e')),
      );

      // Reset after showing failure
      await Future.delayed(const Duration(seconds: 2));
      _resetButton();
    }
  }

  void _resetButton() {
    // Reset button to initial state
    _controller.reverse();
    setState(() {
      _currentState = LoginState.initial;
    });
  }

  Color _getButtonColor() {
    switch (_currentState) {
      case LoginState.initial:
        return Colors.blue.shade700;
      case LoginState.loading:
        return Colors.blue.shade800;
      case LoginState.success:
        return widget.successColor ?? Colors.green.shade600;
      case LoginState.failure:
        return widget.failureColor ?? Colors.red.shade600;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return GestureDetector(
          onTap: _onLoginPressed,
          child: Container(
            width: _widthAnimation.value,
            height: 50,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  _getButtonColor(),
                  _getButtonColor().withOpacity(0.8),
                ],
              ),
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  offset: const Offset(0, 4),
                  blurRadius: 5.0,
                )
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Original text with fading
                Opacity(
                  opacity: _opacityAnimation.value,
                  child: Text(
                    widget.text,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // Loading indicator (only visible during loading)
                if (_currentState == LoginState.loading)
                  const SizedBox(
                    width: 25,
                    height: 25,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      strokeWidth: 3,
                    ),
                  ),

                // Success checkmark
                if (_currentState == LoginState.success)
                  const Icon(
                    Icons.check_circle_outline,
                    color: Colors.white,
                    size: 30,
                  ),

                // Failure cross
                if (_currentState == LoginState.failure)
                  const Icon(
                    Icons.error_outline,
                    color: Colors.white,
                    size: 30,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

// Enum to manage button states
enum LoginState {
  initial,
  loading,
  success,
  failure,
}

// Example usage with different login scenarios
class LoginScreen extends StatelessWidget {
  // Successful login simulation
  Future<void> _performSuccessfulLogin() async {
    await Future.delayed(const Duration(seconds: 2));
    // Simulating successful login
  }

  // Failed login simulation
  Future<void> _performFailedLogin() async {
    await Future.delayed(const Duration(seconds: 2));
    // Simulating login failure
    throw Exception('Invalid credentials');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Successful login button
            AnimatedLoginButton(
              onLogin: _performSuccessfulLogin,
              text: 'Sucsses',
              successColor: Colors.green.shade600,
            ),
            const SizedBox(height: 20),
            // Failed login button
            AnimatedLoginButton(
              onLogin: _performFailedLogin,
              text: 'Error',
              failureColor: Colors.red.shade600,
            ),
          ],
        ),
      ),
    );
  }
}
