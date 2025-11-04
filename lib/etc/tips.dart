import 'dart:math';

class Tips {
  static final List<String> allTips = [
    "A healthy diet is an important part of a healthy lifestyle at any time but is especially vital if you're pregnant or planning a pregnancy. Eating healthily during pregnancy will help your baby to develop and grow.",
    "Dairy foods such as milk, cheese, fromage frais and yoghurt are important in pregnancy because they contain calcium and other nutrients that you and your baby need.",
    "Pregnant woman's body is different from a woman's body in general. As soon as Mommy knows that she is pregnant, she should start to stay fit and healthy in order to experience a normal pregnancy. A normal pregnancy can be obtained by maintaining the physical and emotional state. Thus, Mommy’s opportunity to enjoy a trouble-free pregnancy will even be greater. ",
    "Pregnant conditions sometimes make mommy feel sluggish and less energetic. Some pregnant women even reduce the activity so that the fetus can develop optimally. However, Mommy still needs some exercises. Useful exercises will increase the stamina. In addition, exercise is also useful to train the flexibility of muscles that will support labor process.",
    "Gaining an appropriate amount of weight during pregnancy helps your baby grow to a healthy size. But gaining too much or too little weight may lead to serious health problems for you and your baby.",
    "Effective stress management techniques can include practices such as deep breathing, yoga, meditation, progressive muscle relaxation, and journaling"

  ];

  static List<String> getRandomTips({int count = 3}) {
    List<String> tips = [];
    final Random random = Random();

    for (int i = 0; i < count; i++) {
      int idx = random.nextInt(count);
      if (tips.contains(allTips[idx])) {
        i--;
        continue;
      }
      tips.add(allTips[idx]);
    }

    return tips;
  }
}
