import 'package:flutter/material.dart';

bool toggle = true;
class FloatMenuButton extends StatefulWidget {

  final VoidCallback onCheckAll;
  final VoidCallback showDatePicker;
  final VoidCallback previousDay;
  final VoidCallback nextDay;

  const FloatMenuButton({super.key,required this.onCheckAll,required this.showDatePicker, required this.previousDay, required this.nextDay});

  @override
  State<FloatMenuButton> createState() => _FloatMenuButtonState();
}



class _FloatMenuButtonState extends State<FloatMenuButton>  with SingleTickerProviderStateMixin{

  late AnimationController _controller;


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(microseconds: 350),
        reverseDuration: const Duration(milliseconds: 275)
    );

    _controller.addListener((){
      setState(() {

      });
    });

  }

  Alignment alignment =  const Alignment(0.0, 0.0);
  Alignment alignment1 = const Alignment(0.0, 0.0);
  Alignment alignment2 = const Alignment(0.0, 0.0);
  Alignment alignment3 = const Alignment(0.0, 0.0);
  double size = 54.0;
  double size1 = 54.0;
  double size2 = 54.0;
  double size3 = 54.0;

  void pressed(){
    setState(() {
      if(toggle){
        toggle = !toggle;
        _controller.forward();
        Future.delayed(const Duration(milliseconds: 10),(){
          alignment =  const Alignment(-0.65, 0.350);
          alignment1 = const Alignment(0.000, 0.750);
          alignment2 = const Alignment(-0.65, -0.35);
          alignment3 = const Alignment(0.000, -0.75);
        });
      }else{
        toggle = !toggle;
        _controller.reverse();
        alignment = const Alignment(0.0, 0.0);
        alignment1 = const Alignment(0.0, 0.0);
        alignment2 = const Alignment(0.0, 0.0);
        alignment3 = const Alignment(0.0, 0.0);
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: 250,
      child: Stack(
          children: [
            AnimatedAlign(
              duration: toggle?const Duration(milliseconds: 275):const Duration(milliseconds: 875),
              alignment:  alignment,
              curve: toggle?Curves.easeIn:Curves.elasticOut,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 275),
                curve: toggle?Curves.easeIn:Curves.easeOut,
                height: size,
                width: size,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(40)
                ),
                child: IconButton(icon:const Icon(Icons.arrow_back_ios_new_outlined),color: Colors.white, onPressed: widget.previousDay,),
              ),
            ),
            AnimatedAlign(
              duration: toggle?const Duration(milliseconds: 275):const Duration(milliseconds: 875),
              alignment:  alignment1,
              curve: toggle?Curves.easeIn:Curves.elasticOut,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 275),
                curve: toggle?Curves.easeIn:Curves.easeOut,
                height: size1,
                width: size1,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(40)
                ),
                child: IconButton(icon:const Icon(Icons.arrow_forward_ios_outlined),color: Colors.white, onPressed:widget.nextDay,),
              ),
            ),
            // E D I T      D A T E
            AnimatedAlign(
              duration: toggle?const Duration(milliseconds: 275):const Duration(milliseconds: 875),
              alignment:  alignment2,
              curve: toggle?Curves.easeIn:Curves.elasticOut,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 275),
                curve: toggle?Curves.easeIn:Curves.easeOut,
                height: size2,
                width: size2,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(40)
                ),
                child: IconButton(icon:const Icon(Icons.edit_calendar_outlined,size: 28,),color: Colors.white, onPressed: widget.showDatePicker,),
              ),
            ),

            // CHECK ALL
            AnimatedAlign(
              duration: toggle?const Duration(milliseconds: 275):const Duration(milliseconds: 875),
              alignment:  alignment3,
              curve: toggle?Curves.easeIn:Curves.elasticOut,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 275),
                curve: toggle?Curves.easeIn:Curves.easeOut,
                height: size3,
                width: size3,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(40)
                ),
                child: IconButton(icon:const Icon(Icons.check_box_outlined,size: 30,),color: Colors.white, onPressed: widget.onCheckAll,),
              ),
            ),
            // MENU
            Align(
              alignment: Alignment.center,
              child: FloatingActionButton(
                backgroundColor: toggle?Colors.grey[500]:Colors.grey[600],
                onPressed: pressed,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)
                ),
                child: const Icon(Icons.menu,color: Colors.white,),

              ),
            )
          ]
      ),
    );
  }
}