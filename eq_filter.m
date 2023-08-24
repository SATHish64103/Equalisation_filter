function [aa, bb] = eq_filter(ref_mic, test_mic, sf, filt_order, lf, hf) 
% ref_mic = broadband noise recorded using a reference microphone
% test_mic = broadband noise recorded using a test microphone
% sf = sampling frequency (in Hz)
% filt_order = filter order for fir2 function
% lf = lower cutoff frequency above which equalization needs to be done (in Hz) 
% hf = higher cutoff frequency below which equalization needs to be done (in Hz) 

% For further queries contact at sathish.sreeni58@gmail.com

[ref_mag, freq] = pspectrum(ref_mic,sf,"FrequencyResolution",1.5);
[test_mag, freq1] = pspectrum(test_mic,sf,"FrequencyResolution",1.5);
diff = sqrt(ref_mag./test_mag);
index = find(freq >= lf); diff(1:index(1)) = 0;
index = find(freq >= hf); diff(index(1)+1:end) = 0;
[aa, bb] = fir2(filt_order, freq/(sf/2), diff);