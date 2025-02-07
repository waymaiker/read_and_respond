<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

This package is useful when you are trying to build a test or quiz and check the user's understanding of a text.
I'm currently developping a learning app and it's one of the package I already developped (There are 9 of them)


## Features
Select an answer  
Either you find the right one,  if you don't, you are given the answer and the translation of it

<img src="https://github.com/waymaiker/edtech_flutter_packages/blob/master/readandrespond/package%20description%20-%20%20view.png" alt="exercice view" width="200"/> <img src="https://github.com/waymaiker/edtech_flutter_packages/blob/master/readandrespond/package%20description%20-%20selected%20answer%20view.png" alt="seleted options view" width="200"/> <img src="https://github.com/waymaiker/edtech_flutter_packages/blob/master/readandrespond/package%20description%20-%20good%20answer%20view.png" alt="When the user has the right answer" width="200"/> <img src="https://github.com/waymaiker/edtech_flutter_packages/blob/master/readandrespond/package%20description%20-%20wrong%20answer%20view.png" alt="When the user has the right answer" width="200"/>


## Usage

```dart
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:readandrespond/readandrespond.dart';


class MyQuizComponent extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final questions = [
      {
       "id": 0,
       "question": "Wanneer gaat juan zijn laptop kopen?",
       "options": ["Dinsdag, na het werk", "Woensdag, tijdens zijn lunchpauze", "Op vrijdag, als hij zijn salaris heeft ontvangen"],
       "answer": "Op vrijdag, als hij zijn salaris heeft ontvangen",
       "answerTranslation": "Vendredi, s'il a reçu son salaire",
       "text": "Deze week had Juan een ongeluk met zijn fiets. Het was niets ernstigs, maar toen hij viel, brak zijn laptop. Hij ziet er tegenop om dinsdag na zijn werk een nieuwe te kopen. Na overleg met Javonte besluit hij hem vrijdag te kopen, als hij zijn loon krijgt.",
       "type": "readandrespond",
       "title": "Read and respond",
       "result": -1
      },
    ]

    final questionIndex = useState(0);

    bool isNotLastQuestion(){
      return questionIndex.value < questions.length - 1;
    }

    void nextQuestion(){
      isNotLastQuestion()
        ? questionIndex.value++
        : GoRouter.of(context).go('/results');
    }

    useEffect(() {}, [questions]);

    return OverrideBackButtonWrapperWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: ReadAndRespond(
          id: questions[questionIndex.value]["id"],
          title: questions[questionIndex.value]["title"],
          titleButton: 'VALIDATE',
          text: questions[questionIndex.value]["text"],
          titleButtonSheet: isNotLastQuestion() ? 'NEXT' : 'SEE RESULT',
          questionText: questions[questionIndex.value]["question"],
          options: questions[questionIndex.value]["options"],
          answer: questions[questionIndex.value]["answer"],
          setQuestionResult: () => {}, // get the result of the question
          action: () => nextQuestion(), // What you want to happen when you click on the bottom sheet button
        )
      ),
    );
  }
}

```

## Additional information

- [ ] Unit tests
- [ ] Integration tests
