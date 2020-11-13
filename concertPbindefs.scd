
/////////////////////// Pbindef's

///////////////////////
///////////////////////
///////////////////////

Pbindef(\midiMoog,
	\type, \midi,
	\midicmd, \noteOn,
	\midiout, t.midiBus,
	\chan, 0,
	\scale, Scale.minor,
	\degree, Pseq([Pseq([1,-1,0,6,7,1,4,5,3], 1), Pseq([2,8,0,6,7,1,4,5,3], inf)], 1),
	\root, 2,
	\dur, Prand([ 1.1, 1, 1.01, 1, 1, 1.2, 1, 0.9, 1 ], inf)
).quant(8);


Pbindef(\klank,
	\instrument, \klank,
	\scale, Scale.minor,
	\root, 2,
	\degree, Pseq([4,0,1,2,3,2,1],inf),
	\i_freq, 164.81,
	\val, 466.16,
	\dur, 1/3,
	\sus, 0.1,
	\amp1, 0.4,
	\atk, 0.01,
	\rel, 0.1,
	\outBus, t.bBus,
	\group, t.synthGroup,
);

/*Pbindef(\klank1,
	\instrument, \klank,
	\midinote, Pseq([
		Pseq([[64, 65, 67], [60, 62, 64]], 1),
		Pseq([[62, 65, 64], [60, 67, 69, 62]], 1),
		Pseq([[52, 69, 57,], [52, 67, 57, 53]], 1),
	], inf),
	\dur, 4,
	\i_freq, 164.81,
	\val, 466.16,
	\sus, Pkey(\dur),
	\rel, Pwhite(0.8, 1.2),
	\amp1, 0.3,
	\outBus, t.bBus,
	\group, t.synthGroup,
);*/

Pbindef(\klank1,
	\instrument, \klank,
	\scale, Scale.minor,
	\root, -1,
	\degree, Pseq([
		Pseq([3,6,2,3,2],10),
		Pseq([5,2,6,5,6],4)
	], inf),
	\i_freq, 164.81,
	\val, 466.16,
	\dur, 1/4,
	\sus, 1,
	\amp1, 0.4,
	\atk, 0.01,
	\rel, 0.1,
	\outBus, t.outBus,
	\group, t.synthGroup,
);

Pbindef(\panning,
	\instrument, \discreteOut,
	\group, t.panGroup,
	\inBus, t.panBusD,
	\freq, Pseq([Pseq([2,3], 4), Prand([4,5], 1)], inf),
	\dur, 1, //Pseq([0.5, 0.6, 0.7, 1], inf)
);

///////////////////////
///////////////////////
///////////////////////

Pbindef(\midiMoog2,
	\type, \midi,
	\group, t.synthGroup,
	\midicmd, \noteOn,
	\midiout, t.midiBus,
	\chan, 0,
	\root, -32,
	\degree, Pseq([0], inf),
	\dur, 0.5
).quant(8);

///////////////////////
///////////////////////
///////////////////////
Pbindef(\grainP,
	\instrument, \bufSynth,
	\group, t.synthGroup,
	\dur, 2,
	\buf, ~lowF.bufnum,
	\rel, 1,
	\rate, 0.95,
	\start, 0,
	\amp, Pwhite(2.0, 4.0, inf),
	\outBus, t.revBus,
);

Pbindef(\midiMoog3,
	\type, \midi,
	\midicmd, \noteOn,
	\midiout, t.midiBus,
	\chan, 0,
	\root, -20,
	\degree, Pseq([Pseq([0, -2, 1], 9),Pseq([1, 2, -2], 1)], inf),
	\dur, Pseq([
		Pseq([ 0.1 ], 100),
	], inf)
);

/*Pbindef(\sawP,
\instrument, \saw,
\group, t.synthGroup,
\dur, 1/3,
\amp, 0.005,
\scale, Scale.minor,
\degree, Pseq([2,8,0,6,7,1,4,5,3],inf),
\root, -3,
\outBus, t.outBus, //OBS!!
\atk, 0.4
);*/
Pbindef(\sawP2,
	\instrument, \saw,
	\group, t.synthGroup,
	\dur, 3,
	\amp, 0.1,
	\atk, 1,
	\rel, 2,
	\scale, Scale.chromatic,
	\degree, Pseq([6,3,8], inf),
	\root, -3,
	\outBus, t.revBus
);



///////////////////////
///////////////////////
///////////////////////

Pbindef(\midiMoog4,
	\type, \midi,
	\midicmd, \noteOn,
	\midiout, t.midiBus,
	\chan, 0,
	\scale, Scale.minor,
	\degree, 0,
	\root, 4,
	\dur, Pseq([
		1, Pseq([1/3], 6),
		1, Pseq([1/3], 6),
		1, Pseq([1/3], 6),
		1, Pseq([1/3], 6),
		1, Pseq([2/3], 6),
		Pseq([1, Pseq([2/3], 6)], inf)
	], 1),
).quant(8);

Pbindef(\midiMoog5,
	\type, \midi,
	\midicmd, \noteOn,
	\midiout, t.midiBus,
	\chan, 0,
	\scale, Scale.minor,
	\root, 4,
	\degree, 3,
	\dur, 1/3
);

Pbindef(\brownPan1,
	\instrument, \brownNoiz1,
	\group, t.synthGroup,
	\rel, 0.1,
	\dur, Pseq([
		1, Pseq([1/3], 6),
		1, Pseq([1/3], 6),
		1, Pseq([1/3], 6),
		1, Pseq([1/3], 6),
		1, Pseq([2/3], 6),
		1, Pseq([2/3], 6),
	], inf),
	\amp, Pseq([0.032, Pseq([0.015], 6)], inf)*2,
	\outBus, t.aBus
).quant(2);

Pbindef(\brownPan0,
	\instrument, \brownNoiz0,
	\group, t.synthGroup,
	\freq, Pseq([
		[0,1],
		Pseq([0,1,2,3],1),
		[1,2],
		Pseq([1,2,3,0],1),
		[2,3],
		Pseq([2,3,0,1],1),
		[3,0],
		Pseq([3,0,1,2],1),
	], inf)+2,
	\rel, 0.1,
	\dur, Pseq([
		1, Pseq([1/3], 6),
		1, Pseq([1/3], 6),
		1, Pseq([1/3], 6),
		1, Pseq([1/3], 6),
		1, Pseq([2/3], 6),
	], inf),
	\amp, Pseq([0.032, Pseq([0.015], 6)], inf)*2,
).quant(2);

///////////////////////
///////////////////////
///////////////////////
