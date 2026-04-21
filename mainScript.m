wet_sounds = ["Wet Sounds\Wet Sounds_Balloon Pop Stairwell 2.mp3", "Wet Sounds\Wet Sounds_Balloon Pop Stairwell.mp3", "Wet Sounds\Wet Sounds_Shoe Smack in Stairwell 1.mp3", "Wet Sounds\Wet Sounds_Shoe Smack in Stairwell 2.mp3"];
original_sound = ("Wet Sounds\Test Sound Original.m4a");
[original_sound,fs]=audioread(original_sound);
recorded_original_sound = audioread("Wet Sounds\Test Sound Recording.m4a");
recorded_original_sound_clipped = recorded_original_sound(140000:end,:);

plot(recorded_original_sound_clipped);
%sound(recorded_original_sound_clipped,fs);
processed_sounds = {};
for i=1:length(wet_sounds)
    [audio_samples,fs]=audioread(wet_sounds(i));

    audio_clipped=audio_samples(4800:end,:);
    plot(audio_clipped);
    %RMS Normalization
    audio_normalized = 0.1 * (audio_clipped / sqrt(mean(audio_clipped.^2)));
    og_audio_normalized = 0.1 * (original_sound / sqrt(mean(original_sound.^2)));
    %Send to audio helper
    processed_sound = HelperFunctions.audioHelper(og_audio_normalized, audio_normalized);
    %Normalize processed sound
    processed_sound_normalized = 0.1 * (processed_sound / sqrt(mean(processed_sound.^2)));
    processed_sounds{i} = processed_sound_normalized;

    figure;
    %HelperFunctions.visualHelper(audio_clipped, fs)
    %Determines the size of your input
    recording=audio_normalized;
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
title("audio_normalized")

    %figure;
    %HelperFunctions.visualHelper(audio_normalized, fs)


end

resp1_file=load("Respfiles\response1.mat");
resp2_file=load("Respfiles\response2.mat");

resp1=resp1_file.blo;
resp1_fs=fs;

resp2=resp2_file.bhi;
resp2_fs=fs;

processed_resp1 = HelperFunctions.audioHelper(og_audio_normalized, resp1);
processed_resp2 = HelperFunctions.audioHelper(og_audio_normalized, resp2);

%figure;
%HelperFunctions.visualHelper(resp1, resp1_fs)

%figure;
%HelperFunctions.visualHelper(resp2, resp2_fs)

%soundsc(processed_resp1,fs);

%pause(length(processed_resp1)/fs+1);
%soundsc(processed_resp2,fs);

audiowrite('processed_sound_normalized.mp4',processed_sound_normalized,fs);

%audiowrite(filename,y,fs,Name,Value)

    figure;
    %HelperFunctions.visualHelper(audio_clipped, fs)
    %Determines the size of your input
    recording=audio_samples;
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
    title("wet_sound1")

    %figure;
    %HelperFunctions.visualHelper(audio_normalized, fs)

