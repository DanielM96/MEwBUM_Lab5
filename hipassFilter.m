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
        fs = 25000;
    elseif nargin < 3
        cutoff = cutoffFreq;
        fs = 25000;
    else
        cutoff = cutoffFreq;
        fs = sampleFreq;
    end
    fn = fs/2;
    [ b, a ] = cheby2(4,45,cutoff/fn,'high');
    ys = filter(b,a,inputData);
    outputData = ys;
end