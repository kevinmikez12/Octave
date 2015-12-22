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
## @deftypefn {Function File} {@var{retval} =} Calculate_Linear_Discriminant_Function (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Qamar-ud-Din <qamar-ud-din@qamaruddin-Vostro-1540>
## Created: 2015-12-22
  
function [confusion_matrix] = Calculate_Linear_Discriminant_Function (confusion_matrix, class_state_of_nature, label, W_1, W_2, W_3, w_1, w_2, w_3, omega_0_1, omega_0_2, omega_0_3)
  for i = 1:rows(class_state_of_nature);
      x = vec(class_state_of_nature(i,:));

      g_1 = transpose(x) * W_1 * x + transpose(w_1) * x + omega_0_1;
      g_2 = transpose(x) * W_2 * x + transpose(w_2) * x + omega_0_2;
      g_3 = transpose(x) * W_3 * x + transpose(w_3) * x + omega_0_3;
      
      if(g_1 > g_2 && g_1 > g_3)
        confusion_matrix(1, label) = confusion_matrix(1, label) + 1;
      elseif(g_2 > g_3)
        confusion_matrix(2, label) = confusion_matrix(2, label) + 1;
      else
        confusion_matrix(3, label) = confusion_matrix(3, label) + 1;
      endif;
  endfor; ## rows i
endfunction
