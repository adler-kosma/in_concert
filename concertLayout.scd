
/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////
"INTRO - Moog73"
/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////
~INTRO = (
	~reverb.set(\level, 0.1);
	Pbindef(\midiMoog, \root, Pseq([
		Pseq([-2], 18),
		Pseq([-1,-2,-2,-1,-1,0,-1,0], 2),
		Pseq([1,1,1,0,0,0,-1,1,1], 2),
		Pseq([1,2,1,2,2,1,2,2,1], 2),
		Pseq([2], inf),
	], 1)).play;
	Pbindef(\panning).play;

	/*
	Pbindef(\midiMoog, \dur, Pseq([ 0.5, 0.2, 0.3, 0.5, 0.5, 0.6, 0.3, 0.1], inf));
	*/

	Pbindef(\midiMoog, \degree, Pseq([Pseq([2,8,0,6,7,1,4,5,3], 10), Pseq([1,4,5,3,6,3,2,4], 1), Pseq([1,0,7,5,6,3,2,4], 9)], inf));// 7-8 fuck around
	Pbindef(\midiMoog, \dur, Pseq([0.1, 0.1, 0.2, 0.1, 0.2, 0.1, 0.2, 0.1, 0.2], inf)).play;
	Pbindef(\midiMoog, \dur, Pseq([0.1], inf));
	Pbindef(\midiMoog, \dur, Pseq([7], 1), \degree, Pseq([0], 1)).play;


)

/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////
"ONE - sång  - PANKOW1 4/5".postln;
/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////
~ONE =  ( //sång
	Pbindef(\klank, \outBus, t.aBus, \amp1, 0.9, \dur, Pseq([1/3], inf)).play;
	~mic.set(\outBus, t.vocBus);
	Pbindef(\midiMoog).stop;

	/*
	~mic.set(\outBus, t.vBus);
	~pannerCircle.set(\dir, 1, \speed, 0.5);
	Pbindef(\klank, \outBus, t.aBus, \amp1, 1, \dur, Pseq([ 1/3, 1/3, 1/6], inf)).play;

	*/


	Pbindef(\klank, \outBus, t.aBus, \amp1, 1, \dur, Pseq([Pseq([1/6], 9), 1/6, 1/6, 1/6, 1/3, 1/3], inf)).play;

	~moog.set(\outBus, t.outBus); // CUTOFF
	Pbindef(\midiMoog, \root, 2, \dur, Pseq([Pseq([11/6], 1), Pseq([3/30], 10 )], inf), \degree, Pseq([Pseq([2,8,0,6,7,1,4,5,3], 10), Pseq([1,4,5,3,6,3,2,4], 1), Pseq([1,0,7,5,6,3,2,4], 9)], inf)).play;


	/*

	Pbindef(\panning, \freq, 6);
	Pbindef(\panning, \freq, Pseq([Pseq([2,3], 4), Prand([4,5], 1)], inf));

	*/

	Pbindef(\midiMoog,
		\dur, Pseq([
			Pseq([1], 1),
			Pseq([0.7], 1),
			Pseq([0.1], 8),
			Pseq([0.5], 3)], inf));

	/*

	Pbindef(\klank, \outBus, t.aBus, \amp1, 0.1);
	Pbindef(\midiMoog, \dur, 0.5);
	*/

	Pbindef(\klank).stop;
)

~ONE_ONE = (
	~moog.set(\outBus, t.aBus);
	Pbindef(\midiMoog, \dur, 0.5, \degree, Pseq([Pseq([2,8,0,6,7,1,4,5,3], 10),Pseq([1,4,5,3,6,3,2,4], 1),Pseq([1,0,7,5,6,3,2,4], 9)], inf)).play;

	Pbindef(\klank, \amp1, 0.4, \outBus, t.outBus).play;
	~mic.set(\outBus, t.vBus);

	Pbindef(\klank, \amp1, 0.7, \outBus, t.aBus).play;

	Pbindef(\midiMoog, \degree, 0, \dur, Pseq([5], 1)).play; Pbindef(\klank).stop;
)

