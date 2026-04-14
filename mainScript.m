wet_sounds = ["Wet Sounds\Wet Sounds_Balloon Pop Stairwell 2.mp3", "Wet Sounds\Wet Sounds_Balloon Pop Stairwell.mp3", "Wet Sounds\Wet Sounds_Shoe Smack in Stairwell 1.mp3", "Wet Sounds\Wet Sounds_Shoe Smack in Stairwell 2.mp3"];
original_sound = ("Wet Sounds\Test Sound Original.m4a");
[original_sound,fs]=audioread(original_sound);
recorded_original_sound = audioread("Wet Sounds\Test Sound Recording.m4a");
recorded_original_sound_clipped = recorded_original_sound(140000:end,:);
%plot(recorded_original_sound_clipped);
%sound(recorded_original_sound_clipped,fs);
processed_sounds = {};
for i=1:length(wet_sounds)
    [audio_samples,fs]=audioread(wet_sounds(i));

    audio_clipped=audio_samples(4800:end,:);
    %plot(audio_clipped);
    %RMS Normalization
    audio_normalized = 0.1 * (audio_clipped / sqrt(mean(audio_clipped.^2)));
    og_audio_normalized = 0.1 * (original_sound / sqrt(mean(original_sound.^2)));
    %Send to audio helper
    processed_sound = HelperFunctions.audioHelper(og_audio_normalized, audio_normalized);
    %Normalize processed sound
    processed_sound_normalized = 0.1 * (processed_sound / sqrt(mean(processed_sound.^2)));
    processed_sounds{i} = processed_sound_normalized;
    figure;
    HelperFunctions.visualHelper(audio_clipped, fs)

    sound(processed_sound_normalized,fs)
    pause(length(recorded_original_sound_clipped)/fs+1);
   
end

