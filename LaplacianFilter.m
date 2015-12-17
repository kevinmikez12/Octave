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
## @deftypefn {Function File} {@var{retval} =} LaplacianFilter (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Qamar-ud-Din <qamar-ud-din@qamaruddin-Vostro-1540>
## Created: 2015-12-18

function [output_image] = LaplacianFilter (image_path)
  input_image = imread("Mona-Lisa.jpg");
  laplacian_mask = fspecial("laplacian", 0.2);
  edges = imfilter(input_image, laplacian_mask);
  output_image = input_image + edges;
  
  figure, imshow(input_image), title('Source');
  figure, imshow(edges), title('Edges');
  figure, imshow(output_image), title('Sharpened');
endfunction
