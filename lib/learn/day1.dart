import 'package:flutter/material.dart';

class ArchitectureReferencePage extends StatelessWidget {
  const ArchitectureReferencePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("مرجع معمارية فلاتر - تينا")),
      body: SingleChildScrollView(
        child: Column(
          children: [
         //هنا بستعمل const علشان اقول ل فلاتر ان الويدجت دى مش هتتغير ف هو مش بيقراها غير مرة واحده وخلاص وحتى لو حصل اى تغيير ف الصفحة بيروح يغير ف الباقى ويعدى على دى كأنه مشافهاش
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Tina",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),

            const Divider(),

        // فلاتر بيعيد الويدجت اللى فيها تغيير ف لو الصفحة كلها حتة واحده فلاتر هتعيد رسم الشاشة كلها حتى لو اتغير حرف واحد
            // عشان كدا انا عارفه ان فى جزء الكونتر ويدجت هيتغير لكن النص مش هيتغير ف رحت فصلت الجزء اللى هيتغير ف ويدجت لوحدها تتغير هناك وهو يسمع التغيير على طول وبكدا مش هيروح يعيد رسم النص من تانى
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Tina"),
            ),
            const CounterWidget(), // دى الويدجت اللى هتتغير حطيتها تحت لوحده تتغير وخلاص كدا

            const Divider(),

  // فلاتر بيخلى الاب بيدى حجم للابن ويقوله يتعامل براحته ف الماسحه دى والابن يختار مساحة حسب م الاب مديله حرية قد اي ف لو الابن طلب مقاس اكبر م اللى مديهوله الاب الشاشة بتضرب
            const Text(" (Constraints):"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber),
                  // عشان كدا هنا حطيت expanded يعنى بنقول للابن خد المساحة اللى الاب محددهالك بس
                  Expanded(
                    child: Container(
                      color: Colors.blue[50],
                      child: const Text(
                        "نص طويل جداً محمي بـ Expanded عشان الأب (Row) ميزعلش والشاشة متضربش أصفر في أسود.",
                        softWrap: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Divider(),

    //الbuild لازم تكون سريعه ف لو حطينا فيها عمليات حسابيه تقيله الابليكيشن هيهنج
            // رحت هنا فصلتله العمليه الحسابيه اللى بتحصل وخليتها تحصل برا الbuild ويدوب يرجع هنا يعرض النتيجة اللى وصلها
            const LogicDisplayWidget(),

            const Divider(),


            const Text("6. استخدام الـ Keys في اللستة:"),
            const KeysExampleWidget(),
          ],
        ),
      ),
    );
  }
}

class CounterWidget extends StatefulWidget {
  const CounterWidget({super.key});

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _count = 0;
  @override
  Widget build(BuildContext context) {
    // الـ setState هنا بتبني الـ CounterWidget بس، مش الصفحة كلها
    return ElevatedButton(
      onPressed: () => setState(() => _count++),
      child: Text(" ويدجت مستقل: $_count"),
    );
  }
}

class LogicDisplayWidget extends StatefulWidget {
  const LogicDisplayWidget({super.key});

  @override
  State<LogicDisplayWidget> createState() => _LogicDisplayWidgetState();
}

class _LogicDisplayWidgetState extends State<LogicDisplayWidget> {
  late String _result;

  @override
  void initState() {
    super.initState();
    // بنحسب الداتا التقيلة هنا "مرة واحدة" أول ما الودجت يتولد
    _result = "النتيجة: ${100 * 50 / 2}";
  }

  @override
  Widget build(BuildContext context) {
    return Text(".  بعد ما حسبت كل حاجه برا : $_result");
  }
}

class KeysExampleWidget extends StatelessWidget {
  const KeysExampleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> users = ["تينا", "أحمد", "سارة"];
    return Column(
      children: users.map((name) => ListTile(
        key: ValueKey(name), // كل سطر له "بطاقة شخصية" عشان فلاتر ميتلخبطش
        leading: const CircleAvatar(child: Icon(Icons.person)),
        title: Text(name),
      )).toList(),
    );
  }
}

//________________________________ الاستفادة ________________________________
/*
أمر: "قَسِّم تَسُد" (Modularization): -1
الاستفادة: حولي أي قطعة UI بتتكرر (زرار، كارت، input) لـ Widget لوحدها في ملف منفصل. ده بيخلي "المدير" (Element Tree) يغير الحتة البايظة بس، مش الصفحة كلها.

أمر: "خففي حِمل المهندسة" (Use Const Constructors):-2
الاستفادة: أي Widget مش هيتغير لونه أو مكانه (زي الأيقونات أو النصوص الثابتة)، حطي قبله كلمة const. كده بتطمني "المهندسة فريم" إن الودجت ده مش هيتلمس تاني مهما حصل، فمش هتعيد بناءه أبداً.

أمر: "احترمي سلطة الأب" (Understand Constraints):-3
الاستفادة: لو ودجت ضرب منك، متجربيش أرقام عشوائية. اسألي نفسك: "الأب مديني مساحة قد إيه؟". استخدمي LayoutBuilder عشان تشوفي المساحة المتاحة وتصممي على أساسها.

أمر: "افصلي الدماغ عن العضلات" (Logic vs UI):-4
الاستفادة: كود الحسابات (Logic) يكون في ملف، وكود الشكل (UI) في ملف تاني. ده بيخلي "الصنايعي إنجي" ملوش دعوة بالحسابات، هو يركز في الرسم بس أول ما الداتا تجهز.

أمر: "الـ SetState للضرورة القصوى" (Local State):-5
الاستفادة: استخدمي setState في أصغر نطاق ممكن (Smallest Scope). لو الزرار بس اللي بيتغير، خلي الـ setState جوه الـ Widget بتاع الزرار، مش في نص الصفحة فوق.

أمر: "استخدمي الـ Keys بحذر" (Key Usage):-6
الاستفادة: لما يكون عندك لستة حاجات بتتحرك أو بتتمسح، استخدمي ValueKey. ده بيدي "بطاقة رقم قومي" لكل ودجت، فـ "المدير" ميتلخبطش ويحط داتا مكان داتا تانية.*/