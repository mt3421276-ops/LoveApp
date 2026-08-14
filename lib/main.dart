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
      title: 'إليكِ',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'sans',
      ),
      home: const HomePage(),
    );
  }
}

// ======================================================
// ألوان التطبيق
// ======================================================

const Color backgroundTop = Color(0xFF180F18);
const Color backgroundBottom = Color(0xFF3A1829);
const Color cardColor = Color(0x33FFFFFF);
const Color primaryPink = Color(0xFFFF7FA8);
const Color softPink = Color(0xFFFFD6E2);
const Color whiteSoft = Color(0xFFFDF8FA);

// ======================================================
// انتقال بين الصفحات
// ======================================================

void goTo(BuildContext context, Widget page) {
  Navigator.push(
    context,
    PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 700),
      reverseTransitionDuration: const Duration(milliseconds: 500),
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

// ======================================================
// الخلفية المشتركة
// ======================================================

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
            backgroundTop,
            backgroundBottom,
            Color(0xFF160B14),
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -100,
            right: -80,
            child: _glow(220),
          ),
          Positioned(
            bottom: -120,
            left: -100,
            child: _glow(260),
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
        color: primaryPink.withOpacity(0.08),
        boxShadow: [
          BoxShadow(
            color: primaryPink.withOpacity(0.08),
            blurRadius: 100,
            spreadRadius: 40,
          ),
        ],
      ),
    );
  }
}

