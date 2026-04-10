array_paths = ["Wet Sounds\Wet Sounds_Balloon Pop Stairwell 2.mp3", "Wet Sounds\Wet Sounds_Balloon Pop Stairwell.mp3", "Wet Sounds\Wet Sounds_Shoe Smack in Stairwell 1.mp3", "Wet Sounds\Wet Sounds_Shoe Smack in Stairwell 2.mp3"];

for i=1:length(array_paths)
    [audio_samples,fs]=audioread(array_path(i));
