cleandata = load('noisydata_students.mat');

cbr = CBRInit(cleandata.x, cleandata.y);

CrossValidate(cleandata.x, cleandata.y);

%retrieve(cbr, MakeCase([1 2 3], 2))
