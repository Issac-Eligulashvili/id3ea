%Audio Helper will model the reverb of a room in which you have recoreded
%an impulse response using another test sound.

%Inputs:
%originalSound - An unprocessed sound to apply your reverb model to
%impulseResponse - Your trimmed impulse response recording

%Note that both inputs should have the same sampling frequency, ideally
%44100Hz.

%Output - processedSound - originalSound processed using the impulse
%response you provide.
function [processedSound] = audioHelper(originalSound,impulseResponse)

%Uses the overlap and add method to apply the impulse response model to
%your test sound. For more information, see the help document on fftfilt
processedSound = fftfilt(impulseResponse,originalSound);