/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////
"TWO - Moog73 - KONSERT1 4/5".postln;
/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////
~TWO = (
	~grainSynth = Synth(\grainBuf, [\buf, ~perc.bufnum, \minRate, 0.1, \maxRate, 0.12, \outBus, t.aBus, \lineDur, 100, \amp, 0.4], t.synthGroup);

	Pbindef(\midiMoog2, \dur, 1).play;
	Pbindef(\panning, \freq, Prand([5,4,3,2], inf)).play;
	~moog.set(\outBus, t.outBus);

	Pbindef(\midiMoog2, //73!!!
		\dur, Pseq([
			Pseq([1/3], 3),
			/*Pseq([4/3], 1),*/
			Pseq([1/2], 2) //change repeats
		], inf)*1
	).play;



	/*

	~grainSynth.set(\outBus, t.outBus);
	~moog.set(\outBus, t.aBus);

	~pannerCircle.set(\speed, 0.1, \dir, -1);

	~passGator.set(\outBus, t.panBusD);
	~passGator.set(\outBus, t.panBusC);
	*/


	//PLAY WITH IT
	~grainSynth.set(\amp, 1, \minRate, 2.05, \maxRate, 4, \minFreq, 0.11, \maxFreq, 1); //HIGH

	~grainSynth.set(\minRate, 0.01, \maxRate, 0.2, \minFreq, 0.5, \maxFreq, Pkey(\minFreq)*1.0001); //LOW, \minFreq, 1

)
~grainSynth.free;
/*

~pannerCircle.set(\speed, 30, \dir, -1);
//jättehög speed!
*/
/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////
"THREE - MOOG73 - PANKOW1 4".postln;
/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////

/*
Pbindef(\midiMoog2).stop;

~moog.set(\outBus, t.outBus);
~passGator.set(\outBus, t.panBusD);

*/

~THREE = (
	Pbindef(\grainP, \outBus, t.revBus).play; //FÖRST
	~pannerCircle.set(\speed, 0.1, \dir, 1);
	~mic.set(\outBus, t.outBus);
	Pbindef(\klank, \outBus, t.aBus, \root, -2, \degree, 3, \amp1, 0.7, \dur, Pseq([1], inf)).play;
	Pbindef(\midiMoog, \scale, Scale.minor, \root, -2, \dur, Pseq([1], inf), \degree, -2).play;
	Pbindef(\midiMoog, \degree, Pseq([
		Pseq([7,3,2,4,1,0,7,4], 1),
		Pseq([7,3,5,4,1,0,7,4], 1),
		Pseq([7,3,5,4,6,0,7,4], 1),
		Pseq([0,4,5,4,6,0,7,4], 1),
		Pseq([0,4,5,3,6,7,0,4], 1),
		Pseq([0,4,6,3,6,7,0,3], 1),
		Pseq([0,4,5,3,6,7,0,3], 1),
		Pseq([0,4,5,3,6,7,0,3], inf)], 1));


	Pbindef(\midiMoog, \root, -2, \dur, Pseq([3], 1)); Pbindef(\klank, \dur, Pseq([3], 1));
	~mic.set(\outBus, t.vBus); ~moog.set(\outBus, t.outBus);



	Pbindef(\midiMoog, \root, -2, \dur, Pseq([1,1,1,1,1/3], inf)).play; Pbindef(\klank, \root, -2, \degree, 2, \dur, Pseq([1], inf)).play;
	Pbindef(\midiMoog, \degree, Pseq([Pseq([0,4,6,3,7,3,2,4], 1), 6,3,2,4,1,0,6,4].reverse, inf)).play;
	~moog.set(\outBus, t.aBus);
	Pbindef(\klank, \amp1, 1, \dur, Pseq([1,1,1,1,1/3], inf), \outBus, t.aBus);



	Pbindef(\midiMoog, \dur, Pseq([1,1,1/3], 1)); Pbindef(\klank, \dur, Pseq([1,1,1/3], 1)); Pbindef(\grainP).stop;//STOP

)

