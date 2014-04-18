function data = getWorkingDataGroup( C1, local, group, scale, nYears, season)
%%%get the season from years and dif locs
%%this function can be considerd a generlization of
%%getWorkinggDataCurrentFirst
locs            = [local group]; %local data go first
nLocs          = length( locs);
data            = cell( 1, nYears* nLocs); 

for iLoc =1: nLocs %each location
    data1 = getWorkingDataCurrentFirst( C1{ locs(iLoc)}(: ,3) /scale, ...
                nYears, season);
    data(1+ (iLoc-1)* nYears: iLoc* nYears) = data1;
end