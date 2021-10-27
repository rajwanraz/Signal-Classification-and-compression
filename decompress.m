% Decompressing function - this function will decompress the byte vector
% from the process function into a vector of Signal ID.
% compress signals found in the given samples to a byte (uint8) vector
% Input - result_bin - Signal ID vector in byte (uint8) representation
% Output - result - Signal ID vector
function [result] = decompress(result_bin)

    % ENTER YOUR CODE HERE %
    
    % EXAMPLE - How to construct the signal ID object
    freq = 30e3;
    bw = 10e3;
    power = -50;
    t_start = 0;
    t_stop = 1;
    mod_idx = 4; % 'fm'
    result = signal_id(freq,bw,power,t_start,t_stop,mod_idx); 
end