~THREE_ONE = (

	//////////////////////
	"MOOG OSC1 16'- KONSERT1 6".postln; //OBS OBS OBS OBS ///// KORG VOLUME
	//////////////////////

	~moog.set(\outBus, t.aBus);
	Pbindef(\midiMoog, \dur, Pseq([Pseq([0.3], 30), Pseq([0.1], 20)], inf), \degree, Pseq([Pseq([0,4,5,3,7,3,2,4], 1), 7,3,2,4,1,0,7,4].reverse, inf)).play;
	Pbindef(\panning, \freq, Pseq([2,3,4,5], inf), \dur, Pseq([Pseq([0.1], 20), Pseq([0.1], 20)], inf)).play;
	Pbindef(\grainP, \buf, ~kick, \outBus, t.aBus, \speed, 0.7, \amp, 0.2, \dur, Pseq([Pseq([0.3], 30), Pseq([0.1], 20)], inf)).play;


	/*
	~pannerCircle.set(\speed, 0.1, \dir, -1);
	*/
	//Pbindef(\grainP, \buf, ~lowF, \dur, 1, \amp, 1, \rate, 1, \speed, 1, \outBus, t.revBus).play;
	//inge nice
)
/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////
"FOUR - MOOG73/74 - PANKOW1 spår6 - MIC "
/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////
~FOUR = (
	(//KÖR BA TRYCK HÄR

		Pbindef(\midiMoog1).stop;
		Pbindef(\midiMoog2).stop;
		Pbindef(\midiMoog3).stop;
		Pbindef(\midiMoog4).stop;
		Pbindef(\midiMoog).stop;
		Pbindef(\klank).stop;
		Pbindef(\panning).play;
		Pbindef(\grainP).stop;
	)

	Pbindef(\sawP2, \outBus, t.revBus).play;
	Pbindef(\klank, \outBus, t.aBus, \root, 7, \amp1, 0.3, \degree, Pseq([4,0,1,2,3,2,1],inf), \dur, Pseq([Pseq([1/6], 10), 1/6, 1/6, 1/6, 1/3, 1/3], inf)).play;

	~moog.set(\outBus, t.bBus);
	~mic.set(\outBus, t.vocBus);
	~korg.set(\outBus, t.bBus);
	Pbindef(\midiMoog, \root, 7, \dur, 1, \degree, Pseq([2,8,0,6,7,1,4,5,3].invert, inf)).play;

	~mic.set(\outBus, t.vocBus);
	Pbindef(\midiMoog, \root, 7, \dur, Pwrand([0.3, 0.1], [0.7, 0.3], inf)).play; //.stop

	/*
	(
	~moog.set(\outBus, t.outBus); ///OBS HÖG VOLYM!, börja på NOLL
	~moog.set(\outBus, t.aBus); ///börja på NOLL
	Pbindef(\midiMoog, \dur, 1/3, \degree, Pseq([2,8,0,6,7,1,4,5,3].reverse, inf)).play;

	*/

	Pbindef(\klank, \dur, Pseq([1], 3)).play; Pbindef(\sawP2, \dur, Pseq([1], 3)).play; //STOP

	Pbindef(\midiMoog).stop;
	~korg.set(\outBus, t.revBus); //VOLUME



)

