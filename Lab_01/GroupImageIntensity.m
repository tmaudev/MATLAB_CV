group = imread('group.jpg');
group = rgb2gray(group);
fprintf('\n');

[B, I, J] = findMinIndex(group);
fprintf('Minimum Value is: %d\n', B);
fprintf('Index of Min (row, col) at: (%d, %d)\n\n', I, J);

[B, I, J] = findMaxIndex(group);
fprintf('Maximum Value is: %d\n', B);
fprintf('Index of Max (row, col) at: (%d, %d)\n\n', I, J);

[s1, s2] = size(group);
fprintf('Image Size: %d x %d\n\n', s1, s2);