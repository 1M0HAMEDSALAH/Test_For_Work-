import 'package:flutter/material.dart';

class AnimatedLoginButton extends StatefulWidget {
  final Future<void> Function() onLogin;
  final String text;

  const AnimatedLoginButton({
    Key? key, 
    required this.onLogin, 
    this.text = 'Log In',
  }) : super(key: key);

  @override
  _AnimatedLoginButtonState createState() => _AnimatedLoginButtonState();
}

class _AnimatedLoginButtonState extends State<AnimatedLoginButton> with SingleTickerProviderStateMixin {
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
      begin: 250.0,  // Initial width
      end: 50.0,     // Minimized width
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
      await Future.delayed(Duration(seconds: 1));
      _resetButton();
    } catch (e) {
      // If login fails, reset button
      _resetButton();
      
      // Show error to user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: $e')),
      );
    }
  }

  void _resetButton() {
    // Reset button to initial state
    _controller.reverse();
    setState(() {
      _currentState = LoginState.initial;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return GestureDetector(
          onTap: _currentState == LoginState.initial ? _onLoginPressed : null,
          child: Container(
            width: _widthAnimation.value,
            height: 50,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue.shade600,
                  Colors.blue.shade800,
                ],
              ),
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 4),
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
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // Loading indicator (only visible during loading)
                if (_currentState == LoginState.loading)
                  SizedBox(
                    width: 25,
                    height: 25,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      strokeWidth: 3,
                    ),
                  ),

                // Success checkmark (optional)
                if (_currentState == LoginState.success)
                  Icon(
                    Icons.check,
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
}

// Example usage
class LoginScreen extends StatelessWidget {
  Future<void> _performLogin() async {
    // Simulate network delay
    await Future.delayed(Duration(seconds: 5));
    // Add your actual login logic here
    // Throw an exception to test error handling if needed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedLoginButton(
          onLogin: _performLogin,
          text: 'Log In',
        ),
      ),
    );
  }
}