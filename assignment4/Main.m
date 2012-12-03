cleandata = load('cleandata_students.mat');

cbr = CBRInit(cleandata.x, cleandata.y);
save('cbr.mat', 'cbr');

CrossValidate(cleandata.x, cleandata.y);