/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////
"FIVE - Moog73 - KONSERT1 1+2".postln;
/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////
~FIVE = (
	~korg.set(\outBus, t.bBus);
	~moog.set(\outBus, t.aBus);
	Pbindef(\midiMoog).stop;
	Pbindef(\klank).stop;
	Pbindef(\grainP).stop;
	~mic.set(\outBus, t.outBus);
	~pannerCircle.set(\speed, 1);

	Pbindef(\brownPan1, \outBus, t.aBus).play; Pbindef(\brownPan0).play;

	Pbindef(\panning,
		\instrument, \discreteOut,
		\group, t.panGroup,
		\inBus, t.panBusD,
		\freq, Prand([2,3,4,5], inf),
		\dur, 1).play;

	Pbindef(\brownPan1, \dur, Pseq([1, Pseq([2/3], 6)], 1)); Pbindef(\brownPan0, \dur, Pseq([1, Pseq([2/3], 6)], 1)); //STOP

	Pbindef(\brownPan1, \dur, Pseq([1, Pseq([1/3], 6),1, Pseq([1/3], 6),1, Pseq([1/3], 6),1, Pseq([1/3], 6),1, Pseq([2/3], 6),1, Pseq([2/3], 6),], inf),\outBus, t.outBus).play; Pbindef(\brownPan0, \dur, Pseq([1, Pseq([1/3], 6),1, Pseq([1/3], 6),1, Pseq([1/3], 6),1, Pseq([1/3], 6),1, Pseq([2/3], 6)], inf)).play;
	Pbindef(\midiMoog4,
		\dur, Pseq([
			1, Pseq([1/3], 6),
			1, Pseq([1/3], 6),
			1, Pseq([1/3], 6),
			1, Pseq([1/3], 6),
			1, Pseq([2/3], 6),
			Pseq([1, Pseq([2/3], 6)], inf)
		], 1),
	).play;

	/*
	~moog.set(\outBus, t.outBus); ~mic.set(\outBus, t.vBus);
	Pbindef(\brownPan1, \outBus, t.aBus).play;
	Pbindef(\midiMoog4).stop;
	~passGator.set(\outBus, t.panBusD);

	*/


	Pbindef(\brownPan0).stop; Pbindef(\brownPan1).stop;
	Pbindef(\midiMoog4, \root, 4, \dur, Pseq([Pseq([2/3], 6), Pseq([1/3], 6)], inf));
	Pbindef(\midiMoog4, \degree, Pseq([Pseq([0,7,3,5,5,2,1], 3), Pseq([0,6,3,5,5,2,1], 3),Pseq([0,5,3,7,6,2,1], 3)], inf));
	///invert, reverse

	Pbindef(\midiMoog4, \dur, 1/3);
	Pbindef(\klank1, \root, 4, \degree, Prand([4,0,1,2,3,2,1],inf), \outBus, t.aBus, \amp1, 0.5, \dur, Pseq([1/3], inf)).play;
	~pannerCircle.set(\dir, 1, \speed, 2);


	/*
	NOISE IGEN
	Pbindef(\klank1, \root, 4, \degree, Prand([4,0,1,2,3,2,1],1)); //STOP
	Pbindef(\midiMoog4, \degree, 0);

	Pbindef(\midiMoog4).stop;
	*/

)


/*
~mic.set(\outBus, t.vBus);
Pbindef(\klank1).stop , \root, 4, \degree, 7, \outBus, t.aBus, \amp1, 1.5, \dur, Pseq([1/3], inf)).play;



*/

/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////

/*
~korg.free;
~moog.free;
~mic.free;
~grainSynth.free;
Pbindef(\midiMoog).stop;
Pbindef(\midiMoog1).stop;
Pbindef(\midiMoog2).stop;
Pbindef(\midiMoog3).stop;
Pbindef(\midiMoog4).stop;
Pbindef(\klank).stop;
Pbindef(\klank1).stop;
Pbindef(\brownPan1).stop;
Pbindef(\brownPan0).stop;
Pbindef(\panning).stop;

*/

//Pbindef(\klank, \root, 4, \degree, Pseq([4,0,1,2,3,2,1],inf), \outBus, t.aBus, \amp1, 0.7, \dur, Pseq([1/3], inf)).stop;


