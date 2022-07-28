import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/core/cubit/app_cubit.dart';
import 'package:todoapp/presentation/board_screen//board_layout/board_screen.dart';
import 'bloc_observer.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  BlocOverrides.runZoned(
    () {
      // Use cubits...
      runApp(TodoApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => AppCubit()..createDataBase())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            titleSpacing: 20,
            backgroundColor: Colors.white,
            elevation: 0.0,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
            ),
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 25.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          tabBarTheme: const TabBarTheme(
              labelColor: Colors.black,
              unselectedLabelColor: Color(0xff575757),
              indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(width: 4.0),
                  insets: EdgeInsets.symmetric(horizontal: 40.0)),
              labelPadding: EdgeInsets.all(2)),
        ),
        home: BoardScreen(),
      ),
    );
  }
}
