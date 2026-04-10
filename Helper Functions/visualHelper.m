function visualHelper(recording,fs)

%Determines the size of your input
[r,c] = size(recording);

%Will figure out if you have a stereo (2 channel) or mono (1 channel) sound
if r > 1 && c > 1
    if r == 2
        recording = recording(1,:)/2 + recording(2,:)/2;
        N = c;
    elseif c == 2
        recording = recording(:,1)/2 + recording(:,2)/2;
        N = r;
    else
        error('You must input a stereo or mono sound')
    end
else
    N = max([r c]);
end

%Calculates Fourier transform
frequencies = fft(recording);

%Since Fourier transforms give complex numbers, find the magnitude
mag = abs(frequencies);

%Determines the relavent frequencies involved in the fourier transform,
%based on sampling frequency. 
freqs = linspace(1,fs/4,ceil(N/4));

%Plots the magnitude of the frequency from your input against the frequency
plot(freqs,mag(1:ceil(N/4)))

xlabel('Frequencies (Hz)')

ylabel('Magnitude (No Units)')