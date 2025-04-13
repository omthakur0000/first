import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class SpinnerScreen extends StatefulWidget {
  final Function(int) onRewardEarned;
  final VoidCallback onSpinUsed;
  final bool canSpin;

  const SpinnerScreen({
    Key? key,
    required this.onRewardEarned,
    required this.onSpinUsed,
    required this.canSpin,
  }) : super(key: key);

  @override
  _SpinnerScreenState createState() => _SpinnerScreenState();
}

class _SpinnerScreenState extends State<SpinnerScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final Random _random = Random();
  final List<int> _rewards = [5, 10, 15, 20, 30, 50, 100];
  int _selectedReward = 0;
  bool _isSpinning = false;
  bool _showReward = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _isSpinning = false;
          _showReward = true;
          // Notify parent about the reward
          widget.onRewardEarned(_selectedReward);
        });
        // Hide reward after 3 seconds
        Future.delayed(const Duration(seconds: 3), () {
          if (mounted) {
            setState(() {
              _showReward = false;
            });
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _spin() {
    if (_isSpinning || !widget.canSpin) {
      return;
    }

    setState(() {
      _isSpinning = true;
      _showReward = false;
    });

    // Notify that a spin was used
    widget.onSpinUsed();

    // Select a random reward
    _selectedReward = _rewards[_random.nextInt(_rewards.length)];

    // Reset the controller and start the animation
    _controller.reset();
    // Random number of rotations between 2 and 5
    final rotations = 2 + _random.nextInt(3);
    // Calculate the final angle to stop at the selected reward
    final endAngle = 2 * pi * rotations + 
                    (2 * pi / _rewards.length) * _rewards.indexOf(_selectedReward);
                    
    _animation = Tween<double>(
      begin: 0,
      end: endAngle,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    ));

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Spin & Win'),
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Spin the wheel to win gold coins!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // The wheel
                    AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        return Transform.rotate(
                          angle: _animation.value,
                          child: Container(
                            width: 300,
                            height: 300,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.amber,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: CustomPaint(
                              painter: WheelPainter(
                                rewards: _rewards,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    // Center point
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 5,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.arrow_downward,
                        color: Colors.red,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Container(
                width: 200,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 5,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: widget.canSpin && !_isSpinning ? _spin : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Text(
                    _isSpinning ? 'Spinning...' : 'SPIN NOW',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              if (!widget.canSpin)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'You have used all your spins for today.\nWatch ads to earn more spins!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          if (_showReward)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.celebration,
                          size: 50,
                          color: Colors.amber,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'You won $_selectedReward coins!',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class WheelPainter extends CustomPainter {
  final List<int> rewards;

  WheelPainter({required this.rewards});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..style = PaintingStyle.fill;
    final double radius = size.width / 2;
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double segmentAngle = 2 * pi / rewards.length;

    // Draw segments
    for (int i = 0; i < rewards.length; i++) {
      // Alternate colors
      paint.color = i % 2 == 0
          ? Colors.amber.shade300
          : Colors.amber.shade700;

      // Draw segment
      final Path path = Path()
        ..moveTo(centerX, centerY)
        ..arcTo(
          Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
          i * segmentAngle,
          segmentAngle,
          false,
        )
        ..close();

      canvas.drawPath(path, paint);

      // Draw reward text
      final textPainter = TextPainter(
        text: TextSpan(
          text: '${rewards[i]}',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();

      // Position text in the middle of each segment
      final double angle = i * segmentAngle + segmentAngle / 2;
      final double textRadius = radius * 0.7; // % of the radius
      final double x = centerX + textRadius * cos(angle) - textPainter.width / 2;
      final double y = centerY + textRadius * sin(angle) - textPainter.height / 2;

      canvas.save();
      canvas.translate(x, y);
      textPainter.paint(canvas, Offset.zero);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
} 