## @author Mustafa Qamar-ud-Din <mustafa.mahrous.89@gmail.com>
## @date Jan 19th, 2016

## Constants
  num_of_samples_per_class = 50;
  num_of_training_samples = 5;
  num_of_testing_samples = 45;
  
  d = 4; ## number of features
  c = 3; ## number of classes
  n = num_of_training_samples * c; ## number of patterns nodes = number of training samples per class * number of classes
  
## Matrices
  w = zeros(n, d); ## weights between input layer and patterns layer
  a = zeros(n, c); ## connections between patterns layer and output categories layer
  net_k = zeros(n, 1); ## inner product of test sample x and weights matrix w w'x
  output = vec(zeros(c, 1)); ## discriminant function calculated at each output node

## Read Iris dataset
  ## read file into four columns to escape text`
  [x_1, x_2, x_3, x_4] = textread("Iris Data.txt", "%f %f %f %f %*s", "delimiter", ",");
  ## merge the columns into 150x4 Matrix
  Iris_Dataset = [x_1 x_2 x_3 x_4];
  
## Distill training set
  ## separate each class into 20x4 Matrix for Training
  ## use constants for generic coding
  w1 = Iris_Dataset(1:num_of_training_samples, :);
  from = (1+num_of_samples_per_class);
  to = from + num_of_training_samples - 1;
  w2 = Iris_Dataset(from:to, :);
  from = (1 + num_of_samples_per_class * 2);
  to = from + num_of_training_samples - 1;
  w3 = Iris_Dataset(from:to, :);
  training_set = [w1; w2; w3]
  
##### PNN Training #####
## construct weights matrix [ n x d ]
## fully connected matrix

    ## calculate normalization factor for each row in training set 
    ## Sqrt(Summation(x[j][i]^2)) i = 1 to d, j = 1 to n
    norms = ones(n, 1);
    for j = 1 : n
      norms(j, 1) = sqrt(sum(power(training_set(j, :),2)));
    endfor;

    for j = 1 : n
      for k = 1 : d
        Xjk = training_set(j,k) / norms(j, 1); ## normalize
        w(j,k) = Xjk; ## train
      endfor;
      ## construct patterns matrix [ n x c ] 
      ## a[j][i] = 1 iff pattern node j belongs to class i
      ## sparse matrix
      ## partitions training set to c segmens 
      ## to help build the connections 
      ## from patterns to categories
      category_index = floor((j-1) / num_of_training_samples) + 1
      a(j, category_index) = 1
    endfor;
disp(w)
##### Testing #####

  ## extract testing set Matrix 30 x 4
  ## use constants for generic coding
  w1 = Iris_Dataset(num_of_training_samples+1:num_of_samples_per_class, :); ## (21:50, :)
  from = (1+num_of_samples_per_class+num_of_training_samples); ## 71
  to = from + num_of_testing_samples - 1; ## 100
  w2 = Iris_Dataset(from:to, :);
  from = (1+2*num_of_samples_per_class+num_of_training_samples); ## 121
  to = from + num_of_testing_samples - 1; ## 150
  w3 = Iris_Dataset(from:to, :);

## calculate net_k for each pattern from j = 1 ... n
  transpose(w1(j,:))
  for j = 1 : n
    net_k(j, 1) = w(j,:)*transpose(w1(j,:))
  endfor;
## calculate non-linear out for each pattern from j = 1 ... n
## output vector [c x 1]
## sums all nonlinear outputs from patterns layer
## classify by assigning class to the category node with max value