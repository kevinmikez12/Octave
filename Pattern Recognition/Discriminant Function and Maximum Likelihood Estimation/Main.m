## Copyright (C) 2015 Qamar-ud-Din
## 
## This program is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## @deftypefn {Function File} {@var{retval} =} Main (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Qamar-ud-Din <qamar-ud-din@qamaruddin-Vostro-1540>
## Created: 2015-12-21

function [g_1, g_2, g_3] = Main
  ## constants
  num_of_training_samples = 20;
  num_of_testing_samples = 30;
  num_of_samples_per_class = 50;
  num_of_features = 4;
  priori = 1 / 3;
  ## read file into four columns to escape text`
  [x_1, x_2, x_3, x_4] = textread("Iris Data.txt", "%f %f %f %f %*s", "delimiter", ",");
  ## merge the columns into 150x4 Matrix
  Iris_Dataset = [x_1 x_2 x_3 x_4];
  ## separate each class into 20x4 Matrix for Training
  ## use constants for generic coding
  w1 = Iris_Dataset(1:num_of_training_samples, :);
  from = (1+num_of_samples_per_class);
  to = from + num_of_training_samples - 1;
  w2 = Iris_Dataset(from:to, :);
  from = (1 + num_of_samples_per_class * 2);
  to = from + num_of_training_samples - 1;
  w3 = Iris_Dataset(from:to, :);
  ## estimate mean vector meu for each class (state of nature) 4x1 vector
  meu_1 = vec(mean(w1));
  meu_2 = vec(mean(w2));
  meu_3 = vec(mean(w3));
  ## estimate covariance matrix
  cov_1 = Estimate_Covariance_with_MLE (w1, meu_1, num_of_features, num_of_training_samples);
  cov_2 = Estimate_Covariance_with_MLE (w2, meu_2, num_of_features, num_of_training_samples);
  cov_3 = Estimate_Covariance_with_MLE (w3, meu_3, num_of_features, num_of_training_samples);
  
  ## calculate linear coefficients of discriminant functions for each class (state of nature)
  ## Wi
  W_1 = (-1 / 2) * inv(cov_1);
  W_2 = (-1 / 2) * inv(cov_2);
  W_3 = (-1 / 2) * inv(cov_3);
  ## wi
  w_1 = inv(cov_1) * meu_1;
  w_2 = inv(cov_2) * meu_2;
  w_3 = inv(cov_3) * meu_3;
  ## Omega_i_0
  omega_1_0 = (-1/2) * transpose(meu_1) * inv(cov_1) * meu_1 - (1/2) * log(det(cov_1)) + log(priori);
  omega_2_0 = (-1/2) * transpose(meu_2) * inv(cov_2) * meu_2 - (1/2) * log(det(cov_2)) + log(priori);
  omega_3_0 = (-1/2) * transpose(meu_3) * inv(cov_3) * meu_3 - (1/2) * log(det(cov_3)) + log(priori);
  
  ## extract testing set Matrix 30 x 4
  ## use constants for generic coding
  w1 = Iris_Dataset(num_of_training_samples+1:num_of_samples_per_class, :); ## (21:50, :)
  from = (1+num_of_samples_per_class+num_of_training_samples); ## 71
  to = from + num_of_testing_samples - 1; ## 100
  w2 = Iris_Dataset(from:to, :);
  from = (1+2*num_of_samples_per_class+num_of_training_samples); ## 121
  to = from + num_of_testing_samples - 1; ## 150
  w3 = Iris_Dataset(from:to, :);
  
  x = vec(w3(1,:));
  g_1 = transpose(x) * W_1 * x + transpose(w_1) * x + omega_1_0;
  g_2 = transpose(x) * W_2 * x + transpose(w_2) * x + omega_2_0;
  g_3 = transpose(x) * W_3 * x + transpose(w_3) * x + omega_3_0;
  
  
endfunction
