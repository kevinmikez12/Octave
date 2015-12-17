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
## @deftypefn {Function File} {@var{retval} =} UnsharpMasking (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Qamar-ud-Din <qamar-ud-din@qamaruddin-Vostro-1540>
## Created: 2015-12-17

function [out_image] = UnsharpMasking (image_path, weight_k)
  input_image = imread(image_path);
  
  blured_image = GaussianFilter(image_path, 5, 3);
  unsharp_mask = input_image - blured_image;
  out_image = input_image + weight_k * unsharp_mask;
  
  figure, imshow(unsharp_mask), title('Unsharp Mask');
  figure, imshow(out_image), title('Result');
  
endfunction
