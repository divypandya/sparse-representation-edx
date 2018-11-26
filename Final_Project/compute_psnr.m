function [ psnr_val ] = compute_psnr(y_original, y_estimated)
% COMPUTE_PSNR Computes the PSNR between two images
%
% Input:
%  y_original  - The original image
%  y_estimated - The estimated image
%
% Output:
%  psnr_val - The Peak Signal to Noise Ratio (PSNR) score

y_original = y_original(:);
y_estimated = y_estimated(:);

% TODO: Compute the dynamic range
% Write your code here... dynamic_range = ????;
dynamic_range = max(y_original) - min(y_original);

% TODO: Compute the Mean Squared Error (MSE)
% Write your code here... mse_val = ????;
mse_val = norm(y_original - y_estimated)^2;

% TODO: Compute the PSNR
% Write your code here... psnr_val = ????;
n_squared = size(y_original, 1);
psnr_val  = 10 * log10(dynamic_range^2 / (1/n_squared * mse_val));

end

