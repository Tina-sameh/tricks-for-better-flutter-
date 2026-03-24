import 'package:flutter/material.dart';

class BrokenArchitecturePage extends StatefulWidget {
  const BrokenArchitecturePage({super.key});

  @override
  State<BrokenArchitecturePage> createState() => _BrokenArchitecturePageState();
}

class _BrokenArchitecturePageState extends State<BrokenArchitecturePage> {

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(title: Text("صفحة تينا - تحدي التصليح")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              //add const
              child: const Text(
                "هذا نص ثابت تماماً لا يتغير أبداً",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Image.network(
              "https://flutter.github.io/assets-for-api-docs/assets/widgets/puffin.jpg",
              height: 100,
            ),

            const Divider(),

            Row(
              children: [
                Icon(Icons.edit),
                //add expanded
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(hintText: "اكتب هنا..."),
                  ),
                ),
              ],
            ),

            const Divider(),

            ListTile(
              //separate logic from ui
              title: HeavyLogic(),
              trailing: CustomButton(),
            ),

            const Divider(),

            Text("قائمة المستخدمين:"),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                return ListTile(
                  key: ValueKey(index),
                  leading: CircleAvatar(child: Text("$index")),
                  title: Text("مستخدم رقم $index"),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
class HeavyLogic extends StatefulWidget {
  const HeavyLogic({super.key});

  @override
  State<HeavyLogic> createState() => _HeavyLogicState();
}

class _HeavyLogicState extends State<HeavyLogic> {
  late String heavyResult;
  @override
  void initState() {
    int _counter = 0;
     heavyResult = "${_counter * 100 / 2} - ${DateTime.now()}";
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Text("Result = $heavyResult");
  }
}

//-----------------------------------
//فصلت كود الزرار عشان اما يتغير يتغير لوحده
class CustomButton extends StatefulWidget {
  const CustomButton({super.key});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isLiked = false;

  @override
  Widget build(BuildContext context) {

    return IconButton(
      icon: Icon(
        _isLiked ? Icons.favorite : Icons.favorite_border,
        color: Colors.red,
      ),
      onPressed: () {
        setState(() {
          _isLiked = !_isLiked;
        });
      },
    );
  }
}
//------------------------------- التعديلات اللى عملتها -----------------------------

/*
الـ const: وفّرتِ مجهود الرسم للأجزاء الثابتة.

الـ Expanded: منعتِ كارثة الـ Overflow واحترمتِ حدود الأب.

فصل الـ HeavyLogic: خليت الحسابات تحصل مرة واحدة في الـ initState وبقت معزولة عن أي Rebuild تالت.

فصل الـ CustomButton: دي "المعلمة" الحقيقية، لأنى خليت الـ setState محلية (Local)، فالصفحة الكبيرة مابتحسش بأي حركة لما القلب يتغير.

الـ ValueKey: اديت لكل عنصر في اللستة شخصيته المستقلة.*/