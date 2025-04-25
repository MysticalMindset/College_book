% DTMF Generator and Receiver with Noise and Filtering
clear; clc; close all;

%% --- Frequency Table Generation ---
low_freqs  = 600:60:1140;        % Low frequencies for DTMF
high_freqs = 1300:120:2380;      % High frequencies for DTMF
ascii_range = 32:126;            % ASCII range for printable characters
num_chars = length(ascii_range);

% Preallocate frequency table
freq_table = zeros(num_chars, 2);

% Generate DTMF frequency table (row/col mapping based on ASCII)
for i = 1:num_chars
    idx = ascii_range(i) - 32; 
    row = mod(idx, 10) + 1; 
    col = floor(idx / 10) + 1;
    freq_table(i, :) = [low_freqs(row), high_freqs(col)];
end

% Save and reload frequency table (optional)
save('dtmf_freq_table.mat', 'freq_table');
load('dtmf_freq_table.mat', 'freq_table');

%% --- User Input & Time Series Setup ---
Fs = 8000;                      % Sampling frequency
tone_duration = 1;              % Duration of each tone (seconds)
pause_duration = 0.2;           % Pause between tones (seconds)
dt = 0.01;                      % Time step for timeseries plot

% Get user input and convert to ASCII values
ascii_input = uint8(input('Enter digits or text: ', 's'));
disp('Input as ASCII values:');
disp(ascii_input);

% Prepare time series (for Simulink or display)
num_samples = round((tone_duration + pause_duration) / dt);
expanded_data = repmat(ascii_input(:), num_samples, 1);
expanded_time = (0:length(expanded_data)-1) * dt;
ascii_ts = timeseries(expanded_data, expanded_time);

%% --- DTMF Signal Generation ---
[dtmf_signal, freqs] = generate_dtmf_ascii(ascii_input, Fs, tone_duration, pause_duration);
disp('Frequencies for each character:');
disp(freqs);

%% --- Noise Simulation ---
noise_amplitude = 0.3;
noise = noise_amplitude * randn(size(dtmf_signal));
noisy_signal = dtmf_signal + noise;

%% --- Optional Bandpass Filtering ---
apply_filter = true;
if apply_filter
    bpFilt = designfilt('bandpassiir', 'FilterOrder', 6, ...
             'HalfPowerFrequency1', 500, 'HalfPowerFrequency2', 2500, ...
             'SampleRate', Fs);
    filtered_signal = filtfilt(bpFilt, noisy_signal);
else
    filtered_signal = noisy_signal;
end

%% --- DTMF Decoding ---
decoded_text = decode_dtmf(filtered_signal, Fs, freq_table, tone_duration, pause_duration, ascii_range);
disp(['Decoded ASCII: ', decoded_text]);

%% --- Plot Signals ---
figure;
subplot(4,1,1); plot((1:length(dtmf_signal))/Fs, dtmf_signal); 
title('Original DTMF Signal'); xlabel('Time (s)'); ylabel('Amplitude');

subplot(4,1,2); plot((1:length(noise))/Fs, noise); 
title('Added Noise'); xlabel('Time (s)'); ylabel('Amplitude');

subplot(4,1,3); plot((1:length(noisy_signal))/Fs, noisy_signal);
title('Noisy Signal'); xlabel('Time (s)'); ylabel('Amplitude');

subplot(4,1,4); plot((1:length(filtered_signal))/Fs, filtered_signal); 
title('Filtered Signal'); xlabel('Time (s)'); ylabel('Amplitude');

%% --- DTMF Signal Generation Function ---
function [dtmf_signal, freqs] = generate_dtmf_ascii(input_ascii, Fs, tone_duration, pause_duration)
    low_freqs  = 600:60:1140;
    high_freqs = 1300:120:2380;
    N = length(input_ascii);
    
    tone_samples = round(Fs * tone_duration);
    pause_samples = round(Fs * pause_duration);
    
    freqs = zeros(N, 2);
    signal = [];

    for i = 1:N
        val = double(input_ascii(i));
        row = mod(val - 32, 10) + 1;
        col = floor((val - 32) / 10) + 1;
        f_low = low_freqs(row);
        f_high = high_freqs(col);
        freqs(i, :) = [f_low, f_high];

        t = (0:tone_samples-1)/Fs;
        tone = sin(2*pi*f_low*t) + sin(2*pi*f_high*t);
        pause = zeros(1, pause_samples);

        signal = [signal, tone, pause]; %#ok<AGROW>
    end

    dtmf_signal = signal(:);  % Return as column vector
end

%% --- DTMF Decoder Function ---
function decoded_text = decode_dtmf(signal, Fs, freq_table, tone_duration, pause_duration, ascii_range)
    samples_per_symbol = round(Fs * (tone_duration + pause_duration));
    tone_only_samples = round(Fs * tone_duration);
    N = length(signal);
    num_tones = floor(N / samples_per_symbol);

    decoded_text = '';
    tolerance = 30;

    for i = 1:num_tones
        start_idx = (i-1)*samples_per_symbol + 1;
        end_idx = min(start_idx + tone_only_samples - 1, N);
        segment = signal(start_idx:end_idx);

        N_fft = 2^nextpow2(length(segment));
        fft_result = abs(fft(segment, N_fft));
        freqs = (0:N_fft-1) * Fs / N_fft;

        % Find top 10 frequency peaks
        [~, sorted_indices] = sort(fft_result, 'descend');
        top_freqs = freqs(sorted_indices(1:10));

        % Match to DTMF bands
        low_freq = -1; high_freq = -1;
        for f = top_freqs
            if f >= 600 && f <= 1140 && low_freq == -1
                low_freq = f;
            elseif f >= 1300 && f <= 2380 && high_freq == -1
                high_freq = f;
            end
        end

        if low_freq ~= -1 && high_freq ~= -1
            low_match = find(abs(freq_table(:,1) - low_freq) <= tolerance);
            high_match = find(abs(freq_table(:,2) - high_freq) <= tolerance);
            match = intersect(low_match, high_match);
            if ~isempty(match)
                decoded_text = [decoded_text, char(ascii_range(match(1)))];
            else
                decoded_text = [decoded_text, '?'];
            end
        else
            decoded_text = [decoded_text, '?'];
        end
    end
end
