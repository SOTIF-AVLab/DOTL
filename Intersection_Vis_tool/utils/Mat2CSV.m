data = load('..\Data\8_02_1\8_2_1.mat');
dimension = size(data.simout);
num = dimension(2);
for i = 1 : num
    filename = ['..\Data\8_02_1\8_2_1_', int2str(i), '.csv'];
    matfile = data.simout(i).result.data;
    writematrix(matfile, filename)
end
