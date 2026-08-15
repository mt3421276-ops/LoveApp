import 'dart:math';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const LoveApp());
}

// ============================================================
// مشغل الموسيقى - يبقى موجودًا أثناء التنقل بين الصفحات
// ============================================================

final AudioPlayer lovePlayer = AudioPlayer();

bool musicPlaying = false;

// ============================================================
// التطبيق
// ============================================================

class LoveApp extends StatefulWidget {
  const LoveApp({super.key});

  @override
  State<LoveApp> createState() => _LoveAppState();
}

class _LoveAppState extends State<LoveApp> {
  @override
  void initState() {
    super.initState();

    _startMusic();
  }

  Future<void> _startMusic() async {
    try {
      await lovePlayer.setReleaseMode(ReleaseMode.loop);
      await lovePlayer.setVolume(0.35);

      await lovePlayer.play(
        AssetSource('audio/love_song.mp3'),
      );

      musicPlaying = true;
    } catch (e) {
      debugPrint('Music error: $e');
    }
  }

  @override
  void dispose() {
    lovePlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'رهف ❤️',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

// ============================================================
// الانتقال بين الصفحات
// ============================================================

void goTo(BuildContext context, Widget page) {
  Navigator.push(
    context,
    PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 750),
      reverseTransitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (_, animation, __) => page,
      transitionsBuilder: (_, animation, __, child) {
        final curve = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
        );

        return FadeTransition(
          opacity: curve,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.06, 0.02),
              end: Offset.zero,
            ).animate(curve),
            child: child,
          ),
        );
      },
    ),
  );
}

// ============================================================
// الألوان
// ============================================================

const Color night1 = Color(0xFF080914);
const Color night2 = Color(0xFF171026);
const Color night3 = Color(0xFF35152D);

const Color pink = Color(0xFFFF6F9C);
const Color pinkLight = Color(0xFFFFB7CB);
const Color whiteText = Color(0xFFFFF8FB);

// ============================================================
// الخلفية
// ============================================================

class RomanticBackground extends StatefulWidget {
  final Widget child;

  const RomanticBackground({
    super.key,
    required this.child,
  });

  @override
  State<RomanticBackground> createState() =>
      _RomanticBackgroundState();
}

class _RomanticBackgroundState extends State<RomanticBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 18),
    )..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            night1,
            night2,
            night3,
            night1,
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: AnimatedBuilder(
              animation: controller,
              builder: (_, __) {
                return CustomPaint(
                  painter: StarPainter(
                    progress: controller.value,
                  ),
                );
              },
            ),
          ),

          Positioned(
            top: -100,
            right: -80,
            child: _glow(240),
          ),

          Positioned(
            bottom: -120,
            left: -100,
            child: _glow(280),
          ),

          const Positioned(
            top: 55,
            right: 30,
            child: Moon(),
          ),

          SafeArea(
            child: widget.child,
          ),
        ],
      ),
    );
  }

  Widget _glow(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: pink.withOpacity(0.035),
        boxShadow: [
          BoxShadow(
            color: pink.withOpacity(0.08),
            blurRadius: 100,
            spreadRadius: 30,
          ),
        ],
      ),
    );
  }
}

// ============================================================
// النجوم
// ============================================================

class StarPainter extends CustomPainter {
  final double progress;

  StarPainter({
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final random = Random(77);

    for (int i = 0; i < 75; i++) {
      final x = random.nextDouble() * size.width;
      final baseY = random.nextDouble() * size.height;

      final y =
          (baseY + sin(progress * 2 * pi + i) * 3) %
              size.height;

      final twinkle =
          (sin(progress * 2 * pi * 2 + i) + 1) / 2;

      final radius = 0.5 + random.nextDouble() * 1.3;

      final paint = Paint()
        ..color = Colors.white.withOpacity(
          0.18 + twinkle * 0.45,
        );

      canvas.drawCircle(
        Offset(x, y),
        radius,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant StarPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

// ============================================================
// القمر
// ============================================================

class Moon extends StatelessWidget {
  const Moon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFFFFE9F1),
        boxShadow: [
          BoxShadow(
            color: pinkLight.withOpacity(0.25),
            blurRadius: 25,
            spreadRadius: 5,
          ),
        ],
      ),
      child: const Align(
        alignment: Alignment(-0.45, -0.25),
        child: SizedBox(
          width: 42,
          height: 42,
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: night1,
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================
// القلب النابض
// ============================================================

class PulsingHeart extends StatefulWidget {
  final double size;

  const PulsingHeart({
    super.key,
    this.size = 80,
  });

  @override
  State<PulsingHeart> createState() =>
      _PulsingHeartState();
}

class _PulsingHeartState extends State<PulsingHeart>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1300),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        final scale =
            0.92 + controller.value * 0.10;

        return Transform.scale(
          scale: scale,
          child: Icon(
            Icons.favorite_rounded,
            color: pink,
            size: widget.size,
            shadows: [
              Shadow(
                color: pink.withOpacity(0.65),
                blurRadius: 25,
              ),
            ],
          ),
        );
      },
    );
  }
}

// ============================================================
// زر الموسيقى
// ============================================================

class MusicButton extends StatefulWidget {
  const MusicButton({super.key});

