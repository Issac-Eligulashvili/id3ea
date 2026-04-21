% --- 1. Define File Paths ---
wet_sounds = [
    "Wet Sounds\Wet Sounds_Balloon Pop Stairwell 2.mp3", 
    "Wet Sounds\Wet Sounds_Balloon Pop Stairwell.mp3", 
    "Wet Sounds\Wet Sounds_Shoe Smack in Stairwell 1.mp3", 
    "Wet Sounds\Wet Sounds_Shoe Smack in Stairwell 2.mp3"
];
original_sound_file = "Wet Sounds\Test Sound Original.m4a";
recorded_original_sound_file = "Wet Sounds\Test Sound Recording.m4a";

% --- 2. Process Original (Dry) Sound ---
[original_sound, fs] = audioread(original_sound_file);

% RMS Normalization for the Original Sound (Done once outside the loop)
og_audio_normalized = 0.1 * (original_sound ./ sqrt(mean(original_sound.^2)));

recorded_original_sound = audioread(recorded_original_sound_file);
recorded_original_sound_clipped = recorded_original_sound(140000:end,:);
figure;
plot(recorded_original_sound_clipped);
title('Original Sound Clipped');
%sound(recorded_original_sound_clipped,fs);

processed_sounds = {};

% --- 3. Loop Through All Wet Sounds ---
for i = 1:length(wet_sounds)
    % Get the current filename for dynamic labeling (ignores extension and folder)
    [~, current_name, ~] = fileparts(wet_sounds(i));
    
    % Read and clip audio
    [audio_samples, fs] = audioread(wet_sounds(i));
    audio_clipped = audio_samples(4800:end,:);
    
    figure;
    plot(audio_clipped);
    title(sprintf('Clipped Waveform: %s', strrep(current_name, '_', '\_')));
    
    % RMS Normalization
    audio_normalized = 0.1 * (audio_clipped ./ sqrt(mean(audio_clipped.^2)));
    
    % Send to audio helper
    processed_sound = HelperFunctions.audioHelper(og_audio_normalized, audio_normalized);
    
    % Normalize processed sound
    processed_sound_normalized = 0.1 * (processed_sound ./ sqrt(mean(processed_sound.^2)));
    processed_sounds{i} = processed_sound_normalized;
    
    % --- Save Processed Sound ---
    % Saves dynamically named files (e.g., "Processed_Wet Sounds_Balloon Pop.m4a")
    out_filename = sprintf('Processed_%s.m4a', current_name);
    audiowrite(out_filename, processed_sound_normalized, fs);
    
    % --- FFT Plotting ---
    figure;
    recording = audio_normalized;
    [r,c] = size(recording);
    
    % Will figure out if you have a stereo (2 channel) or mono (1 channel) sound
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
    
    % Calculates Fourier transform
    frequencies = fft(recording);
    
    % Since Fourier transforms give complex numbers, find the magnitude
    mag = abs(frequencies);
    
    % Determines the relevant frequencies involved in the fourier transform
    freqs = linspace(1, fs/4, ceil(N/4));
    
    % Plots the magnitude of the frequency from your input against the frequency
    plot(freqs, mag(1:ceil(N/4)))
    xlabel('Frequencies (Hz)')
    ylabel('Magnitude (No Units)')
    % Dynamically label the title with the file name
    title(sprintf('FFT Magnitude: %s', strrep(current_name, '_', '\_')));
    
end

% --- 4. Process Resp Files ---
resp1_file = load("Respfiles\response1.mat");
resp2_file = load("Respfiles\response2.mat");

resp1 = resp1_file.blo;
resp1_fs = fs;
resp2 = resp2_file.bhi;
resp2_fs = fs;

processed_resp1 = HelperFunctions.audioHelper(og_audio_normalized, resp1);
processed_resp2 = HelperFunctions.audioHelper(og_audio_normalized, resp2);

% soundsc(processed_resp1,fs);
% pause(length(processed_resp1)/fs+1);
% soundsc(processed_resp2,fs);