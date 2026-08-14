import 'package:flutter/material.dart';

void main() {
  runApp(const LoveApp());
}

class LoveApp extends StatelessWidget {
  const LoveApp({super.key});

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

// =====================================================
// الألوان
// =====================================================

const Color bg1 = Color(0xFF160C15);
const Color bg2 = Color(0xFF3A1729);
const Color pink = Color(0xFFFF789F);
const Color lightPink = Color(0xFFFFD5E1);
const Color textWhite = Color(0xFFFFF8FA);

// =====================================================
// الانتقال بين الصفحات
// =====================================================

void goTo(BuildContext context, Widget page) {
  Navigator.push(
    context,
    PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 650),
      reverseTransitionDuration: const Duration(milliseconds: 450),
      pageBuilder: (_, animation, __) => page,
      transitionsBuilder: (_, animation, __, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
        );

        return FadeTransition(
          opacity: curved,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.08, 0),
              end: Offset.zero,
            ).animate(curved),
            child: child,
          ),
        );
      },
    ),
  );
}

// =====================================================
// الخلفية
// =====================================================

class LoveBackground extends StatelessWidget {
  final Widget child;

  const LoveBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            bg1,
            bg2,
            Color(0xFF120910),
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -90,
            right: -80,
            child: _glow(230),
          ),
          Positioned(
            bottom: -120,
            left: -100,
            child: _glow(280),
          ),
          SafeArea(child: child),
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
        color: pink.withOpacity(0.07),
        boxShadow: [
          BoxShadow(
            color: pink.withOpacity(0.08),
            blurRadius: 100,
            spreadRadius: 35,
          ),
        ],
      ),
    );
  }
}

// =====================================================
// الشاشة الرئيسية
// =====================================================

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoveBackground(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(28),
            child: FadeTransition(
              opacity: CurvedAnimation(
                parent: controller,
                curve: Curves.easeIn,
              ),
              child: Column(
                children: [
                  const Text(
                    '♡',
                    style: TextStyle(
                      color: pink,
                      fontSize: 90,
                      height: 1,
                    ),
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    'رهف',
                    style: TextStyle(
                      color: textWhite,
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Container(
                    width: 45,
                    height: 2,
                    color: pink,
                  ),

                  const SizedBox(height: 35),

                  const Text(
                    'إلى الإنسانة التي أتمنى أن تسامحني...',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: lightPink,
                      fontSize: 20,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 25),

                  const Text(
                    'صنعتُ هذا الشيء بنفسي.\n\n'
                    'ليس لأغيّر قرارك،\n'
                    'ولا لأجبرك على شيء.\n\n'
                    'فقط لأن هناك أشياء كثيرة\n'
                    'أريد أن أقولها لك.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 45),

                  LoveButton(
                    text: 'ابدئي قصتي  ♥',
                    onPressed: () {
                      goTo(context, const PageOne());
                    },
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'خذي وقتك... لا يوجد أي ضغط',
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
      ),
    );
  }
}

// =====================================================
// الصفحة الأولى
// =====================================================

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

// =====================================================
// الصفحة الثانية
// =====================================================

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

// =====================================================
// الصفحة الثالثة
// =====================================================

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
          text: 'أخبريني ماذا أعدك  ♥',
          onPressed: () {
            goTo(context, const PromisePage());
          },
        ),
        const SizedBox(height: 14),
        OutlineLoveButton(
          text: 'أريد أن أكمل القراءة',
          onPressed: () {
            goTo(context, const PromisePage());
          },
        ),
      ],
    );
  }
}

// =====================================================
// صفحة الوعود
// =====================================================

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
            goTo(context, const PageFour());
          },
        ),
      ],
    );
  }
}

// =====================================================
// الصفحة الرابعة
// =====================================================

class PageFour extends StatelessWidget {
  const PageFour({super.key});

  @override
  Widget build(BuildContext context) {
    return StoryPage(
      number: '04  /  04',
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
            goTo(context, const NewBeginningPage());
          },
        ),
        const SizedBox(height: 14),
        OutlineLoveButton(
          text: 'أحتاج وقتًا  ♡',
          onPressed: () {
            goTo(context, const TimePage());
          },
        ),
      ],
    );
  }
}

// =====================================================
// النهاية: فرصة جديدة
// =====================================================

class NewBeginningPage extends StatelessWidget {
  const NewBeginningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StoryPage(
      showBack: false,
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

// =====================================================
// النهاية: تحتاج وقت
// =====================================================

class TimePage extends StatelessWidget {
  const TimePage({super.key});

  @override
  Widget build(BuildContext context) {
    return StoryPage(
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

// =====================================================
// صفحة التوقف
// =====================================================

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
            goTo(context, const PageTwo());
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

// =====================================================
// قالب صفحات القصة
// =====================================================

class StoryPage extends StatelessWidget {
  final String? number;
  final String title;
  final String text;
  final List<Widget> buttons;
  final bool showBack;

  const StoryPage({
    super.key,
    this.number,
    required this.title,
    required this.text,
    required this.buttons,
    this.showBack = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg1,
      body: LoveBackground(
        child: Column(
          children: [
            if (showBack)
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: 10,
                    top: 5,
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white70,
                      size: 20,
                    ),
                  ),
                ),
              )
            else
              const SizedBox(height: 48),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  24,
                  8,
                  24,
                  30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
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
                      const SizedBox(height: 25),
                    ],

                    Text(
                      title,
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                      style: const TextStyle(
                        color: textWhite,
                        fontSize: 29,
                        height: 1.35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 22),

                    Center(
                      child: Container(
                        width: 45,
                        height: 2,
                        decoration: BoxDecoration(
                          color: pink,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),

                    const SizedBox(height: 28),

                    Container(
                      padding: const EdgeInsets.all(23),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.06),
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.08),
                        ),
                      ),
                      child: Text(
                        text,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          height: 2,
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    ...buttons,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================
// الزر الرئيسي
// =====================================================

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
      height: 57,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: pink,
          foregroundColor: const Color(0xFF32121F),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// =====================================================
// الزر الثانوي
// =====================================================

class OutlineLoveButton extends StatelessWidget {
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
          foregroundColor: lightPink,
          side: BorderSide(
            color: pink.withOpacity(0.45),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
