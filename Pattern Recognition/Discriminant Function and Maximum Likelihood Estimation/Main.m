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

function covariance_matrix = Main
  ## constants
  num_of_training_samples = 20;
  num_of_testing_samples = 30;
  num_of_samples_per_class = 50;
  num_of_features = 4;
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
  covariance_matrix = zeros(num_of_features, num_of_features);
  for k = 1:num_of_training_samples
    for i = 1:num_of_features
      for j = 1:num_of_features
        covariance_matrix(i, j) += ( w1(k, i) - meu_1(i) ) * ( w1(k, j) - meu_1(j) )
      endfor; ## j:= d:= #_of_features
    endfor; ## i:= d:= #_of_features
  endfor; ## k:= training samples
  covariance_matrix = covariance_matrix / num_of_training_samples;
endfunction
