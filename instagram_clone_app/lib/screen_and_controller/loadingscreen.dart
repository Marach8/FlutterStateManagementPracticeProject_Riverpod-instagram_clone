import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:instagram_clone_app/screen_and_controller/loading_screen_controller.dart';

class LoadingScreen{
  LoadingScreen._sharedInstance();
  static final LoadingScreen _shared = LoadingScreen._sharedInstance();
  factory LoadingScreen() => _shared;

  LoadingScreenController? controller;
  
  void showOverlay(BuildContext context, String text){
    if(controller?.update(text) ?? false){return;}
    else{controller = _showOverlay(context, text);}
  }

  void hideOverlay() {
    controller?.close();
    controller = null;
  }

  LoadingScreenController? _showOverlay(BuildContext context, String text){
    final state = Overlay.of(context);
    if(!state.mounted){return null;}

    final textStream = StreamController<String>();
    textStream.add(text);

    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final overlay = OverlayEntry(
      builder: (_) => Material(
        color: Colors.black.withAlpha(150),
        child: Center(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: size.width * 0.8,
              maxHeight: size.height * 0.8,
              minWidth: size.width * 0.5
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Gap(10),
                    const CircularProgressIndicator(),
                    const Gap(10),
                    StreamBuilder(
                      stream: textStream.stream,
                      builder: (_, snapshot){
                        if(snapshot.hasData){
                          return Text(
                            snapshot.data!,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black)
                          );
                        }
                        else{return const SizedBox.shrink();}
                      }
                    )
                  ],
                ),
              ),
            )
          )
        ),
      )
    );
    state.insert(overlay);
    return LoadingScreenController(
      close: () {
        textStream.close();
        overlay.remove();
        return true;
      },
      update: (textItem) {
        textStream.add(text);
        return true;
      }
    );
  }
}