  @override
  State<MusicButton> createState() =>
      _MusicButtonState();
}

class _MusicButtonState extends State<MusicButton> {
  @override
  void initState() {
    super.initState();

    lovePlayer.onPlayerStateChanged.listen((state) {
      if (!mounted) return;

      setState(() {
        musicPlaying =
            state == PlayerState.playing;
      });
    });
  }

  Future<void> toggleMusic() async {
    if (musicPlaying) {
      await lovePlayer.pause();
    } else {
      await lovePlayer.resume();
    }

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: toggleMusic,
        borderRadius: BorderRadius.circular(30),
        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            shape: BoxShape.circle,
            border: Border.all(
              color: pink.withOpacity(0.35),
            ),
            boxShadow: [
              BoxShadow(
                color: pink.withOpacity(0.08),
                blurRadius: 15,
              ),
            ],
          ),
          child: Icon(
            musicPlaying
                ? Icons.music_note_rounded
                : Icons.music_off_rounded,
            color: pinkLight,
            size: 22,
          ),
        ),
      ),
    );
  }
}

// ============================================================
// الشاشة الرئيسية
// ============================================================

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() =>
      _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: night1,
      body: RomanticBackground(
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  26,
                  45,
                  26,
                  30,
                ),
                child: FadeTransition(
                  opacity: CurvedAnimation(
                    parent: controller,
                    curve: Curves.easeIn,
                  ),
                  child: Column(
                    children: [
                      const PulsingHeart(size: 82),

                      const SizedBox(height: 22),

                      const Text(
                        'رهف',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: whiteText,
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Container(
                        width: 55,
                        height: 2,
                        decoration: BoxDecoration(
                          color: pink,
                          borderRadius:
                              BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  pink.withOpacity(0.5),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 35),

                      const Text(
                        'إلى الإنسانة التي أتمنى أن تسامحني...',
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          color: pinkLight,
                          fontSize: 20,
                          height: 1.6,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox(height: 25),

                      GlassCard(
                        child: const Text(
                          'صنعتُ هذا الشيء بنفسي.\n\n'
                          'ليس لأغيّر قرارك،\n'
                          'ولا لأجبرك على شيء.\n\n'
                          'فقط لأن هناك أشياء كثيرة\n'
                          'أريد أن أقولها لك.',
                          textAlign: TextAlign.center,
                          textDirection:
                              TextDirection.rtl,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            height: 1.9,
                          ),
                        ),
                      ),

                      const SizedBox(height: 35),

                      LoveButton(
                        text: 'ابدئي قصتي  ♥',
                        onPressed: () {
                          goTo(
                            context,
                            const PageOne(),
                          );
                        },
                      ),

                      const SizedBox(height: 18),

                      const Text(
                        'خذي وقتك... لا يوجد أي ضغط',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white38,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const Positioned(
              top: 15,
              left: 18,
              child: MusicButton(),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// الصفحة الأولى
// ============================================================

class PageOne extends StatelessWidget {
  const PageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return StoryPage(
      number: '01  /  04',
      title: 'أول شيء أريدك تعرفيه...',
      text:
          'رهف، آسف.\n\n'
          'والله ندمت أنني كلمتك بالطريقة التي كلمتك بها.\n\n'
          'الحقيقة أنني لم أتواصل معك لأني اشتقت لك، '
          'أو لأني توقفت عن حبك.\n\n'
          'كنت فقط أريد أن أعرف لماذا تخليتِ عني.\n\n'
          'لكنني أدركت بعدها أن هذا لا يبرر الطريقة التي تصرفت بها، '
          'ولا الكلام الذي ممكن يكون جرحك.\n\n'
          'أنا غلطت، وأنا آسف.',
      buttons: [
        LoveButton(
          text: 'أريد أن أسمع باقي كلامك  ♥',
          onPressed: () {
            goTo(context, const PageTwo());
          },
        ),
        const SizedBox(height: 14),
        OutlineLoveButton(
          text: 'أحتاج لحظة  ♡',
          onPressed: () {
            goTo(context, const PausePage());
          },
        ),
      ],
    );
  }
}

// ============================================================
// الصفحة الثانية
// ============================================================

class PageTwo extends StatelessWidget {
  const PageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return StoryPage(
      number: '02  /  04',
      title: 'الأشياء التي ندمت عليها',
      text:
          'أعترف أنني جرحتك، وأعرف أنني أخطأت أكثر من مرة.\n\n'
          'وأنا آسف لأنني لم أرد عليك عندما قلتِ لي شيئًا عني، '
          'وسكتُّ بدل أن أفهمك وأتكلم معك بطريقة أفضل.\n\n'
          'وآسف على كل مرة جرحتك فيها، '
          'أو جعلتك تبكين، '
          'أو نزلت من عينيك دمعة بسببي.\n\n'
          'وآسف إذا جعلتك تشعرين يومًا أنك ندمتِ '
          'لأنك وافقتِ أن ترتبطي بي.\n\n'
          'أكثر شيء يؤلمني أن يكون الشخص الذي يحبك '
          'هو نفسه سبب حزنك.',
      buttons: [
        LoveButton(
          text: 'أريد أن أعرف ماذا تعلمت  ♥',
          onPressed: () {
            goTo(context, const PageThree());
          },
        ),
        const SizedBox(height: 14),
        OutlineLoveButton(
          text: 'أحتاج أن أفكر قليلًا',
          onPressed: () {
            goTo(context, const PausePage());
          },
        ),
      ],
    );
  }
}

// ============================================================
// الصفحة الثالثة
// ============================================================

class PageThree extends StatelessWidget {
  const PageThree({super.key});

  @override
  Widget build(BuildContext context) {
    return StoryPage(
      number: '03  /  04',
      title: 'ماذا تعلمت؟',
      text:
          'تعلمت شيئًا مهمًا جدًا.\n\n'
          'تعلمت أن وجود شخص يصبر عليك، '
          'ويسامحك عندما تخطئ، '
          'ويحاول أن يفهمك رغم أخطائك، '
          'ليس شيئًا يجب أن تأخذه كأنه مضمون.\n\n'
          'تعلمت أن الاعتذار وحده لا يكفي.\n\n'
          'وإذا كنت أريد أن أبقى معك، '
          'فلازم أثبت لك بأفعالي أنني تعلمت من أخطائي.',
      buttons: [
        LoveButton(
          text: 'أريد أن أعرف وعدك  ♥',
          onPressed: () {
            goTo(
              context,
              const PromisePage(),
            );
          },
        ),
        const SizedBox(height: 14),
        OutlineLoveButton(
          text: 'أريد أن أكمل القراءة',
          onPressed: () {
            goTo(
              context,
              const PromisePage(),
            );
          },
        ),
      ],
    );
  }
}

// ============================================================
// صفحة الوعد
// ============================================================

class PromisePage extends StatelessWidget {
  const PromisePage({super.key});

  @override
  Widget build(BuildContext context) {
    return StoryPage(
      title: 'وعدي لك',
      text:
          'أعدك أن أكون أوفى لك.\n\n'
          'أعدك أن أحترمك ومشاعرك.\n\n'
          'وأعدك أنني لن أتعمد خيانتك أو البحث عن شخص آخر خلفك.\n\n'
          'ولا أريد أن يكون هذا مجرد كلام أقوله اليوم.\n\n'
          'أريد أن تثبته الأيام والأفعال.\n\n'
          'لأنك تعنين لي الكثير.',
      buttons: [
        LoveButton(
          text: 'أريد أن أعرف ما في قلبك  ♥',
          onPressed: () {
            goTo(
              context,
              const PageFour(),
            );
          },
        ),
      ],
    );
  }
}

// ============================================================
// الصفحة الرابعة
// ============================================================

class PageFour extends StatelessWidget {
  const PageFour({super.key});

  @override
  Widget build(BuildContext context) {
    return StoryPage(
      number: '04  /  04',

      // ======================================================
      // التعديل الوحيد: إضافة صورة رهف
      // ======================================================
      photoAsset: 'assets/images/rahaf.jpg',

      title: 'وأخيرًا... من قلبي',
      text:
          'رهف...\n\n'
          'أنا أحبك.\n\n'
          'أحبك جدًا، وأعشق اليوم الذي عرفتك فيه، '
          'واليوم الذي دخلتِ فيه حياتي.\n\n'
          'وأعرف أن كلمة "أحبك" لن تمسح الأشياء التي حصلت، '
          'ولن تجعل الألم يختفي بمجرد أن تقرئيها.\n\n'
          'لذلك أنا لا أطلب منك أن تنسي.\n\n'
          'ولا أطلب منك أن تتجاهلي ما حصل.\n\n'
          'كل ما أتمناه أن تسمحي لي بفرصة أخيرة '
          'أثبت لك فيها أنني أستطيع أن أكون أفضل.\n\n'
          'أريد أن أكمل معك، ليس لأضحك عليك، '
          'ولا لأقول كلامًا جميلًا ثم أعود لنفس الأخطاء.\n\n'
          'أريد أن أكمل لأنني أحبك، '
          'ولأنك أصبحتِ شخصًا مهمًا جدًا في حياتي.\n\n'
          'أتمنى أن تسامحيني يا رهف، '
          'وتعطيني فرصة أخيرة. ❤️',
      buttons: [
        LoveButton(
          text: 'أعطيك فرصة أخيرة  ♥',
          onPressed: () {
            goTo(
              context,
              const NewBeginningPage(),
            );
          },
        ),
        const SizedBox(height: 14),
        OutlineLoveButton(
          text: 'أحتاج وقتًا  🌷',
          onPressed: () {
            goTo(
              context,
              const TimePage(),
            );
          },
        ),
      ],
    );
  }
}

// ============================================================
// بداية جديدة
// ============================================================

class NewBeginningPage extends StatelessWidget {
  const NewBeginningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StoryPage(
      showBack: false,
      specialHeart: true,
      title: 'لنبدأ من جديد ❤️',
      text:
          'ليس وكأن شيئًا لم يحدث...\n\n'
          'بل وكأننا تعلمنا منه.\n\n'
          'شكرًا لأنك أعطيتني فرصة جديدة.\n\n'
          'هذه المرة سأحاول أن أجعل أفعالي '
          'تتكلم بدلًا من كلامي.\n\n'
          'وأتمنى أن تكون الأيام القادمة أجمل من كل ما مضى.',
      buttons: [
        LoveButton(
          text: 'نبدأ من جديد  ♥',
          onPressed: () {
            Navigator.popUntil(
              context,
              (route) => route.isFirst,
            );
          },
        ),
      ],
    );
  }
}

// ============================================================
// تحتاج وقتًا
// ============================================================

class TimePage extends StatelessWidget {
  const TimePage({super.key});

  @override
  Widget build(BuildContext context) {
    return StoryPage(
      specialHeart: true,
      title: 'خذي وقتك 🌷',
      text:
          'لن أضغط عليك.\n\n'
          'خذي الوقت الذي تحتاجينه.\n\n'
          'أنا فقط أردت أن تعرفي ما في قلبي.\n\n'
          'ومهما كان قرارك، '
          'أتمنى أن تعرفي أن هذه الكلمات كانت صادقة.\n\n'
          'سأحترم قرارك ووقتك.',
      buttons: [
        OutlineLoveButton(
          text: 'العودة',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

// ============================================================
// لحظة توقف
// ============================================================

class PausePage extends StatelessWidget {
  const PausePage({super.key});

  @override
  Widget build(BuildContext context) {
    return StoryPage(
      title: 'خذي لحظتك 🌷',
      text:
          'لا داعي للاستعجال.\n\n'
          'خذي لحظتك وفكري براحتك.\n\n'
          'هذا التطبيق ليس سباقًا، '
          'ولا يوجد شيء يجبرك على الاستمرار.\n\n'
          'عندما تكونين مستعدة، يمكنك العودة وإكمال الرسالة.',
      buttons: [
        LoveButton(
          text: 'أكمل الرسالة  ♥',
          onPressed: () {
            goTo(
              context,
              const PageTwo(),
            );
          },
        ),
        const SizedBox(height: 14),
        OutlineLoveButton(
          text: 'العودة',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

// ============================================================
// قالب صفحات القصة
// ============================================================

class StoryPage extends StatelessWidget {
  final String? number;
  final String title;
  final String text;
  final List<Widget> buttons;
  final bool showBack;
  final bool specialHeart;

  // ============================================================
  // التعديل الوحيد: مسار الصورة اختياري
  // الصفحات الأخرى لن تتأثر
  // ============================================================

  final String? photoAsset;

  const StoryPage({
    super.key,
    this.number,
    required this.title,
    required this.text,
    required this.buttons,
    this.showBack = true,
    this.specialHeart = false,
    this.photoAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: night1,
      body: RomanticBackground(
        child: Stack(
          children: [
            Column(
              children: [
                if (showBack)
                  Align(
                    alignment:
                        AlignmentDirectional.topStart,
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.only(
                        start: 8,
                        top: 4,
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white70,
                          size: 19,
                        ),
                      ),
                    ),
                  )
                else
                  const SizedBox(height: 38),

                Expanded(
                  child: SingleChildScrollView(
                    padding:
                        const EdgeInsets.fromLTRB(
                      23,
                      5,
                      23,
                      30,
                    ),
                    child: Column(
                      children: [
                        if (specialHeart) ...[
                          const PulsingHeart(size: 55),
                          const SizedBox(height: 15),
                        ],

                        if (photoAsset != null) ...[
                          Container(
                            width: 155,
                            height: 155,
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: pink,
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      pink.withOpacity(0.35),
                                  blurRadius: 25,
                                  spreadRadius: 3,
                                ),
                              ],
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                photoAsset!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],

                        if (number != null) ...[
                          Text(
                            number!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: pink,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                          ),
                          const SizedBox(height: 22),
                        ],

                        Text(
                          title,
                          textAlign: TextAlign.center,
                          textDirection:
                              TextDirection.rtl,
                          style: const TextStyle(
                            color: whiteText,
                            fontSize: 29,
                            height: 1.35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 18),

                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 35,
                              height: 1,
                              color:
                                  pink.withOpacity(0.6),
                            ),
                            const Padding(
                              padding:
                                  EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Icon(
                                Icons.favorite_rounded,
                                color: pink,
                                size: 15,
                              ),
                            ),
                            Container(
                              width: 35,
                              height: 1,
                              color:
                                  pink.withOpacity(0.6),
                            ),
                          ],
                        ),

                        const SizedBox(height: 25),

                        GlassCard(
                          child: Text(
                            text,
                            textAlign: TextAlign.center,
                            textDirection:
                                TextDirection.rtl,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              height: 2,
                            ),
                          ),
                        ),

                        const SizedBox(height: 30),

                        ...buttons,

                        const SizedBox(height: 12),

                        if (number != null)
                          _Progress(
                            number: number!,
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            Positioned(
              top: 12,
              left: 18,
              child: const MusicButton(),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// البطاقة الزجاجية
// ============================================================

class GlassCard extends StatelessWidget {
  final Widget child;

  const GlassCard({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(23),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.065),
        borderRadius: BorderRadius.circular(27),
        border: Border.all(
          color: pinkLight.withOpacity(0.13),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.18),
            blurRadius: 25,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: child,
    );
  }
}

// ============================================================
// شريط التقدم
// ============================================================

class _Progress extends StatelessWidget {
  final String number;

  const _Progress({
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    int current = 1;

    if (number.startsWith('02')) {
      current = 2;
    } else if (number.startsWith('03')) {
      current = 3;
    } else if (number.startsWith('04')) {
      current = 4;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        4,
        (index) => AnimatedContainer(
          duration:
              const Duration(milliseconds: 300),
          margin:
              const EdgeInsets.symmetric(horizontal: 4),
          width:
              index + 1 == current ? 22 : 7,
          height: 7,
          decoration: BoxDecoration(
            color: index + 1 == current
                ? pink
                : Colors.white.withOpacity(0.22),
            borderRadius:
                BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}

// ============================================================
// الزر الرئيسي
// ============================================================

class LoveButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const LoveButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 58,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: pink,
          foregroundColor:
              const Color(0xFF30111E),
          elevation: 8,
          shadowColor:
              pink.withOpacity(0.25),
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(19),
          ),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          textDirection:
              TextDirection.rtl,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// ============================================================
// الزر الثانوي
// ============================================================

class OutlineLoveButton
    extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const OutlineLoveButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 57,
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: pinkLight,
          side: BorderSide(
            color: pink.withOpacity(0.48),
          ),
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(19),
          ),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          textDirection:
              TextDirection.rtl,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
