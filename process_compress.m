% Processing and compression function - this function will detect and
% compress signals found in the given samples to a byte (uint8) vector
% Input 1 - samps - IQ samples in Volt (complex double vector)
% Input 2 - samp_rate - Sample rate in Hz (double)
% Output - processed - Signal ID vector in byte (uint8) representation
function [processed] = process_compress(samps,samp_rate)

    % ENTER YOUR CODE HERE %
    signal_length=size(samps,1)/samp_rate;% in seconds
    chunk_time=0.001;
    fft_res=1/chunk_time;
    N= floor(signal_length/chunk_time); % fft every 1 ms

    number_of_filter_coeff=200;
    for chunks=1:N
        spct=abs(fftshift(fft(samps(1+(chunks-1)*samp_rate*chunk_time:chunks*samp_rate*chunk_time))));
        smooth_spectrum=conv(spct,(1/number_of_filter_coeff)*ones([1,number_of_filter_coeff]));
        [w,initcross,finalcross]= pulsewidth(smooth_spectrum,'MidPercentReferenceLevel',20,'StateLevels',[0,5]);

%         findpeaks()
        pulsewidth(smooth_spectrum,'MidPercentReferenceLevel',20)
        bandwidth{chunks}=w*fft_res;
        f1{chunks}=(initcross-samp_rate/fft_res/2)*fft_res;
        f2{chunks}=(finalcross-samp_rate/fft_res/2)*fft_res;
        f_center{chunks}=( f2{chunks}+ f1{chunks})./2;
        calculate_power(smooth_spectrum,spct,initcross,finalcross)
    end
%      merge_cells(fcenter,bw)
    % EXAMPLE - how to convert a variable to byte representation WITHOUT changing the bits
        processed =  flip(typecast(4e3,'uint8'));
end

