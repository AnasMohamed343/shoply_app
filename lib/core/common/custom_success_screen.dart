import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shoply/constants.dart';
import 'package:shoply/core/Styles.dart';
import 'package:shoply/view/widgets/custom_button.dart';

class CustomSuccessScreen extends StatefulWidget {
  final String title;
  final String subtitle;
  final VoidCallback onPressed;

  const CustomSuccessScreen({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<CustomSuccessScreen> createState() => _CustomSuccessScreenState();
}

class _CustomSuccessScreenState extends State<CustomSuccessScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _controller.repeat(period: const Duration(seconds: 3));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Lottie animation for order completion
              Lottie.network(
                'https://lottie.host/d4d5aff2-96c9-4402-8cb4-227a9a2570f2/GghJnuHVQP.json',
                repeat: true,
                backgroundLoading: true,
                width: w * 0.6,
                height: h * 0.6,
                frameRate: const FrameRate(60),
                controller: _controller,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error_outline);
                },
                animate: true,
              ),
              const SizedBox(height: 24),

              // Title
              Text(
                widget.title,
                style: Styles.textStyle24,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              // Subtitle
              Text(
                widget.subtitle,
                style: Styles.textStyle16.copyWith(color: kGreyColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

              // Button to proceed
              CustomButton(
                buttonText: 'Go to Home',
                onPressed: widget.onPressed,
                borderRadius: 15,
                fixedSize: Size(w * 0.5, h * 0.06),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
