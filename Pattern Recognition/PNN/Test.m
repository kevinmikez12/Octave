## Copyright (C) 2016 Qamar-ud-Din
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
## @deftypefn {Function File} {@var{retval} =} Test (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Qamar-ud-Din <qamar-ud-din@qamaruddin-Vostro-1540>
## Created: 2016-01-22

function [confusion_matrix] = Test (confusion_matrix, test_matrix, num_patterns, weights, num_classes, a, net_k, variance, true_class)
  for m = 1 : size(test_matrix, 1) %% loop all test cases
      output = zeros(num_classes, 1); ## discriminant function calculated at each output node
      x = transpose(test_matrix(m,:));
      for j = 1 : num_patterns %% loop all patterns nodes
        net_k(j, 1) = weights(j,:)*x; %% calculate net activation
        for i = 1 : num_classes %% loop all classes
          if a(j, i) == 1 %% if pattern node is connected to category node
            output(i, 1) = output(i, 1) + exp( (net_k(j, 1) - 1) / variance);
          endif;
        endfor; %% i
      endfor; %% j

      %% assign test sample to category of max output
      max_val = -1;
      class = -1;
      for i = 1 : num_classes %% loop all category nodes
        if output(i, 1) > max_val
          class = i;
          max_val = output(i, 1);
        endif;
      endfor; %% i
      
      confusion_matrix(class, true_class) = confusion_matrix(class, true_class) + 1;
  endfor; %% m
endfunction
