function weight = strucwght(alldata)
%estimates structure weight before glueing

a = alldata{1,1};%pulls the specific weights and the volumes for each component from the overall excel matrix

specwght = a(:,6);%pulls the specig=fic weights from the a matrix in lb/in
vol = a(:,7);%pulls the volume from the a matrix in in^3
weight = 0;

for i = 1:length(specwght)
    
    weight(1,1) = weight(1,1) + (vol(i)/(12^3))*specwght(i);%calculates overall weight for teh structure
    weight(1,i) = (vol(i)/(12^3))*specwght(i);%calculates weight of individual pieces
    
end

end
%closes #3