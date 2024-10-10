import 'package:flutter/material.dart';
import 'package:rust_plugin/rust_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int data = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      data = sum(10, 10);
                    });
                  },
                  child: const Text("data")),
              Text(
                "$data",
                style: const TextStyle(fontSize: 40),
              )
            ],
          ),
        ),
      ),
    );
  }
}

//add ffi: ^2.1.3 to pubspec
//create plugins folder
//cd plugins
//flutter create rust_plugin --platforms=android,ios,macos,windows,linux --template=plugin_ffi
//cd rust_plugin
// cd src
// cargo new ffi_project --lib
//in ffi_project => Cargo.toml =>

// [lib]
// crate-type = ["cdylib]

//make changes in lib.rs

// #[no_mangle]
// pub extern "C" fn add(left: i32, right: i32) -> i32 {
//     left + right
// }

//then go to rust_plugin => src => CMakeLists.txt

// set_directory_properties(PROPERTIES EP_PREFIX ${CMAKE_CURRENT_SOURCE_DIR}/rust_project_name)

// execute_process(
//   COMMAND cargo build --release
//   WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/rust_project_name
//   OUTPUT_VARIABLE outVar
// )

// if (WIN32)
//   set(SIM_LIB_NAME "rust_project_name.dll")
// endif()

// install(
//   FILES "rust_project_name/target/${SIM_LIB_NAME}"
//   DESTINATION "${CMAKE_INSTALL_PREFIX}/lib"
// )

//then in pubspec.yaml
  // rust_plugin:
  //   path: plugins/rust_plugin


  //for ios/macos

  // cd plugins/rust_plugin/src/ffi_project
  // cargo build --release
//go to target folder in src => release => and you should see libffi_project.dylib
//open xcworksapce in ios
// drag and drop libffi_project.dylib in frameworks
//go to targets => build phases => 
//In Link Binary with Libraries => add libffi_project.dylib (its already added) and make sure it is optional
//In Copy Bundle resource => click + and add libffi_project.dylib
//In Embed Frameworks => click + and add libffi_project.dylib