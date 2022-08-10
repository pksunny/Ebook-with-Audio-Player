// ignore_for_file: prefer_const_constructors

import 'package:audioplayers/audioplayers.dart';
import 'package:ebook_with_audio_player_app/screens/audio_player_screens/audio_file.dart';
import 'package:ebook_with_audio_player_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class DeatiledAudioScreen extends StatefulWidget {
  const DeatiledAudioScreen({super.key, this.booksData, required this.index});

  final booksData;
  final int index;

  @override
  State<DeatiledAudioScreen> createState() => _DeatiledAudioScreenState();
}

class _DeatiledAudioScreenState extends State<DeatiledAudioScreen> {

  late AudioPlayer advancePlayer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    advancePlayer = AudioPlayer();
  }

  @override
  Widget build(BuildContext context) {

    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.audioGreyBackground,
      body: Stack(
        children: [
          // 1 background of music 
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            height: screenHeight/3,
            child: Container(
              color: AppColors.audioBlueBackground,
            )
          ),

          //2 search and back icon
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,

              leading: IconButton(
                icon: Icon(Icons.arrow_back_rounded),
                onPressed: (){

                  advancePlayer.stop();
                  Navigator.of(context).pop();
                },
              ),
              
              actions: [
                IconButton(
                  onPressed: (){}, 
                  icon: Icon(Icons.search)
                )
              ],
            )
          ),

          // 3 main white round background for music
          Positioned(
            left: 0,
            right: 0,
            top: screenHeight*0.2,
            height: screenHeight*0.36,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),

              // 3.1 music content  
              child: Column(
                children: [
                  SizedBox(height: screenHeight*0.1,),
                  Text(widget.booksData[widget.index]['title'], 
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),

                  Text(widget.booksData[widget.index]['text'], 
                    style: TextStyle(fontSize: 20),
                  ),

                  // 3.2 Audio Player
                  AudioFile(advancePlayer: advancePlayer, audioPath: widget.booksData[widget.index]['audio']),
                ],
              ),
            )
          ),

          // 4 music thumbnail main box
          Positioned(
            top: screenHeight*0.12,
            left: (screenWidth-150)/2,
            right: (screenWidth-150)/2,
            height: screenHeight*0.16,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.audioGreyBackground,
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                )
              ),

              // 4.1 music thumbnail in circle
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Container(
                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(20),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(widget.booksData[widget.index]['img'])
                    )
                  ),
                ),
              ),
            ),
          )

        ],
      ),
    );
  }
}