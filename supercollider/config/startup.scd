// Configure the sound server: here you could add hardware specific options
// See http://doc.sccode.org/Classes/ServerOptions.html
s.options.numBuffers = 1024 * 16; // increase this if you need to load more samples
s.options.memSize = 8192 * 16;    // increase this if you get "alloc failed" messages
s.options.maxNodes = 1024 * 32;   // increase this if you are getting drop outs and the message "too many nodes"
s.options.numOutputBusChannels = 2; // set this to your hardware output channel size, if necessary
s.options.numInputBusChannels = 2;  // set this to your hardware input channel size, if necessary

// Boot the server and start SuperDirt
s.waitForBoot({
  // Two output channels, increase if you want to pan across more channels
  ~dirt = SuperDirt(2, s);

  // Load samples (path containing a wildcard can be passed in)
  // for example: ~dirt.loadSoundFiles("/Users/myUserName/Dirt/samples/*");
  ~dirt.loadSoundFiles("~/samples/*");

  // Wait for samples to be read
  s.sync;

  // Start listening on port 57120, create two orbits, each sending audio to
  // channel 0. You can direct sounds to the orbits from tidal e.g. by: `# orbit // "0 1 1"`
  ~dirt.start(57120, [0, 0]);

  // Stop alive thread, workaround (?) for bug that causes 100% CPU hog.
  // See https://github.com/supercollider/supercollider/issues/2144#issuecomment-249169406
  s.stopAliveThread

  // Now you should be able to send from tidal via port 57120...
});
