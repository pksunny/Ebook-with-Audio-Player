// ignore_for_file: prefer_const_constructors

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioFile extends StatefulWidget {
  const AudioFile({super.key, required this.advancePlayer, required this.audioPath});

  final AudioPlayer advancePlayer;

  final String audioPath;

  @override
  State<AudioFile> createState() => _AudioFileState();
}

class _AudioFileState extends State<AudioFile> {

  Duration duration = Duration();
  Duration position = Duration();
  // final String path = 'https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3';
  bool isPlaying = false;
  bool isPaused = false;
  bool isRepeat = false;
  Color color = Colors.black;

  // ignore: prefer_final_fields
  List<IconData> _icons = [
    Icons.play_circle_fill,
    Icons.pause_circle_filled
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    widget.advancePlayer.onDurationChanged.listen((d) {
      setState(() {
        duration = d;
      });
     });

     widget.advancePlayer.onPositionChanged.listen((p) {
      setState(() {
        position = p;
      });
     });

     widget.advancePlayer.setSourceUrl(widget.audioPath);

     widget.advancePlayer.onPlayerComplete.listen((event) { 
      setState(() {
        position = Duration(seconds: 0);
        if(isRepeat == true) {

          isPlaying = true;
        } else {

          isPlaying = false;
          isRepeat = false;
        }
      });
     });
  }

  Widget btnStart() {

    return IconButton(
      padding: EdgeInsets.only(bottom: 10),
      icon: isPlaying == false ? Icon(_icons[0], size: 50, color: Colors.blue,) : Icon(_icons[1], size: 50,color: Colors.blue,),
      onPressed: (){
        
        if(isPlaying == false) {

          widget.advancePlayer.play(UrlSource(widget.audioPath));
          setState(() {
            isPlaying = true;
          });
        } else if(isPlaying == true) {

          widget.advancePlayer.pause();
          setState(() {
            isPlaying = false;
          });
        }
      }, 
    );
  }

  Widget btnFast() {
    return IconButton(
      icon: Icon(Icons.arrow_forward_ios, size: 20, color: Colors.black,),
      onPressed: (){
        widget.advancePlayer.setPlaybackRate(1.5);
      },
    );
  }

  Widget btnSlow() {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black,),
      onPressed: (){
        widget.advancePlayer.setPlaybackRate(0.5);
      },
    );
  }

  Widget btnLoop() {
    return IconButton(
      icon: Icon(Icons.loop_rounded, size: 20, color: Colors.black,),
      onPressed: (){
        
      },
    );
  }

  Widget btnRepeat() {
    return IconButton(
      icon: Icon(Icons.repeat, size: 20, color: color,),
      onPressed: (){
        
        if(isRepeat == false) {
          widget.advancePlayer.setReleaseMode(ReleaseMode.loop);
          setState(() {
            isRepeat = true;
            color = Colors.blue;
          });
        }else if(isRepeat == true) {
          widget.advancePlayer.setReleaseMode(ReleaseMode.release);
          color = Colors.black;
          isRepeat = false;
        }
      },
    );
  }

  Widget loadAsset() {

    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          btnRepeat(),
          btnSlow(),
          btnStart(),
          btnFast(),
          btnLoop(),
        ],
      ),
    );
  }

  Widget slider() {
    return Slider(
      activeColor: Colors.red,
      inactiveColor: Colors.grey,
      value: position.inSeconds.toDouble(),
      min: 0.0,
      max: duration.inSeconds.toDouble() == '' ? 60.0 : duration.inSeconds.toDouble(),
      onChanged: (double value){

        setState(() {
          changeToSecond(value.toInt());
          value = value;
        });
      },
    );
  }

  void changeToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    widget.advancePlayer.seek(newDuration);
  }

 
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Text(position.toString().split('.')[0], style: TextStyle(fontSize: 16),),

                Text(duration.toString().split('.')[0], style: TextStyle(fontSize: 16),),
              ],
            ),
          ),

          loadAsset(),
          slider(),
        ],
      ),
    );
  }
}