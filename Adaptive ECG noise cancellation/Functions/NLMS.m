function [e, y, w] = NLMS(d, x, beta, order)
%This function implements NLMS algorithm 
%-------------------------------------------------------------------
%Inputs:
%       d  : desired signal vector
%       x  : input signal vector to the filter
%       beta : step size
%       order : the number of filter order

%
% Outputs:

%       e: the error between desired signal and the output signal 
%       y: output signal
%       w:  filter coefficients
%---------------------------------------------------------------
x = x(:);
d = d(:);

Ns = length(d);
% Generate a convolution matrix
X =convm(x,order+1);
% Initilization 
w1 = zeros(order+1,1);
y = zeros(Ns,1);
e = zeros(Ns,1);
for k = 1:Ns
    % output signal at time k
    y(k) = X(k,:)*w1;
    
    % error signal at time k
    e(k) = d(k) - y(k);
    
    % normalization
    g = beta/(0.001 + X(k,:)*X(k,:).');
    
    % update coefficients
    w1 = w1 + g * e(k) * X(k,:).';
    
    % save coefficients
    w(:,k) = w1;
end

end