%This code averages the three repeat spectra readings according to their spec code 

clear 
load ('C:\Users\kebl3987.new12\Downloads\Svalbard_processing.mat');
%files required:
%Allcorrectedspectra
%Allspectracodesforaveraging5perturf


i=1;
[Allspectracodes5perturf b c] =unique(Allspectracodesforaveraging5perturf(:,1), 'stable');

for i = 1:length(Allcorrectedspectra);
matrix3=Allcorrectedspectra(:,i:i);
Allspectra5perturf(:,i)=splitapply( @mean,  matrix3, c);
i=i+1;

end


csvwrite('Allspectra_5perturf.csv', Allspectra5perturf)
xlswrite('Allspectracodes_5perturf.xlsx', Allspectracodes5perturf)