// ======================================================
// الشاشة الرئيسية
// ======================================================

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fade = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _scale = Tween<double>(
      begin: 0.75,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
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
              opacity: _fade,
              child: ScaleTransition(
                scale: _scale,
                child: Column(
                  children: [
                    const Text(
                      '♡',
                      style: TextStyle(
                        color: primaryPink,
                        fontSize: 85,
                        height: 1,
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      'إليكِ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: whiteSoft,
                        fontSize: 46,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Container(
                      width: 55,
                      height: 2,
                      color: primaryPink.withOpacity(0.7),
                    ),

                    const SizedBox(height: 35),

                    const Text(
                      'صنعتُ هذا الشيء بنفسي...',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: softPink,
                        fontSize: 21,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 22),

                    const Text(
                      'ليس لأغيّر قرارك،\n'
                      'ولا لأجبرك على مسامحتي.\n\n'
                      'فقط لأن هناك أشياء كثيرة\n'
                      'كنت أريد أن أقولها لك.',
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
                        goTo(context, const ConfessionPage());
                      },
                    ),

                    const SizedBox(height: 20),

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
      ),
    );
  }
}

// ======================================================
// الصفحة الأولى
// ======================================================

class ConfessionPage extends StatelessWidget {
  const ConfessionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StoryPage(
      number: '01  /  04',
      title: 'أول شيء أريدك تعرفيه...',
      text:
          'أنا عارف أنني أخطأت بحقك.\n\n'
          'وعارف أن بعض تصرفاتي جرحتك أكثر مما كنت أتصور وقتها.\n\n'
          'لم آتِ لأبرر أخطائي، ولا لألقي اللوم على أي شيء.\n\n'
          'أنا فقط أريد أن أقول لك:\n\n'
          'أنا غلطت.',
      buttons: [
        LoveButton(
          text: 'أريد أن أسمع باقي كلامك  ♥',
          onPressed: () {
            goTo(context, const SecondPage());
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

// ======================================================
// الصفحة الثانية
// ======================================================

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StoryPage(
      number: '02  /  04',
      title: 'لو عاد بي الوقت...',
      text:
          'لو عاد بي الوقت، كنت سأفكر قبل أن أتكلم.\n\n'
          'كنت سأحاول أن أفهم شعورك بدل أن أدافع عن نفسي.\n\n'
          'كنت سأنتبه أكثر للأشياء الصغيرة التي كانت تزعجك.\n\n'
          'لأنني الآن فهمت أن بعض الأشياء التي كنت أراها بسيطة، '
          'كانت تعني لك الكثير.',
      buttons: [
        LoveButton(
          text: 'أكمل  ♥',
          onPressed: () {
            goTo(context, const ThirdPage());
          },
        ),
        const SizedBox(height: 14),
        OutlineLoveButton(
          text: 'قل لي ماذا تعلمت',
          onPressed: () {
            goTo(context, const LearningPage());
          },
        ),
      ],
    );
  }
}

// ======================================================
// ماذا تعلمت
// ======================================================

class LearningPage extends StatelessWidget {
  const LearningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StoryPage(
      title: 'ماذا تعلمت؟',
      text:
          'تعلمت أن كلمة "آسف" وحدها لا تكفي.\n\n'
          'وأن الإنسان يمكن أن يحب شخصًا جدًا، '
          'ومع ذلك يؤذيه إذا لم يعرف كيف يتصرف.\n\n'
          'تعلمت أن الحب ليس مجرد كلام جميل.\n\n'
          'الحب أيضًا اهتمام، وفهم، واحترام، وأفعال.',
      buttons: [
        LoveButton(
          text: 'الآن فهمت...  ♥',
          onPressed: () {
            goTo(context, const ThirdPage());
          },
        ),
      ],
    );
  }
}

// ======================================================
// الصفحة الثالثة
// ======================================================

class ThirdPage extends StatelessWidget {
  const ThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StoryPage(
      number: '03  /  04',
      title: 'لن أعدك بالكمال...',
      text:
          'لا أستطيع أن أعدك أنني لن أخطئ أبدًا.\n\n'
          'لكن أستطيع أن أعدك أنني لن أتعامل مع أخطائي وكأنها شيء عادي.\n\n'
          'سأحاول أن أسمعك.\n'
          'سأحاول أن أفهمك.\n'
          'وسأحاول أن أكون الشخص الذي تستحقينه.',
      buttons: [
        LoveButton(
          text: 'أريد أن أعرف ماذا في قلبك  ♥',
          onPressed: () {
            goTo(context, const FinalPage());
          },
        ),
        const SizedBox(height: 14),
        OutlineLoveButton(
          text: 'أعطني وعدًا واحدًا',
          onPressed: () {
            goTo(context, const PromisePage());
          },
        ),
      ],
    );
  }
}

// ======================================================
// صفحة الوعد
// ======================================================

class PromisePage extends StatelessWidget {
  const PromisePage({super.key});

  @override
  Widget build(BuildContext context) {
    return StoryPage(
      title: 'وعد واحد',
      text:
          'لا أريد منك وعدًا بأن تبقي معي للأبد.\n\n'
          'ولا أريد منك أن تنسي ما حدث.\n\n'
          'أريد فقط فرصة واحدة...\n\n'
          'أن أثبت لك بأفعالي أنني تعلمت.',
      buttons: [
        LoveButton(
          text: 'إلى رسالتي الأخيرة  ♥',
          onPressed: () {
            goTo(context, const FinalPage());
          },
        ),
      ],
    );
  }
}

// ======================================================
// الصفحة الرابعة
// ======================================================

class FinalPage extends StatelessWidget {
  const FinalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StoryPage(
      number: '04  /  04',
      title: 'وأخيرًا...',
      text:
          'هنا أريد أن أقول لك كل الأشياء '
          'التي لم أستطع قولها من قبل.\n\n'
          'أريد أن تكون هذه الكلمات مني أنا، '
          'وليس مجرد كلام جميل.\n\n'
          'لأنك تعنين لي أكثر مما استطعت أن أظهره.',
      buttons: [
        LoveButton(
          text: 'أعطيك فرصة  ♥',
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

// ======================================================
// النهاية الإيجابية
// ======================================================

class NewBeginningPage extends StatelessWidget {
  const NewBeginningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StoryPage(
      showBack: false,
      title: 'لنبدأ من جديد ♥',
      text:
          'ليس وكأن شيئًا لم يحدث...\n\n'
          'بل وكأننا تعلمنا منه.\n\n'
          'شكرًا لأنك أعطيتني فرصة جديدة.\n\n'
          'هذه المرة سأحاول أن أجعل أفعالي '
          'تتكلم بدلًا من كلامي.',
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

// ======================================================
// صفحة احترام الوقت
// ======================================================

class TimePage extends StatelessWidget {
  const TimePage({super.key});

  @override
  Widget build(BuildContext context) {
    return StoryPage(
      title: 'خذي وقتك 🌷',
      text:
          'لن أضغط عليك.\n\n'
          'خذي الوقت الذي تحتاجينه.\n\n'
          'هذا التطبيق ليس سباقًا، '
          'ولا يوجد شيء يجبرك على الاستمرار.\n\n'
          'المهم عندي أن يكون قرارك نابعًا منك.',
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

// ======================================================
// صفحة التوقف
// ======================================================

class PausePage extends StatelessWidget {
  const PausePage({super.key});

  @override
  Widget build(BuildContext context) {
    return StoryPage(
      title: 'خذي لحظتك 🌷',
      text:
          'لا داعي للاستعجال.\n\n'
          'عندما تكونين مستعدة، يمكنك العودة وإكمال الرسالة.',
      buttons: [
        LoveButton(
          text: 'أكمل  ♥',
          onPressed: () {
            goTo(context, const SecondPage());
          },
        ),
      ],
    );
  }
}

// ======================================================
// قالب الصفحات
// ======================================================

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
      backgroundColor: backgroundTop,
      body: LoveBackground(
        child: Column(
          children: [
            if (showBack)
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: 14,
                    top: 8,
                  ),
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
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
                  25,
                  10,
                  25,
                  30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (number != null) ...[
                      Text(
                        number!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: primaryPink.withOpacity(0.9),
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 28),
                    ],

                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: whiteSoft,
                        fontSize: 30,
                        height: 1.3,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 24),

                    Center(
                      child: Container(
                        width: 45,
                        height: 2,
                        decoration: BoxDecoration(
                          color: primaryPink,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: cardColor,
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

                    const SizedBox(height: 35),

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

// ======================================================
// الزر الرئيسي
// ======================================================

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
          backgroundColor: primaryPink,
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

// ======================================================
// الزر الثانوي
// ======================================================

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
          foregroundColor: softPink,
          side: BorderSide(
            color: primaryPink.withOpacity(0.45),
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
