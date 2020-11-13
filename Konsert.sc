////Ska alla ha gate=1 så att jag kan stänga av synthen?
////Instansmetoder för synthar? Hur arbetar jag med syntharna då? ändrar parametrar
////Flera synthar under samma instansmetod? Hur kallar jag dem var och en för sig?

///////////////////////////////
//panBus -- skickar ljud till alla 4 högtalare genom \outSynth
//panBusC -- skickar ljud till \pannerCircle
//PanBusD -- skickar ljud till \discreteOut som spelas av en Pbindef

Konsert {
	var server;
	var synth, <synthGroup, <fxGroup, <panGroup, <aBus, <bBus, <outBus, <revBus, <panBus, <panBusC, <panBusD, <midiBus, delBus, masterBus, masterSynth, gator_s, out_s, korg_s, moog_s, mic_s, klank_s, reverb_s, delay_s, panner_s;
	var fxAssignments;

	*new { //klassmetod
		^super.new.initKonsert;
	}

	initKonsert { //instansmetod
		server = Server.default;
		MIDIClient.init;
		midiBus = MIDIOut.new(1);
		CmdPeriod.add({(0..127).do{arg n; midiBus.noteOff(0,n)}});

		server.waitForBoot{
			Konsert.sendSynthDefs;
			server.sync;
			~bdkrev = Buffer.readChannel(server,"/Users/adele21/Music/SuperCollider/klangwürfel-lead you home/lead_you_home_rev_rec_1.aiff", channels:[0]);
			~perc = Buffer.readChannel(server,"/Users/adele21/Music/SuperCollider/Mobilen/ljuden/12-Wood_Block.wav", channels: [0]);
			~kick = Buffer.readChannel(server,"/Users/adele21/Music/DRUMS/kicks från daniel/kick(mmm).wav", channels: [0]);
			aBus = Bus.audio(server, 1); // master
			bBus = Bus.audio(server, 1); // slave
			revBus = Bus.audio(server, 1); //reverb
			panBus = Bus.audio(server, 1); //panning to all channels
			panBusC = Bus.audio(server, 1); //panning circle
			panBusD = Bus.audio(server, 1); //panning discrete
			outBus = Bus.audio(server, 1); //routing passed gator through reverb
			delBus = Bus.audio(server, 1); //delay
			masterBus  = Bus.audio(server, 4);
			synthGroup = Group.new(server);
			fxGroup = Group.after(synthGroup);
			panGroup = Group.after(fxGroup);
			masterSynth = Synth.after(panGroup, \master, [\inBus, 0]);
			server.options.numOutputBusChannels = 10;
			server.options.numInputBusChannels = 4;
			server.options.sampleRate = 48000;
			server.recChannels = 6;

		};
	}

	gator {|parValEvent|
		fork{
			if(gator_s.isNil, {
				gator_s = Synth(\gator, nil, fxGroup, 'addToHead');
				server.sync;
				parValEvent.keysValuesDo{|par, val|
					gator_s.set(par, val);
				};
			}, {
				parValEvent.keysValuesDo{|par, val|
					gator_s.set(par, val);
				};
			});
		};
	}

	/*	gator { |inBusA, inBusB, lag=10, clampT=0.01, relT=0.5, thresh=0.5, outBus|
	gator_s = Synth(\gator, [\inBusA, inBusA, \inBusB, inBusB, \clampTime, clampT, \relaxTime, relT, \thresh, thresh, \lag, lag, \outBus, outBus, \revOut, revBus, \delOut, delBus], fxGroup, 'addToHead');
	}*/

	// outSynth { |inBus, gate=1|
	// 	out_s = Synth(\outSynth, [\inBus, inBus, \gate, gate], panGroup);
	// }

	/*sound_input { |synth, inBus, outBus|

	korg_s = Synth(synth, [\inBus, inBus, \outBus, outBus], synthGroup);
	moog_s = Synth(\moog, [\inBus, inBus, \outBus, outBus], synthGroup);
	mic_s = Synth(\mic,  [\inBus, inBus, \outBus, outBus], synthGroup);

	}

	generator { |outBus|

	klank_s = Synth(\klanker, [\outBus, outBus, \i_freq, 200], synthGroup)


	}
	reverb { |outBus, level=0.1, gate=1|
	reverb_s = Synth(\reverb, [\inBus, revBus, \outBus, outBus, \level, level, \gate, gate], fxGroup, 'addToTail');

	}

	panner { |inBus, outBus=0, speed=0.01, dir=1|
	//delay_s = Synth(\delay, [\inBus, delBus, \outBus, outBus], fxGroup);
	panner_s = Synth(\panner, [\inBus, inBus, \outBus, outBus, \speed, speed, \dir, dir], fxGroup, 'addToTail');

	}*/

	/*playSynth {|name = \moog, inBus=0, outBus=0, amp=0.1|
	synth = Synth(name, [\amp, amp]);
	}*/

	/*	stopSynth {
	synth.set(\gate, 0);
	}*/

	*sendSynthDefs {
		(
			SynthDef.new(\mic,{
				arg inBus, outBus, amp=1, freq=293.67, modMix=0;
				var input, sig, rmod;
				input = SoundIn.ar(inBus) * amp;
				rmod = input * SinOsc.ar(freq);
				sig = input + (rmod * modMix);
				sig = HPF.ar(sig, 400);
				Out.ar(outBus, sig);
			}).add;

			SynthDef.new(\moog, {
				arg inBus, outBus, amp=0.3;
				var input, filter, filter0;
				input = SoundIn.ar(inBus) * amp;
				filter = BBandStop.ar(input, 400, 2);
				filter0 = LPF.ar(filter, 1000);
				Out.ar(outBus, filter0);
			}).add;

			SynthDef.new(\D1200,{
				arg inBus, outBus, amp=1;
				var input;
				input = SoundIn.ar(inBus) * amp;
				Out.ar(outBus, input);
			}).add;

			SynthDef(\klank, {
				arg outBus, i_freq=200, atk=0.1, /*sus=1, */rel=0.6, amp1=0.5, val=466.16;
				var klank, n, harm, amp, ring, env;
				env = EnvGen.ar(Env.perc(atk, rel), doneAction:2);/*
				Env([0,1,0],[atk,sus,rel]), gate,
				doneAction:2);*/
				harm = \harm.ir(Array.series(4, 1, 1));
				amp = \amp.ir(Array.fill(4, 0.05));
				ring = \ring.ir(Array.fill(4, 1));
				klank = Klank.ar(`[harm, amp, ring], {SinOsc.ar(val)*0.03}.dup, i_freq) * env * amp1;
				Out.ar(outBus, klank);
			}).add;

			SynthDef(\bufSynth, {
				arg outBus, buf, rate=(-1), start=0, amp=1, atk=0.1, rel=0.5;
				var sig, env;
				env = EnvGen.kr(Env.perc(atk, rel), doneAction:2);
				sig = PlayBuf.ar(1, buf, rate, 1, start);
				sig = sig * amp * env;
				Out.ar(outBus, sig);
			}).add;

			SynthDef(\brownNoiz0, {
				arg freq, amp=0.01, rel=1.0;
				var sig, env;
				env = EnvGen.kr(Env.perc(0.1, rel), doneAction:2);
				sig = BrownNoise.ar(amp) * env;
				Out.ar(freq, sig);
			}).add;

			SynthDef(\brownNoiz1, {
				arg outBus, amp=0.01, rel=1.0;
				var sig, env;
				env = EnvGen.kr(Env.perc(0.1, rel), doneAction:2);
				sig = BrownNoise.ar(amp) * env;
				Out.ar(outBus, sig);
			}).add;

			SynthDef(\saw, {
				arg gate=1, amp=0.01, freq=440, atk=0.1, sus=1, rel=0.5, freqF=800, outBus;
				var env, sig, filter;
				env = EnvGen.kr(Env.asr(atk, sus, rel), gate, doneAction:2);
				sig = Saw.ar(freq) * amp;
				filter = LPF.ar(sig, freqF);
				sig = filter * env;
				Out.ar(outBus, sig);
			}).add;

			SynthDef(\grainBuf, {
				arg outBus, buf, lag=10, minFreq=1.0, maxFreq=6.0, minRate=0.5,maxRate=1.4, amp=0.3, lineDur=10;
				var sig, trig, rate, freq, lineF, mixS;
				lineF = XLine.kr(0.1, 1, lineDur);
				freq = LFNoise1.ar(1).range(minFreq.lag(lag),maxFreq.lag(lag)) * lineF;
				trig = Impulse.kr(freq);
				rate = LFNoise0.kr(200).range(minRate.lag(lag), maxRate.lag(lag));
				sig = PlayBuf.ar(1, buf, rate, trig) * amp.lag(lag);
				Out.ar(outBus, sig);
			}).add;

			SynthDef(\gator,  {
				arg inBusA, inBusB, gate=1, lag=10, clampTime=0.01, relaxTime=0.1, thresh=0.5,
				slopeBelow=3, slopeAbove=1, outBus, revOut, delOut;
				var kick, pads, snd, env, outSig;
				env = EnvGen.kr(Env.asr(), gate, doneAction: 2);
				kick = In.ar(inBusA, 1);
				pads = In.ar(inBusB, 1);
				snd = Compander.ar(pads, kick, thresh, slopeBelow, slopeAbove, clampTime.lag(lag), relaxTime.lag(lag));
				outSig = (kick + snd) * env;
				Out.ar(outBus, outSig); //panning
				Out.ar(revOut, outSig);
				//Out.ar(delOut, outSig);
			}).add;

			SynthDef(\reverb, {
				arg inBus, outBus, level=0.1, gate=1;
				var input, env, rev;
				env = EnvGen.ar(Env.asr(), gate, doneAction: 2);
				input = In.ar(inBus, 1) * env * level.lag(10);
				input = Pan2.ar(input);
				rev = NHHall.ar(input, 5, 0.5, 200, 0.5, 4000, 0.1, 0.5, 0.5, 0.2, 0.3);
				Out.ar(outBus, rev*0.6);
				Out.ar(2, rev*0.4);
				Out.ar(4 , rev*0.4);
			}).add;

			SynthDef(\delay, {
				arg inBus, outBus, atk=0.1, rel=0.5, maxdel=1.0, deltime=0.3, decay=0.5, level=0.5, gate=1;
				var delay, input, env, klick;
				env = EnvGen.kr(Env.asr(atk, 1, rel), gate, doneAction:2);
				input = In.ar(inBus) * level * env;
				delay = CombL.ar(input, maxdel, deltime, decay);
				Out.ar(outBus, delay);
			}).add;

			SynthDef(\pannerCircle, {
				arg inBus, outBus, speed=0.01, level=1, dir=1;
				var pan, input;
				input = In.ar(inBus) * level;
				pan = PanAz.ar(4, input, LFSaw.kr(speed) * dir);
				Out.ar(outBus, pan);
			}).add;

			SynthDef(\discreteOut, {
				arg inBus, freq, gate=1;
				var input, env;
				env = EnvGen.kr(Env.asr(), gate, doneAction: 2);
				input = In.ar(inBus) * env;
				Out.ar(freq, input);
			}).add;

			SynthDef(\outSynth, {
				arg inBus, outBus,outBus1, gate=1;
				var input, env;
				env = EnvGen.kr(Env.asr(), gate, doneAction: 2);
				input = In.ar(inBus, 1) * env;
				input = Splay.ar(input);
				Out.ar(outBus, input);
				Out.ar(outBus1, input*0.5);
			}).add;

			SynthDef(\noGator, {
				arg inBus, outBus, revOut;
				var input;
				input = In.ar(inBus);
				Out.ar(outBus, input);
				Out.ar(revOut, input);
			}).add;


			SynthDef(\master, {
				arg inBus, level=0.8;
				var sig;
				sig = In.ar(inBus, 8);
				sig = Limiter.ar(sig, level);
				Out.ar(0, sig);
			}).add;
		)
	}
}