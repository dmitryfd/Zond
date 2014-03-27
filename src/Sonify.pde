import java.util.*;
import beads.*;

class Sonify {
	public Datapoint[] dataset = null;
	public boolean verbose = false;

	// Default settings
	public String franceFile = sketchPath("") + "../audio/france.wav";
	public String usaFile = sketchPath("") + "../audio/usa.wav";
	public String chinaFile = sketchPath("") + "../audio/china.wav";
	public String ukFile = sketchPath("") + "../audio/uk.wav";
	public String ussrFile = sketchPath("") + "../audio/ussr.wav";
	public String pakistanFile = sketchPath("") + "../audio/pakistan.wav";
	public String sampleFile =  sketchPath("") + "../audio/sample.wav";

	public Sample franceSample = null;
	public Sample usaSample = null;
	public Sample chinaSample = null;
	public Sample ukSample = null;
	public Sample ussrSample = null;
	public Sample pakistanSample = null;
	public Sample sampleSample = null;

	public AudioContext ac=null;

	public Compressor comp=null;


	Sonify(Datapoint[] d) {
		dataset = d;
	}

	Sonify(Datapoint[] d, boolean v) {
		dataset = d;
		verbose = v;
	}

	public void set_samples(String china, String france, String pakistan, String uk, String usa, String ussr) {
		franceFile = sketchPath("") + "../audio/" + france;
		usaFile = sketchPath("") + "../audio/" + usa;
		ukFile = sketchPath("") + "../audio/" + uk;
		chinaFile = sketchPath("") + "../audio/" + china;
		ussrFile = sketchPath("") + "../audio/" + ussr;
		pakistanFile = sketchPath("") + "../audio/" + pakistan;
	}

	public void sample_init(){
		try{
			ac=new AudioContext();
			comp=new Compressor(ac);
			ac.out.addInput(comp);
			/*franceSample = new Sample(franceFile);
			usaSample = new Sample(franceFile);
			chinaSample = new Sample(franceFile);	
			ukSample = new Sample(franceFile);
			ussrSample = new Sample(franceFile);
			pakistanSample = new Sample(franceFile);*/
			sampleSample = new Sample(sampleFile);
		}
		catch(Exception e){
			System.out.println("Can't open specified file");
		}
	}

	// Set all the filter settings
	
	// Method to produce a note at this point of dataset

	public void soundTheAlarm(Datapoint point){

		System.out.println("wait= "+point.timeSince+"\n"+"date= "+point.date);
		try{
			Thread.sleep(point.timeSince);
		}
		catch (InterruptedException e){
			System.out.println("gotta catch 'em all!");
		}
		play_sample();

		PFont f = createFont("Arial",16,true);
		textFont(f,16);                 // STEP 4 Specify font to be used
  		fill(0);                        // STEP 5 Specify font color 
  		background(255);
  		text(point.date,10,100);  // STEP 6 Display Text
	}
	
	// Derping around
	public void play_sine() {
		AudioContext ac = new AudioContext();
		WavePlayer wp = new WavePlayer(ac, 440, Buffer.SINE);
		Gain g = new Gain(ac, 1, 0.4);
		g.addInput(wp);
		ac.out.addInput(g);
		ac.start();
	}

	public void play_sample() {
		//ac=new AudioContext();
		SamplePlayer sp;

		try { 
		 	sp = new SamplePlayer(ac, sampleSample);
		}
		catch(Exception e) {
			println("Sonify: Error! Couldn't load the sample!");
			return;
		}

		sp.setKillOnEnd(true);
		Gain g = new Gain(ac, 1, 1.0);

		g.addInput(sp);
		comp.addInput(g);
		//ac.out.addInput(g);
		ac.start();
	}
};