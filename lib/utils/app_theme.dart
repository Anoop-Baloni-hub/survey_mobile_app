// import 'package:flutter/material.dart';
//
// import 'app_text_style.dart';
//
// class AppTheme {
//   AppTheme._();
//
//   static ThemeData lightTheme = ThemeData(
//     primarySwatch: Colors.blue,
//     visualDensity: VisualDensity.adaptivePlatformDensity,
//     useMaterial3: true,
//     textTheme: TextTheme(
//       headline1: AppTextStyle.bold32(AppColors.darkCoffeeColor),
//       headline2: AppTextStyle.bold28(AppColors.darkCoffeeColor),
//       headline3: AppTextStyle.bold24(AppColors.darkCoffeeColor),
//       headline4: AppTextStyle.bold20(AppColors.darkCoffeeColor),
//       headline5: AppTextStyle.bold16(AppColors.darkCoffeeColor),
//       headline6: AppTextStyle.bold14(AppColors.darkCoffeeColor),
//       subtitle1: AppTextStyle.semiBold16(AppColors.darkCoffeeColor),
//       subtitle2: AppTextStyle.semiBold14(AppColors.darkCoffeeColor),
//       bodyText1: AppTextStyle.regular16(AppColors.darkCoffeeColor),
//       bodyText2: AppTextStyle.regular14(AppColors.darkCoffeeColor),
//       button: AppTextStyle.semiBold16(AppColors.darkCoffeeColor),
//       caption: AppTextStyle.regular12(AppColors.darkCoffeeColor),
//       overline: AppTextStyle.regular10(AppColors.darkCoffeeColor),
//
//       // displayLarge: AppTextStyle.bold32(AppColors.darkCoffeeColor),
//       // displayMedium: AppTextStyle.bold28(AppColors.darkCoffeeColor),
//       // displaySmall: AppTextStyle.bold24(AppColors.darkCoffeeColor),
//       // headlineMedium: AppTextStyle.bold20(AppColors.darkCoffeeColor),
//       // headlineSmall: AppTextStyle.bold16(AppColors.darkCoffeeColor),
//       // titleLarge: AppTextStyle.bold14(AppColors.darkCoffeeColor),
//       // titleMedium: AppTextStyle.semiBold16(AppColors.darkCoffeeColor),
//       // titleSmall: AppTextStyle.semiBold14(AppColors.darkCoffeeColor),
//       // bodyLarge: AppTextStyle.regular16(AppColors.darkCoffeeColor),
//       // bodyMedium: AppTextStyle.regular14(AppColors.darkCoffeeColor),
//       // labelLarge: AppTextStyle.semiBold16(AppColors.darkCoffeeColor),
//       // bodySmall: AppTextStyle.regular12(AppColors.darkCoffeeColor),
//       // labelSmall: AppTextStyle.regular10(AppColors.darkCoffeeColor),
//     ),
//     appBarTheme: AppBarTheme(
//       backgroundColor: const Color(0xFFFFFFFF),
//       scrolledUnderElevation: 0,
//       elevation: 0,
//       iconTheme: const IconThemeData(color: Color(0xFF000000)),
//       titleTextStyle: AppTextStyle.semiBold22(AppColors.darkCoffeeColor),
//     ),
//     scaffoldBackgroundColor: const Color(0xFFFFFFFF),
//     primaryColor: AppColors.darkCoffeeColor,
//     primaryColorLight: const Color(0xFFE5E5E5),
//     primaryColorDark: const Color(0xFFE5E5E5),
//     brightness: Brightness.light,
//     // cardColor: Color(0xFFE5E5E5),
//     textSelectionTheme: const TextSelectionThemeData(
//       cursorColor: AppColors.darkCoffeeColor,
//       selectionColor: Color(0xFFFFFFFF),
//       selectionHandleColor: AppColors.darkCoffeeColor,
//     ),
//     textButtonTheme: TextButtonThemeData(
//       style: ButtonStyle(
//         foregroundColor: MaterialStateProperty.all(Colors.black),
//       ),
//     ),
//     elevatedButtonTheme: ElevatedButtonThemeData(
//       style: ButtonStyle(
//         backgroundColor: MaterialStateProperty.all(AppColors.darkCoffeeColor),
//         foregroundColor: MaterialStateProperty.all(Colors.white),
//       ),
//     ),
//     outlinedButtonTheme: OutlinedButtonThemeData(
//       style: ButtonStyle(
//         foregroundColor: MaterialStateProperty.all(const Color(0xFFE5E5E5)),
//       ),
//     ),
//     bottomSheetTheme: const BottomSheetThemeData(
//       surfaceTintColor: Color(0xFFFFFFFF),
//       backgroundColor: Color(0xFFFFFFFF),
//       shape: OutlineInputBorder(
//         borderSide: BorderSide(color: Colors.white),
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(20),
//           topRight: Radius.circular(20),
//         ),
//       ),
//       dragHandleSize: Size(50, 5),
//     ),
//     bottomNavigationBarTheme: BottomNavigationBarThemeData(
//       backgroundColor: const Color(0xFF3B3034),
//       selectedItemColor: AppColors.bottomBarTextColor,//const Color(0xfff6f0ee),
//       unselectedItemColor: const Color(0xFFb6a096).withOpacity(.5),
//       selectedLabelStyle: AppTextStyle.regular12(AppColors.lightCoffeeColor),
//       unselectedLabelStyle:
//       AppTextStyle.regular12(AppColors.lightCoffeeColor.withOpacity(.5)),
//       showUnselectedLabels: true,
//     ),
//     buttonBarTheme: const ButtonBarThemeData(
//       alignment: MainAxisAlignment.start,
//     ),
//     chipTheme: const ChipThemeData(
//       backgroundColor: Color(0xFFE5E5E5),
//       disabledColor: Color(0xFFE5E5E5),
//       selectedColor: Color(0xFFE5E5E5),
//       secondarySelectedColor: Color(0xFFE5E5E5),
//       padding: EdgeInsets.all(0),
//       shape: StadiumBorder(),
//       labelStyle: TextStyle(color: Color(0xFFE5E5E5)),
//       secondaryLabelStyle: TextStyle(color: Color(0xFFE5E5E5)),
//       brightness: Brightness.light,
//     ),
//     dialogTheme: const DialogTheme(
//       backgroundColor: Color(0xFFFFFFFF),
//       titleTextStyle: TextStyle(color: Color(0xFFE5E5E5)),
//       contentTextStyle: TextStyle(color: Color(0xFFE5E5E5)),
//     ),
//     inputDecorationTheme: InputDecorationTheme(
//       labelStyle: const TextStyle(color: Color(0xFFE5E5E5)),
//       helperStyle: const TextStyle(color: Color(0xFFE5E5E5)),
//       hintStyle: const TextStyle(color: Color(0x803B3034)),
//       errorStyle: const TextStyle(color: AppColors.errorRedColor),
//       prefixStyle: const TextStyle(color: Color(0xFFE5E5E5)),
//       suffixStyle: const TextStyle(color: Color(0xFFE5E5E5)),
//       counterStyle: const TextStyle(color: Color(0xFFE5E5E5)),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(5),
//         borderSide: const BorderSide(color: Color(0xFFB6A096)),
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(5),
//         borderSide: const BorderSide(color: Color(0xFFB6A096)),
//       ),
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(5),
//         borderSide: const BorderSide(color: Color(0xFFB6A096)),
//       ),
//       errorBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(5),
//         borderSide: const BorderSide(color: AppColors.errorRedColor),
//       ),
//       focusedErrorBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(5),
//         borderSide: const BorderSide(color: Color(0xFFB6A096)),
//       ),
//       disabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(5),
//         borderSide: const BorderSide(color: Color(0xFFB6A096)),
//       ),
//     ),
//     colorScheme: const ColorScheme(
//       primary: AppColors.darkCoffeeColor,
//       secondary: Color(0xFF3B3034),
//       surface: Color(0xFFE5E5E5),
//       background: Color(0xFFE5E5E5),
//       error: AppColors.errorRedColor,
//       onPrimary: Color(0xFFE5E5E5),
//       onSecondary: Color(0xFFE5E5E5),
//       onSurface: AppColors.darkCoffeeColor,
//       onBackground: Color(0xFF3B3034),
//       onError: AppColors.errorRedColor,
//       brightness: Brightness.light,
//     ),
//     datePickerTheme: DatePickerThemeData(
//       surfaceTintColor: Colors.white,
//       backgroundColor: Colors.white,
//       headerBackgroundColor: AppColors.darkCoffeeColor,
//       headerForegroundColor: Colors.white,
//       dayOverlayColor:
//       MaterialStateProperty.all(AppColors.overlayColor),
//       todayBorder: const BorderSide(color: AppColors.darkCoffeeColor),
//     ),
//     checkboxTheme: CheckboxThemeData(
//       visualDensity: VisualDensity.compact,
//       overlayColor: MaterialStateProperty.all(AppColors.overlayColor),
//       materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//       checkColor: MaterialStateProperty.all(AppColors.lightCoffeeColor),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(3),
//         side: MaterialStateBorderSide.resolveWith((states) {
//           if(states.contains(MaterialState.selected)){
//             return BorderSide(color: Colors.red);
//           } else {
//             return BorderSide(color: Colors.green);
//           }
//         }),
//       ),
//       fillColor: MaterialStateProperty.all(Colors.transparent),
//     ),
//     radioTheme: RadioThemeData(visualDensity: VisualDensity.compact,
//       overlayColor: MaterialStateProperty.all(AppColors.overlayColor),
//       materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//       fillColor: MaterialStateProperty.resolveWith<Color?>(
//               (Set<MaterialState> states) {
//             if (states.contains(MaterialState.disabled)) {
//               return null;
//             }
//             if (states.contains(MaterialState.selected)) {
//               return AppColors.darkCoffeeColor;
//             }
//             return null;
//           }),
//     ),
//     switchTheme: SwitchThemeData(
//       overlayColor: MaterialStateProperty.all(AppColors.overlayColor),
//       materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//       thumbColor: MaterialStateProperty.resolveWith<Color?>(
//               (Set<MaterialState> states) {
//             if (states.contains(MaterialState.disabled)) {
//               return null;
//             }
//             if (states.contains(MaterialState.selected)) {
//               return AppColors.darkCoffeeColor;
//             }
//             return null;
//           }),
//       trackColor: MaterialStateProperty.resolveWith<Color?>(
//               (Set<MaterialState> states) {
//             if (states.contains(MaterialState.disabled)) {
//               return null;
//             }
//             if (states.contains(MaterialState.selected)) {
//               return const Color(0xFFE5E5E5);
//             }
//             return null;
//           }),
//     ),
//   );}
