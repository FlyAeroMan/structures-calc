function W = strucwght(alldata)
%estimates structure weight before glueing

a = alldata{1,1};

specwght = a(:,6);
vol = a(:,7);
W = 0;

for i = 1:length(specwght)
    
    W = W + (vol(i)/(12^3))*specwght(i);
    
end

end