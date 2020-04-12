import 'setting.dart';
import 'main_data.dart';
class Count1Bloc extends BloCSetting {
  int counter1 = 0;
incrementCounter(state) {
    rebuildWidgets(
      setStates: () {
        counter1++;
      },
      states: [state],
    );
    mainBloc.counter1 = counter1;
  }
}
Count1Bloc count1Bloc;