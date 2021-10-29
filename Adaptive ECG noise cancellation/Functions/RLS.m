

function [w,e,d_hat] = RLS(x,d,order,lambda)
%This function implements RLS algorithm 
%-------------------------------------------------------------------
%Inputs:
%       x  : input signal vector to the filter
%       d  : desired signal vector
%       order : the number of filter order
%       lambda : exponential forgetting factor
%
% Outputs:

%       w: filter coefficients
%       e: the error between desired signal and the estimated signal 
%       d_hat: the estimated signal
%---------------------------------------------------------------
x = x(:);
d = d(:);

Ns = length(d);
% If no lambda given, set its value to 1.0
if nargin < 4,   lambda = 1.0;   end

% Generate a convolution matrix
X=convm(x,order+1);


% Initilization 
delta=0.001;
P=eye(order+1)/delta;
e=zeros(Ns,1);
w(1,:)=zeros(1,order+1);
d_hat = zeros(Ns,1);

for k=2:Ns
    z=P*X(k,:)';
    g=z/(lambda+X(k,:)*z);
    % estimated signal at time k
    d_hat(k) = X(k,:)*w(k-1,:).';
    
    % error signal at time k
    e(k)=d(k)-d_hat(k);
    
    % update coefficients
    w(k,:)=w(k-1,:)+e(k)*g.';
    P=(P-g*z.')/lambda;
end
