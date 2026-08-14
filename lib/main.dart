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
        fontFamily: 'Arial',
      ),
      home: const HomePage(),
    );
  }
}

// ===============================
// الانتقال بين الصفحات
// ===============================

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

// ===============================
// زر موحد
// ===============================

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
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// ===============================
// الشاشة الرئيسية
// ===============================

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFE4EC),
              Color(0xFFFFF7F9),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'إليكِ ❤️',
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 30),

                const Text(
                  'صنعتُ هذا الشيء بنفسي،\n'
                  'ليس لأغيّر قرارك،\n'
                  'ولا لأجبرك على مسامحتي...\n\n'
                  'فقط لأن هناك أشياء كثيرة\n'
                  'كنت أريد أن أقولها لك.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    height: 1.7,
                  ),
                ),

                const SizedBox(height: 45),

                LoveButton(
                  text: 'ابدئي ❤️',
                  onPressed: () {
                    goTo(context, const ConfessionPage());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ===============================
// الصفحة الأولى
// ===============================

class ConfessionPage extends StatelessWidget {
  const ConfessionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StoryPage(
      number: '1 / 4',
      title: 'أول شيء أريدك تعرفيه...',
      text:
          'أنا عارف أنني أخطأت بحقك.\n\n'
          'وعارف أن بعض تصرفاتي جرحتك أكثر مما كنت أتصور.\n\n'
          'لم آتِ لأبرر أخطائي، ولا لألقي اللوم على أي شيء.\n\n'
          'أنا فقط أريد أن أقول لك:\n\n'
          'أنا غلطت.',
      buttons: [
        LoveButton(
          text: 'أريد أن أسمع باقي كلامك ❤️',
          onPressed: () {
            goTo(context, const TimePage());
          },
        ),
        const SizedBox(height: 12),
        LoveButton(
          text: 'أحتاج لحظة 🌷',
          onPressed: () {
            goTo(context, const PausePage());
          },
        ),
      ],
    );
  }
}

// ===============================
// الصفحة الثانية
// ===============================

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StoryPage(
      number: '2 / 4',
      title: 'لو عاد بي الوقت...',
      text:
          'لو عاد بي الوقت، كنت سأفكر قبل أن أتكلم.\n\n'
          'كنت سأحاول أن أفهم شعورك بدل أن أدافع عن نفسي.\n\n'
          'وكنت سأنتبه أكثر للأشياء الصغيرة التي كانت تزعجك.',
      buttons: [
        LoveButton(
          text: 'أكمل ❤️',
          onPressed: () {
            goTo(context, const ThirdPage());
          },
        ),
        const SizedBox(height: 12),
        LoveButton(
          text: 'قل لي ماذا تعلمت',
          onPressed: () {
            goTo(context, const LearningPage());
          },
        ),
      ],
    );
  }
}

// ===============================
// صفحة ماذا تعلمت
// ===============================

class LearningPage extends StatelessWidget {
  const LearningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StoryPage(
      title: 'ماذا تعلمت؟',
      text:
          'تعلمت أن كلمة آسف وحدها لا تكفي.\n\n'
          'وأن الإنسان يمكن أن يحب شخصًا جدًا، '
          'ومع ذلك يؤذيه إذا لم يعرف كيف يتصرف.\n\n'
          'لذلك لا أريد أن أطلب منك تصديقي بسبب كلام جميل.\n\n'
          'أريد أن يكون التغيير في أفعالي.',
      buttons: [
        LoveButton(
          text: 'الآن فهمت...',
          onPressed: () {
            goTo(context, const ThirdPage());
          },
        ),
      ],
    );
  }
}

// ===============================
// الصفحة الثالثة
// ===============================

class ThirdPage extends StatelessWidget {
  const ThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StoryPage(
      number: '3 / 4',
      title: 'لن أعدك بالكمال...',
      text:
          'لا أستطيع أن أعدك أنني لن أخطئ أبدًا.\n\n'
          'لكن أستطيع أن أعدك أنني لن أتعامل مع أخطائي وكأنها شيء عادي.\n\n'
          'سأحاول أن أسمعك.\n'
          'سأحاول أن أفهمك.\n'
          'وسأحاول أن أكون الشخص الذي تستحقينه.',
      buttons: [
        LoveButton(
          text: 'أريد أن أعرف ماذا في قلبك ❤️',
          onPressed: () {
            goTo(context, const FinalPage());
          },
        ),
        const SizedBox(height: 12),
        LoveButton(
          text: 'أعطني وعدًا واحدًا',
          onPressed: () {
            goTo(context, const PromisePage());
          },
        ),
      ],
    );
  }
}

// ===============================
// صفحة الوعد
// ===============================

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
          text: 'الآن إلى رسالتي الأخيرة ❤️',
          onPressed: () {
            goTo(context, const FinalPage());
          },
        ),
      ],
    );
  }
}

// ===============================
// الصفحة الرابعة
// ===============================

class FinalPage extends StatelessWidget {
  const FinalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StoryPage(
      number: '4 / 4',
      title: 'وأخيرًا...',
      text:
          'هنا أريد أن أقول لك كل الأشياء '
          'التي لم أستطع قولها من قبل.\n\n'
          'أريد أن تكون هذه الكلمات مني أنا، '
          'وليس مجرد كلام جميل.\n\n'
          'لأنك تعنين لي أكثر مما استطعت أن أظهره.',
      buttons: [
        LoveButton(
          text: 'أعطيك فرصة ❤️',
          onPressed: () {
            goTo(context, const NewBeginningPage());
          },
        ),
        const SizedBox(height: 12),
        LoveButton(
          text: 'أحتاج وقتًا 🌷',
          onPressed: () {
            goTo(context, const TimePage());
          },
        ),
      ],
    );
  }
}

// ===============================
// النهاية الإيجابية
// ===============================

class NewBeginningPage extends StatelessWidget {
  const NewBeginningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StoryPage(
      title: 'لنبدأ من جديد ❤️',
      text:
          'ليس وكأن شيئًا لم يحدث...\n\n'
          'بل وكأننا تعلمنا منه.\n\n'
          'وشكرًا لأنك أعطيتني فرصة جديدة.',
      buttons: [
        LoveButton(
          text: 'ابدأ من جديد ❤️',
          onPressed: () {
            Navigator.popUntil(context, (route) => route.isFirst);
          },
        ),
      ],
    );
  }
}

// ===============================
// صفحة احترام الوقت
// ===============================

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
        LoveButton(
          text: 'العودة',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

// ===============================
// صفحة التوقف
// ===============================

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
          text: 'أكمل',
          onPressed: () {
            goTo(context, const SecondPage());
          },
        ),
      ],
    );
  }
}

// ===============================
// قالب الصفحات
// ===============================

class StoryPage extends StatelessWidget {
  final String? number;
  final String title;
  final String text;
  final List<Widget> buttons;

  const StoryPage({
    super.key,
    this.number,
    required this.title,
    required this.text,
    required this.buttons,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFE4EC),
              Color(0xFFFFF7F9),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (number != null)
                  Text(
                    number!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                const SizedBox(height: 35),

                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 35),

                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    height: 1.8,
                  ),
                ),

                const SizedBox(height: 50),

                ...buttons,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
