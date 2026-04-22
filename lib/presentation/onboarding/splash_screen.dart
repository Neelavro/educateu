import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:educateu/providers/authentication_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  // ── Single shared controller — comet + loader run on the SAME timeline ──
  // Total: 3600 ms
  //   0% → 6%  : comet fades in
  //   0% → 60% : comet drops          ← seg2 (teal) mirrors this exactly
  //   0% → 5%  : seg1 fills instantly
  //   5% → 65% : seg2 fills (synced with comet drop)
  //  65% →100% : seg3 fills after comet lands
  late final AnimationController _ctrl;
  late final Animation<double> _cometProgress;
  late final Animation<double> _cometFadeIn;
  late final Animation<double> _seg1;
  late final Animation<double> _seg2;
  late final Animation<double> _seg3;

  // Twinkling stars — independent slow loop
  late final AnimationController _twinkleCtrl;
  final List<_StarData> _stars = [];

  static const double _cometStartFraction = 0.38;
  static const double _cometEndFraction   = 0.72;

  @override
  void initState() {
    super.initState();

    // ── Shared controller ────────────────────────────────────────────────
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    // Comet and seg2 use the EXACT same Interval + curve object.
    // This is the only way to guarantee true visual lockstep —
    // different curve types over the same window still diverge frame-by-frame.
    const syncedInterval = Interval(0.05, 0.65, curve: Curves.easeInOut);

    _cometProgress = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _ctrl, curve: syncedInterval),
    );

    // Comet fades in during the first 5%
    _cometFadeIn = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0.0, 0.05, curve: Curves.easeIn),
      ),
    );

    // Loader segments
    _seg1 = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _ctrl,
      curve: const Interval(0.00, 0.05, curve: Curves.easeOut),
    ));
    _seg2 = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _ctrl, curve: syncedInterval), // identical to comet
    );
    _seg3 = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _ctrl,
      curve: const Interval(0.65, 1.00, curve: Curves.easeOut),
    ));

    Future.delayed(const Duration(milliseconds: 150), () {
      if (mounted) _ctrl.forward();
    });

    // Wait for BOTH the animation AND loadSavedStudent to finish,
    // then navigate. Whichever finishes last triggers the check.
    bool _animationDone = false;
    bool _studentLoaded = false;

    void maybeNavigate() {
      if (_animationDone && _studentLoaded && mounted) _navigateAfterLoad();
    }

    _ctrl.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationDone = true;
        maybeNavigate();
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      await context.read<AuthenticationProvider>().loadSavedStudent();
      _studentLoaded = true;
      maybeNavigate();
    });

    // ── Twinkling stars ──────────────────────────────────────────────────
    _twinkleCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    )..repeat();

    final rng = Random(42);
    for (int i = 0; i < 55; i++) {
      _stars.add(_StarData(
        x:     rng.nextDouble(),
        y:     rng.nextDouble(),
        size:  rng.nextDouble() * 1.6 + 0.5,
        phase: rng.nextDouble(),
        speed: rng.nextDouble() * 0.5 + 0.3,
      ));
    }
  }

  void _navigateAfterLoad() {
    final provider = context.read<AuthenticationProvider>();
    if (provider.student != null) {
      context.go('/profile');
    } else {
      context.go('/login');
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _twinkleCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    final cometTopY    = h * _cometStartFraction;
    final cometBottomY = h * _cometEndFraction;
    final cometTravelH = cometBottomY - cometTopY;

    return Scaffold(
      backgroundColor: const Color(0xFF011B2A),
      body: AnimatedBuilder(
        animation: Listenable.merge([_ctrl, _twinkleCtrl]),
        builder: (context, _) {
          final cp      = _cometProgress.value;
          final opacity = _cometFadeIn.value.clamp(0.0, 1.0);

          final headAbsY   = cometTopY + cometTravelH * cp;
          final headAlignY = (headAbsY / h) * 2 - 1; // -1…+1

          return Stack(
            children: [
              // Background: gradient + moving glow + stars
              CustomPaint(
                painter: _BackgroundPainter(
                  stars:         _stars,
                  twinkleT:      _twinkleCtrl.value,
                  glowAlignY:    headAlignY,
                  glowIntensity: opacity,
                ),
                child: const SizedBox.expand(),
              ),

              // Comet
              if (opacity > 0)
                Positioned(
                  left:   w / 2 - 10,
                  top:    cometTopY,
                  width:  20,
                  height: cometTravelH,
                  child: Opacity(
                    opacity: opacity,
                    child: CustomPaint(
                      painter: _CometPainter(
                        progress:    cp,
                        totalHeight: cometTravelH,
                      ),
                    ),
                  ),
                ),

              // Logo
              Positioned(
                top: 0, left: 0, right: 0,
                child: Column(
                  children: [
                    SizedBox(height: h * 0.12),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF1EE9B5).withOpacity(0.15),
                            blurRadius: 60,
                            spreadRadius: 8,
                          ),
                        ],
                      ),
                      child: Image.asset(
                        'assets/splash_screen_logo.png', // ← fixed path
                        width: w * 0.78,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),

              // Segmented loader
              Positioned(
                bottom: 60, left: 0, right: 0,
                child: Column(
                  children: [
                    _SegmentedLoader(
                      seg1: _seg1.value,
                      seg2: _seg2.value,
                      seg3: _seg3.value,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Curating your library',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Color(0xBFFFFFFF),
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// ── Background painter ────────────────────────────────────────────────────────
class _BackgroundPainter extends CustomPainter {
  final List<_StarData> stars;
  final double twinkleT;
  final double glowAlignY;
  final double glowIntensity;

  const _BackgroundPainter({
    required this.stars,
    required this.twinkleT,
    required this.glowAlignY,
    required this.glowIntensity,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    // 1. Base gradient
    canvas.drawRect(
      rect,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF002535),
            Color(0xFF013E5B),
            Color(0xFF011B2A),
          ],
          stops: [0.0, 0.55, 1.0],
        ).createShader(rect),
    );

    // 2. Moving radial glow — tracks comet head
    if (glowIntensity > 0.01) {
      final cy = size.height * ((glowAlignY + 1) / 2);
      final cx = size.width / 2;

      canvas.drawCircle(
        Offset(cx, cy),
        size.width * 0.9,
        Paint()
          ..shader = RadialGradient(
            colors: [
              const Color(0xFF006A6A).withOpacity(0.40 * glowIntensity),
              Colors.transparent,
            ],
          ).createShader(Rect.fromCircle(
            center: Offset(cx, cy),
            radius: size.width * 0.9,
          )),
      );

      canvas.drawCircle(
        Offset(cx, cy),
        size.width * 0.32,
        Paint()
          ..shader = RadialGradient(
            colors: [
              const Color(0xFF1EE9B5).withOpacity(0.20 * glowIntensity),
              Colors.transparent,
            ],
          ).createShader(Rect.fromCircle(
            center: Offset(cx, cy),
            radius: size.width * 0.32,
          )),
      );
    }

    // 3. Star field — dimmed, always visible, individual sine twinkle
    // Opacity range: 0.10 → 0.35 (was 0.30 → 1.0 — now much dimmer)
    for (final s in stars) {
      final cycle   = (twinkleT * s.speed + s.phase) % 1.0;
      final opacity = (sin(cycle * 2 * pi) * 0.12 + 0.22).clamp(0.10, 0.35);
      canvas.drawCircle(
        Offset(s.x * size.width, s.y * size.height),
        s.size,
        Paint()..color = Colors.white.withOpacity(opacity),
      );
    }
  }

  @override
  bool shouldRepaint(_BackgroundPainter old) =>
      old.twinkleT      != twinkleT      ||
          old.glowAlignY    != glowAlignY    ||
          old.glowIntensity != glowIntensity;
}

// ── Comet painter ─────────────────────────────────────────────────────────────
class _CometPainter extends CustomPainter {
  final double progress;
  final double totalHeight;

  const _CometPainter({required this.progress, required this.totalHeight});

  @override
  void paint(Canvas canvas, Size size) {
    final cx    = size.width / 2;
    final headY = totalHeight * progress;
    if (headY < 1) return;

    final tailLen = headY.clamp(0.0, 140.0);
    final tailY   = headY - tailLen;

    // Trail
    canvas.drawLine(
      Offset(cx, tailY),
      Offset(cx, headY),
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            const Color(0xFF1EE9B5).withOpacity(0.5),
            Colors.white.withOpacity(0.92),
          ],
          stops: const [0.0, 0.55, 1.0],
        ).createShader(Rect.fromLTWH(cx - 1, tailY, 2, tailLen))
        ..strokeWidth = 1.8
        ..style       = PaintingStyle.stroke
        ..strokeCap   = StrokeCap.round,
    );

    // Outer bloom
    canvas.drawCircle(
      Offset(cx, headY), 18,
      Paint()
        ..color      = const Color(0xFF1EE9B5).withOpacity(0.14)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 14),
    );
    // Mid glow
    canvas.drawCircle(
      Offset(cx, headY), 8,
      Paint()
        ..color      = const Color(0xFF1EE9B5).withOpacity(0.45)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6),
    );
    // Bright core
    canvas.drawCircle(
      Offset(cx, headY), 2.8,
      Paint()..color = Colors.white,
    );
  }

  @override
  bool shouldRepaint(_CometPainter old) =>
      old.progress != progress || old.totalHeight != totalHeight;
}

// ── Segmented loader ──────────────────────────────────────────────────────────

class _SegmentedLoader extends StatelessWidget {
  final double seg1, seg2, seg3;
  const _SegmentedLoader({
    required this.seg1,
    required this.seg2,
    required this.seg3,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80),
      child: Row(
        children: [
          _Segment(progress: seg1, isActive: false),
          const SizedBox(width: 6),
          _Segment(progress: seg2, isActive: true),
          const SizedBox(width: 6),
          _Segment(progress: seg3, isActive: false),
        ],
      ),
    );
  }
}

class _Segment extends StatelessWidget {
  final double progress;
  final bool isActive;
  const _Segment({required this.progress, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(99),
        child: Stack(
          children: [
            Container(height: 3, color: Colors.white.withOpacity(0.18)),
            FractionallySizedBox(
              widthFactor: progress,
              child: Container(
                height: 3,
                decoration: BoxDecoration(
                  gradient: isActive
                      ? const LinearGradient(
                    colors: [Color(0xFF1EE9B5), Color(0xFF00D0D0)],
                  )
                      : null,
                  color: isActive ? null : Colors.white.withOpacity(0.65),
                  borderRadius: BorderRadius.circular(99),
                  boxShadow: isActive
                      ? [
                    BoxShadow(
                      color: const Color(0xFF1EE9B5).withOpacity(0.7),
                      blurRadius: 8,
                      spreadRadius: 1,
                    )
                  ]
                      : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Star data ─────────────────────────────────────────────────────────────────

class _StarData {
  final double x, y, size, phase, speed;
  const _StarData({
    required this.x,
    required this.y,
    required this.size,
    required this.phase,
    required this.speed,
  });
}