import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smriti_setu/app/theme/app_colors.dart';

class RecordMessageScreen extends StatefulWidget {
  const RecordMessageScreen({super.key});

  static const String sampleMessage =
      'Namaste, I am safe and thinking of you. I will speak to you soon.';

  @override
  State<RecordMessageScreen> createState() => _RecordMessageScreenState();
}

class _RecordMessageScreenState extends State<RecordMessageScreen>
    with SingleTickerProviderStateMixin {
  bool _isRecording = false;
  bool _hasRecorded = false;
  int _seconds = 0;
  Timer? _timer;
  late final AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pulseController.dispose();
    super.dispose();
  }

  void _startRecording() {
    if (_isRecording) return;

    setState(() {
      _isRecording = true;
      _hasRecorded = false;
      _seconds = 0;
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      setState(() {
        _seconds++;
      });

      if (_seconds >= 5) {
        _stopRecording();
      }
    });
  }

  void _stopRecording() {
    if (!_isRecording) return;

    _timer?.cancel();
    setState(() {
      _isRecording = false;
      _hasRecorded = true;
    });
  }

  void _startOver() {
    _timer?.cancel();
    setState(() {
      _isRecording = false;
      _hasRecorded = false;
      _seconds = 0;
    });
  }

  void _handleContinue() {
    if (_isRecording) return;
    context.push('/review', extra: RecordMessageScreen.sampleMessage);
  }

  void _handleCancel() {
    _timer?.cancel();
    if (context.canPop()) {
      context.pop();
    } else {
      context.go('/elderly-home');
    }
  }

  @override
  Widget build(BuildContext context) {
    final timerText = '00:${_seconds.toString().padLeft(2, '0')}';

    return Scaffold(
      backgroundColor: const Color(0xFFFEF8F3),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFEF8F3),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          tooltip: 'Go back',
          onPressed: _handleCancel,
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        title: const Text(
          'Smriti Setu',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Row(
                children: [
                  Icon(Icons.mic_rounded, color: Color(0xFF964319), size: 20),
                  SizedBox(width: 8),
                  Text(
                    'SMRITI SETU MEMORY BRIDGE',
                    style: TextStyle(
                      color: Color(0xFF964319),
                      fontSize: 12,
                      letterSpacing: 1.1,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                'Record a Message',
                style: TextStyle(
                  color: Color(0xFF1D1B18),
                  fontSize: 28,
                  height: 1.25,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Speak naturally. Your message matters.',
                style: TextStyle(
                  color: Color(0xFF55433B),
                  fontSize: 17,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 22),

              // Main recording card
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 24,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFEEE2DA)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.brown.withValues(alpha: 0.06),
                      blurRadius: 16,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    if (_isRecording || _hasRecorded)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: _isRecording
                              ? const Color(0xFFFFE7E4)
                              : const Color(0xFFEAF1EB),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              _isRecording
                                  ? Icons.fiber_manual_record
                                  : Icons.check_circle,
                              color: _isRecording
                                  ? const Color(0xFFBA1A1A)
                                  : const Color(0xFF44664D),
                              size: 17,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              _isRecording
                                  ? 'Recording in progress • $timerText'
                                  : 'Demo recording complete',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: _isRecording
                                    ? const Color(0xFF9B2520)
                                    : const Color(0xFF44664D),
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (_isRecording || _hasRecorded)
                      const SizedBox(height: 20),

                    // Decorative waveform
                    SizedBox(
                      height: 76,
                      child: AnimatedBuilder(
                        animation: _pulseController,
                        builder: (context, child) {
                          const heights = [
                            18.0,
                            30.0,
                            42.0,
                            25.0,
                            52.0,
                            36.0,
                            62.0,
                            43.0,
                            70.0,
                            38.0,
                            55.0,
                            28.0,
                            46.0,
                            32.0,
                            60.0,
                            24.0,
                            16.0,
                          ];

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(heights.length, (index) {
                              final animationFactor = _isRecording
                                  ? 0.75 + _pulseController.value * 0.25
                                  : 1.0;

                              return Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 2,
                                ),
                                width: 4,
                                height:
                                    heights[index] *
                                    (_isRecording
                                        ? animationFactor
                                        : _hasRecorded
                                        ? 0.65
                                        : 0.45),
                                decoration: BoxDecoration(
                                  color: _isRecording
                                      ? const Color(0xFF964319)
                                      : const Color(
                                          0xFFB65B2F,
                                        ).withValues(alpha: 0.65),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              );
                            }),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Main microphone control
                    AnimatedBuilder(
                      animation: _pulseController,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _isRecording
                              ? 1 + _pulseController.value * 0.06
                              : 1,
                          child: child,
                        );
                      },
                      child: Semantics(
                        button: true,
                        label: _isRecording
                            ? 'Stop demo recording'
                            : 'Start demo recording',
                        child: InkWell(
                          onTap: _isRecording
                              ? _stopRecording
                              : _startRecording,
                          customBorder: const CircleBorder(),
                          child: Container(
                            width: 112,
                            height: 112,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _isRecording
                                  ? const Color(0xFFBA1A1A)
                                  : _hasRecorded
                                  ? const Color(0xFF44664D)
                                  : const Color(0xFF964319),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFF964319,
                                  ).withValues(alpha: 0.22),
                                  blurRadius: 22,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                            child: Icon(
                              _isRecording
                                  ? Icons.stop_rounded
                                  : _hasRecorded
                                  ? Icons.check_rounded
                                  : Icons.mic_rounded,
                              color: Colors.white,
                              size: 46,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),

                    // The label is independently tappable for accessibility
                    // and compatibility with the widget test.
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: _isRecording ? _stopRecording : _startRecording,
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Text(
                          _isRecording
                              ? 'STOP RECORDING'
                              : _hasRecorded
                              ? 'RECORD AGAIN'
                              : 'START RECORDING',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: _isRecording
                                ? const Color(0xFFBA1A1A)
                                : const Color(0xFF964319),
                            fontSize: 19,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _isRecording
                          ? 'Demo timer: $timerText'
                          : _hasRecorded
                          ? 'Sample message ready to review'
                          : 'Tap the microphone above',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFF55433B),
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Kept exactly as expected by the existing widget test.
                    Text(
                      '“${RecordMessageScreen.sampleMessage}”',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFF1D1B18),
                        fontSize: 16,
                        height: 1.5,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'Demo mode • No audio is recorded',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xFF88726A), fontSize: 12),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),

              // Reassuring prompt
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9F3ED),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 23,
                      backgroundColor: Color(0xFFEDE7E2),
                      child: Icon(
                        Icons.hearing_rounded,
                        color: Color(0xFF964319),
                        size: 25,
                      ),
                    ),
                    SizedBox(width: 13),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Need an idea of what to say?',
                            style: TextStyle(
                              color: Color(0xFF1D1B18),
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            '“Tell a loved one about your day, a childhood memory, or a festival.”',
                            style: TextStyle(
                              color: Color(0xFF55433B),
                              fontSize: 14,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              FilledButton.icon(
                onPressed: _isRecording ? null : _handleContinue,
                icon: const Icon(Icons.check_circle_outline_rounded, size: 23),
                label: const Text('CONTINUE TO REVIEW'),
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(58),
                  backgroundColor: const Color(0xFF44664D),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: _startOver,
                icon: const Icon(Icons.restart_alt_rounded, size: 23),
                label: const Text('START OVER'),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(54),
                  foregroundColor: const Color(0xFF55433B),
                  side: const BorderSide(color: Color(0xFFDBC1B7), width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                'Take your time. You can review and start over before sending.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF55433B),
                  fontSize: 13,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: TextButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Tap START RECORDING to begin the demo, then CONTINUE TO REVIEW.',
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.volume_up_rounded),
                  label: const Text('Hear this screen'),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.primaryDark,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: _handleCancel,
                child: const Text('CANCEL'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
