classdef signal_id   
    
    properties
        freq        % Baseband center frequency in Hz
        bw          % Bandwidth in Hz
        power       % Average Power in dBm
        t_start     % Start time in seconds
        t_stop      % Stop time in seconds
        modulation  % one of the options (see mod_vec below)
    end
   
    methods
        function obj = signal_id(freq, bw, power, t_start, t_stop, mod_idx)
            mod_vec = ['other', 'cw', 'am' 'fm', 'fsk', 'ofdm', 'dsss', 'chirp'];
            obj.freq = freq;
            obj.bw = bw;
            obj.power = power;
            obj.t_start = t_start;
            obj.t_stop = t_stop;
            if mod_idx < 1 || mod_idx > length(mod_vec)
                obj.modulation = "other";
            else
                obj.modulation = mod_vec(mod_idx);
            end
        end
    end
end

