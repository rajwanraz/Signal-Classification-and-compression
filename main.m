%% Tasktit signal contest main script - Instructions
%{                
Your goal is to identify, compress and represent the parameters of signals 
found in raw IQ samples. The end result will be a vector of a class 
called Signal ID - see signal_id.m for the definition and the required 
fields of the this class.

All work, outside of visualzation of the samples, must be done in the 
body of the two functions - process_compress and decompress. See the
functions files for futher detailes.

This script will be used by the contestants to run their functions on 
the sample files. It must NOT be modified beyond mentioned, since
the same script will be used to run the scoring sample files. 

The final score and the winner will be defined by these benchmarks in
order of importance:

1 - Result accuracy compared to the truth. BEWARE - Misdetections WILL
be penalised, so don't go guns blazing.
BONUS POINTS will be given if you manage to identify IDs that have 
similar or identical parameters and merge them together to a single signal ID. 
This can be done in either of the two functions. The merged ID can have one 
of it's parameters as a vector if it's not consistent (ex. center frequency 
as a vector for a frequency hopping signal)

2 - Compressed result size in bytes - uint8. Smaller is better.

3 - Process function run time. Shorter - better.

Good luck and have fun!
%}
%% Reset
close all;
clear;
clc;
%% Signal parameters
file_name = 'sig4_25mhz';
% file_name = 'sig2_20mhz';

samp_rate = 25e6;
%% Read samples from file
file = fopen(file_name,'r');
samples = fread(file,'float'); %reads floats
fclose(file);
samples = samples(1:2:end) + 1i*samples(2:2:end); %convert to complex floats
%% Run front processing function
tic;
result_bin = process_compress(samples,samp_rate);
process_runime = toc; % Benchmark 3 - Processing time
result_bin_is_bin = isa(result_bin,'uint8'); % Check if the result is a byte array
%% Save result binary to file and measure it's size
file = fopen("result.bin",'w');
fwrite(file,result_bin);
compressed_size = dir('result.bin').bytes; % Benchmark 2 - compressed data size
fclose(file);
%% Run decompress function on result binary
result = decompress(result_bin); % Benchmark 1 - Result accuracy
result_is_id = isa(result,'signal_id'); % Check if the result is a signal id array