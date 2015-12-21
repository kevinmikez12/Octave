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
## @deftypefn {Function File} {@var{retval} =} Estimate_Covariance_with_MLE (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Qamar-ud-Din <qamar-ud-din@qamaruddin-Vostro-1540>
## Created: 2015-12-21

function [covariance_matrix] = Estimate_Covariance_with_MLE (training_set, meu, num_of_features, num_of_training_samples)
  ## estimate covariance matrix
  covariance_matrix = zeros(num_of_features, num_of_features);
  for k = 1:num_of_training_samples
    for i = 1:num_of_features
      for j = 1:num_of_features
        covariance_matrix(i, j) += ( training_set(k, i) - meu(i) ) * ( training_set(k, j) - meu(j) )
      endfor; ## j:= d:= #_of_features
    endfor; ## i:= d:= #_of_features
  endfor; ## k:= training samples
  covariance_matrix = covariance_matrix / num_of_training_samples;
endfunction
