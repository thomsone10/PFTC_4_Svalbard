%This code averages the three independant spectra reading per turf to form one spectrum per
%turf according to their spectra code. It also generates a matching list of spectra
%codes. 


%files required:
%Allcorrectedspectra
%Allspectracodesforaveragingoneperturf 

clear 
load ('C:\Users\kebl3987.new12\Downloads\Svalbard_processing.mat');

i=1;
[Allspectracodesoneperturf b c] =unique(Allspectracodesforaveragingoneperturf(:,1), 'stable');

for i = 1:length(Allcorrectedspectra);
matrix3=Allcorrectedspectra(:,i:i);
Allspectraoneperturf(:,i)=splitapply( @mean,  matrix3, c);
i=i+1;

end


%This code averages the turf traits to give one trait value per turf and generates a matching list of turf codes

%Files required:
%Turfcodes_uptodate
%Svalbard_waterturfmatched
%Svalbard_nitzturfmatched
%Svalbard_phosturfmatched
%Svalbard_CNturfmatched

codes=Turfcodesuptodate;

[Turfcodes b c] =unique(codes(:,1), 'stable');
Turfwateraveraged=splitapply( @nanmean,  Svalbardwaterturfmatched, c);

[Turfcodes b c] =unique(codes(:,1), 'stable');
Turfnitzaveraged=splitapply( @nanmean,  Svalbardnitzturfmatched, c);

[Turfcodes b c] =unique(codes(:,1), 'stable');
Turfphosaveraged=splitapply( @nanmean,  Svalbardphosturfmatched, c);

[Turfcodes b c] =unique(codes(:,1), 'stable');
TurfCNaveraged=splitapply( @nanmean,  SvalbardCNturfmatched, c);

%This code matches the averaged turf values with its corosponding turf spectra 

str = Turfcodes;
expression = '-';
replace = '_';
Turfcodes = regexprep(str,expression,replace);

%Turfcodes manually edited to match spectra codes. Resaved as
%'Allturfcodesoneperturf'. 

x=["H_SAL_03"];
Turfcodes = vertcat((Allturfcodesoneperturf(1:6)), x, (Allturfcodesoneperturf(7:end)));

for i = 1:length(Allspectracodesoneperturf);
    iz = find(strcmpi(Allspectracodesoneperturf(i), Turfcodes)==1);
    
    if isempty(iz)~=1
        Svalbardwatermatched(i) = Turfwateraveraged(iz(1));
        
    end
    
    
end

Svalbardwatermatched=Svalbardwatermatched';

Turfcodes = vertcat((Allturfcodesoneperturf(1:6)), x, (Allturfcodesoneperturf(7:end)));

for i = 1:length(Allspectracodesoneperturf)
    iz = find(strcmpi(Allspectracodesoneperturf(i), Turfcodes)==1);
    
    if isempty(iz)~=1
        Svalbardnitzmatched(i) = Turfnitzaveraged(iz(1));
        
    end
    
    
end

Svalbardnitzmatched=Svalbardnitzmatched';


for i = 1:length(Allspectracodesoneperturf)
    iz = find(strcmpi(Allspectracodesoneperturf(i), Turfcodes)==1);
    
    if isempty(iz)~=1
        Svalbardphosmatched(i) = Turfphosaveraged(iz(1));
        
    end
    
    
end

Svalbardphosmatched=Svalbardphosmatched';


for i = 1:length(Allspectracodesoneperturf)
    iz = find(strcmpi(Allspectracodesoneperturf(i), Turfcodes)==1);
    
    if isempty(iz)~=1
        SvalbardCNmatched(i) = TurfCNaveraged(iz(1));
        
    end
    
    
end

SvalbardCNmatched=SvalbardCNmatched';

Svalbardwatermatched(Svalbardwatermatched==0) = NaN;
Svalbardnitzmatched(Svalbardnitzmatched==0) = NaN;
Svalbardphosmatched(Svalbardphosmatched==0) = NaN;
SvalbardCNmatched(SvalbardCNmatched==0) = NaN;

csvwrite('Svalbard_watermatched.csv', Svalbardwatermatched)
csvwrite('Svalbard_nitzmatched.csv', Svalbardnitzmatched)
csvwrite('Svalbard_phosmatched.csv', Svalbardphosmatched)
csvwrite('Svalbard_CNmatched.csv', SvalbardCNmatched)



csvwrite('Allspectra_oneperturf.csv', Allspectraoneperturf)
xlswrite('Allspectracodes_oneperturf.xlsx', Allspectracodesoneperturf)
xlswrite('Turfcodes.xlsx', Turfcodes)










