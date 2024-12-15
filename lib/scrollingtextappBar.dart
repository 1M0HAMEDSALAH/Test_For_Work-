import 'package:flutter/material.dart';

class ScrollingTextAppBar extends StatefulWidget {
  final String text;
  final TextStyle? textStyle;
  final double scrollSpeed;

  const ScrollingTextAppBar({
    Key? key,
    required this.text,
    this.textStyle,
    this.scrollSpeed = 10.0,
  }) : super(key: key);

  @override
  _ScrollingTextAppBarState createState() => _ScrollingTextAppBarState();
}

class _ScrollingTextAppBarState extends State<ScrollingTextAppBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0.0;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..addListener(_scrollText);

    // Start the animation after a short delay to ensure layout
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _controller.repeat();
      }
    });
  }

  void _scrollText() {
    // Safely check scroll controller and perform scrolling
    if (_scrollController.hasClients) {
      // Safely get max scroll extent
      final maxScroll = _scrollController.position.maxScrollExtent;

      // Prevent errors if max scroll is 0 or negative
      if (maxScroll > 0) {
        setState(() {
          // Update scroll offset cyclically
          _scrollOffset = (_scrollOffset + widget.scrollSpeed / 60) % maxScroll;
          _scrollController.jumpTo(_scrollOffset);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: _scrollController,
          physics: const NeverScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: constraints.maxWidth),
            child: Text(
              widget.text,
              style: widget.textStyle ??
                  TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
              softWrap: false,
              overflow: TextOverflow.visible,
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}

// Example Usage
class AppBarExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ScrollingTextAppBar(
          text: 'Welcome to Our Amazing App with Very Long Title',
          textStyle: TextStyle(
            color: Colors.deepOrange,
            fontSize: 18,
          ),
        ),
      ),
      body: Center(
        child: Text('App Content'),
      ),
    );
  }
}
