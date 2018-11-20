function outputData = hipassFilter(inputData, cutoffFreq, sampleFreq)
%HIPASSFILTER applies hipass filter with specified cutoff frequency to
%input signal and returns filtered signal.
%   OUTPUTDATA = HIPASSFILTER(INPUTDATA) Reads input signal INPUTDATA and
%   applies hipass filter with default cutoff frequency (30 Hz) to the
%   signal. Sampling frequency of input signal is given as 25000 Hz.
%
%   OUTPUTDATA = HIPASSFILTER(INPUTDATA, CUTOFFFREQ) Reads input signal
%   INPUTDATA and applies hipass filter with specified cutoff frequency
%   CUTOFFFREQ to the signal. Sample frequency of input signal is given as
%   25000 Hz.
%
%   OUTPUTDATA = HIPASSFILTER(INPUTDATA, CUTOFFFREQ, SAMPLEFREQ) Reads
%   input signal INPUTDATA and applies hipass filter with specified cutoff
%   frequency CUTOFFFREQ to the signal. Sample frequency of input signal is
%   given as SAMPLEFREQ.
%
% Example:
%   outputData = hipassFilter(inputData);
%   outputData = hipassFilter(inputData,30);
%   outputData = hipassFilter(inputData,30,25000);

% Created by ME on 2018/11/12 12:43:45
if nargin < 1
    error('Ta funkcja wymaga podania co najmniej jednego parametru.');
else
    if nargin < 2
        cutoff = 30;
        Fs = 25000;
    elseif nargin < 3
        cutoff = cutoffFreq;
        Fs = 25000;
    else
        cutoff = cutoffFreq;
        Fs = sampleFreq;
    end
    
    % rz¹d filtru
    N = 4;
    % t³umienie w paœmie zaporowym [dB]
    Astop = 80;
    % projektowanie filtru górnoprzepustowego
    h  = fdesign.highpass('N,Fst,Ast', N, cutoff, Astop, Fs);
    Hd = design(h, 'cheby2');
    % filtrowanie danych
    ys = filter(Hd,inputData);
    outputData = ys;
end