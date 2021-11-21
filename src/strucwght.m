function weight = strucwght(alldata)
%estimates structure weight before glue

a = alldata{1,1};%pulls the needed data matrix out of the alldata matrix

specwght = a(:,6);%stores all of the specwght values from the a matrix
vol = a(:,7);%stores the values of volume for each element
weight(1,1) = 0;
for i = 1:length(specwght)%calculates the total weight and the weight of each component
    if ~isnan(vol(i,1)) && ~isnan(specwght(i,1)) 
        weight(1,1) = weight(1,1) + (vol(i,1)/1728)*specwght(i,1);%calculates total weight
    
        weight(i,1) = (vol(i,1)/1728)*specwght(i,1);%calculates weight of individual pieces
    end
end
end