tic;

%read in data and create vectors
%Sex - M/F
%Event - SBD/BD/D/B
%Equipment - Raw/Wraps/Single-ply/Multi-ply
%Division -Open/Masters 1/Masters 2/Masters 3/Juniors/ (too many
%distinctions after that)

%M = readtable('openpowerlifting5_1_2019.csv');

sexchoice='female';
equipchoice='Raw';
eventchoice='SBD';
divischoice='Open';


toc;
tic;

%Separate by equipment, sex, weight class, etc...

equip = table2array(M(:,4));
equipnum=sum(count(equip,equipchoice));

event=table2array(M(:,3));

divis = table2array(M(:,7));
sex = table2array(M(:,2));

age=table2array(M(:,5));
age_equip=zeros(equipnum,1);

bodyweight=table2array(M(:,8));
bodyweight_equip=zeros(equipnum,1);


% As we read in lifts, convert misses (logged as "-###") into NaN's
% Also, initialize some variables here!

squat1=table2array(M(:,10));
squat2=table2array(M(:,11));
squat3=table2array(M(:,12));
bestsquat=table2array(M(:,14));

bestsquat_equip=zeros(equipnum,1);
squat1_equip=zeros(equipnum,1);
squat2_equip=zeros(equipnum,1);
squat3_equip=zeros(equipnum,1);

bench1=table2array(M(:,15));
bench2=table2array(M(:,16));
bench3=table2array(M(:,17));
bestbench=table2array(M(:,19));

bestbench_equip=zeros(equipnum,1);
bench1_equip=zeros(equipnum,1);
bench2_equip=zeros(equipnum,1);
bench3_equip=zeros(equipnum,1);

dead1=table2array(M(:,20));
dead2=table2array(M(:,21));
dead3=table2array(M(:,22));
bestdead=table2array(M(:,24));

bestdead_equip=zeros(equipnum,1);
dead1_equip=zeros(equipnum,1);
dead2_equip=zeros(equipnum,1);
dead3_equip=zeros(equipnum,1);

total=table2array(M(:,25));
total_equip=zeros(equipnum,1);

wilks=table2array(M(:,27));
wilks_equip=zeros(equipnum,1);

%Now, specify equipment (raw, wraps, single-ply, multi-ply)

a=0;

for i=1:numel(equip)
    if strcmp(equip(i),equipchoice)
        a=a+1;
        age_equip(a)=age(i);
        total_equip(a)=total(i);
        sex_equip(a)=sex(i);
        divis_equip(a)=divis(i);
        event_equip(a)=event(i);
        bodyweight_equip(a)=bodyweight(i);
        bestsquat_equip(a)=bestsquat(i);
        squat1_equip(a)=squat1(i);
        squat2_equip(a)=squat2(i);
        squat3_equip(a)=squat3(i);
        bestbench_equip(a)=bestbench(i);
        bench1_equip(a)=bench1(i);
        bench2_equip(a)=bench2(i);
        bench3_equip(a)=bench3(i);
        bestdead_equip(a)=bestdead(i);
        dead1_equip(a)=dead1(i);
        dead2_equip(a)=dead2(i);
        dead3_equip(a)=dead3(i);
        wilks_equip(a)=wilks(i);
    end
end

% free up memory after using each variable!

clear age equip event divis bodyweight sex squat1 ...
    squat2 squat3 bestsquat bench1 bench2 bench3 bestbench ...
    dead1 dead2 dead3 bestdead total wilks;

%Next, filter out any non-SBD lifters (bc they skew the totals!)

eventsum=sum(count(event_equip,eventchoice));

total_SBD=zeros(eventsum,1);
bodyweight_SBD=zeros(eventsum,1);
bestsquat_SBD=zeros(eventsum,1);
squat1_SBD=zeros(eventsum,1);
squat2_SBD=zeros(eventsum,1);
squat3_SBD=zeros(eventsum,1);
bestbench_SBD=zeros(eventsum,1);
bench1_SBD=zeros(eventsum,1);
bench2_SBD=zeros(eventsum,1);
bench3_SBD=zeros(eventsum,1);
bestdead_SBD=zeros(eventsum,1);
dead1_SBD=zeros(eventsum,1);
dead2_SBD=zeros(eventsum,1);
dead3_SBD=zeros(eventsum,1);
wilks_SBD=zeros(eventsum,1);
age_SBD=zeros(eventsum,1);

a=0;
for i=1:numel(event_equip)
    if strcmp(event_equip(i),eventchoice)
        a=a+1;
        age_SBD(a)=age_equip(i);
        total_SBD(a)=total_equip(i);
        divis_SBD(a)=divis_equip(i);
        sex_SBD(a)=sex_equip(i);
        bodyweight_SBD(a)=bodyweight_equip(i);
        bestsquat_SBD(a)=bestsquat_equip(i);
        squat1_SBD(a)=squat1_equip(i);
        squat2_SBD(a)=squat2_equip(i);
        squat3_SBD(a)=squat3_equip(i);
        bestbench_SBD(a)=bestbench_equip(i);
        bench1_SBD(a)=bench1_equip(i);
        bench2_SBD(a)=bench2_equip(i);
        bench3_SBD(a)=bench3_equip(i);
        bestdead_SBD(a)=bestdead_equip(i);
        dead1_SBD(a)=dead1_equip(i);
        dead2_SBD(a)=dead2_equip(i);
        dead3_SBD(a)=dead3_equip(i);
        wilks_SBD(a)=wilks_equip(i);
    end
end

clear age_equip divis_equip sex_equip bodyweight_equip squat1_equip ...
    squat2_equip squat3_equip bestsquat_equip bench1_equip ... 
    bench2_equip bench3_equip bestbench_equip dead1_equip ...
    dead2_equip dead3_equip bestdead_equip total_equip wilks_equip;

%Now, select only lifters competing in "Open"

divisnum=sum(count(divis_SBD,divischoice));

%preallocate:

total_open=zeros(divisnum,1);
bodyweight_open=zeros(divisnum,1);
bestsquat_open=zeros(divisnum,1);
squat1_open=zeros(divisnum,1);
squat2_open=zeros(divisnum,1);
squat3_open=zeros(divisnum,1);
bestbench_open=zeros(divisnum,1);
bench1_open=zeros(divisnum,1);
bench2_open=zeros(divisnum,1);
bench3_open=zeros(divisnum,1);
bestdead_open=zeros(divisnum,1);
dead1_open=zeros(divisnum,1);
dead2_open=zeros(divisnum,1);
dead3_open=zeros(divisnum,1);
wilks_open=zeros(divisnum,1);
age_open=zeros(divisnum,1);

a=0;
for i=1:numel(divis_SBD)
    if strcmp(divis_SBD(i),divischoice)
        a=a+1;
        age_open(a)=age_SBD(i);
        total_open(a)=total_SBD(i);
        sex_open(a)=sex_SBD(i);
        bodyweight_open(a)=bodyweight_SBD(i);
        bestsquat_open(a)=bestsquat_SBD(i);
        squat1_open(a)=squat1_SBD(i);
        squat2_open(a)=squat2_SBD(i);
        squat3_open(a)=squat3_SBD(i);
        bestbench_open(a)=bestbench_SBD(i);
        bench1_open(a)=bench1_SBD(i);
        bench2_open(a)=bench2_SBD(i);
        bench3_open(a)=bench3_SBD(i);
        bestdead_open(a)=bestdead_SBD(i);
        dead1_open(a)=dead1_SBD(i);
        dead2_open(a)=dead2_SBD(i);
        dead3_open(a)=dead3_SBD(i);
        wilks_open(a)=wilks_SBD(i);
    end
end

clear age_SBD divis_SBD sex_SBD bodyweight_SBD squat1_SBD ...
    squat2_SBD squat3_SBD bestsquat_SBD bench1_SBD bench2_SBD bench3_SBD bestbench_SBD ...
    dead1_SBD dead2_SBD dead3_SBD bestdead_SBD total_SBD wilks_SBD;

% Make vectors for men and women

men = sum(count(sex_open,'M'));
women = sum(count(sex_open,'F'));

%preallocate all the vectors (weight, best SBD, total, wilks)

bw_male=zeros(men,1);
age_male=zeros(men,1);
bw_female=zeros(women,1);
age_female=zeros(women,1);

s_male=zeros(men,1);
s1_male=zeros(men,1);
s2_male=zeros(men,1);
s3_male=zeros(men,1);
s_female=zeros(women,1);
s1_female=zeros(women,1);
s2_female=zeros(women,1);
s3_female=zeros(women,1);

b_male=zeros(men,1);
b1_male=zeros(men,1);
b2_male=zeros(men,1);
b3_male=zeros(men,1);
b_female=zeros(women,1);
b1_female=zeros(women,1);
b2_female=zeros(women,1);
b3_female=zeros(women,1);

d_male=zeros(men,1);
d1_male=zeros(men,1);
d2_male=zeros(men,1);
d3_male=zeros(men,1);
d_female=zeros(women,1);
d1_female=zeros(women,1);
d2_female=zeros(women,1);
d3_female=zeros(women,1);

total_male=zeros(men,1);
total_female=zeros(women,1);

wilks_male=zeros(men,1);
wilks_female=zeros(women,1);

j=0;
k=0;

for i=1:numel(sex_open)
    if strcmp(sex_open(i),'M')
        j=j+1;
        age_male(j)=age_open(i);
        total_male(j)=total_open(i);
        bw_male(j)=bodyweight_open(i);
        s_male(j)=bestsquat_open(i);
        s1_male(j)=squat1_open(i);
        s2_male(j)=squat2_open(i);
        s3_male(j)=squat3_open(i);
        b_male(j)=bestbench_open(i);
        b1_male(j)=bench1_open(i);
        b2_male(j)=bench2_open(i);
        b3_male(j)=bench3_open(i);
        d_male(j)=bestdead_open(i);
        d1_male(j)=dead1_open(i);
        d2_male(j)=dead2_open(i);
        d3_male(j)=dead3_open(i);
        wilks_male(j)=wilks_open(i);
    else
        k=k+1;
        age_female(k)=age_open(i);
        total_female(k)=total_open(i);
        bw_female(k)=bodyweight_open(i);
        s_female(k)=bestsquat_open(i);
        s1_female(k)=squat1_open(i);
        s2_female(k)=squat2_open(i);
        s3_female(k)=squat3_open(i);
        b_female(k)=bestbench_open(i);
        b1_female(k)=bench1_open(i);
        b2_female(k)=bench2_open(i);
        b3_female(k)=bench3_open(i);
        d_female(k)=bestdead_open(i);
        d1_female(k)=dead1_open(i);
        d2_female(k)=dead2_open(i);
        d3_female(k)=dead3_open(i);
        wilks_female(k)=wilks_open(i);
    end
end

clear age_open sex_open bodyweight_open squat1_open ...
    squat2_open squat3_open bestsquat_open bench1_open bench2_open bench3_open bestbench_open ...
    dead1_open dead2_open dead3_open bestdead_open total_open wilks_open;

% pick out weightclass of interest (Men: ---, Women: ---)

a=0;
b=0;
c=0;
d=0;
e=0;
f=0;
g=0;
h=0;

%First, the dudes (ugh, classic hegemony...):

if strcmp(sexchoice,'male')==1
for i=1:numel(bw_male)
    if bw_male(i)>83 && bw_male(i)<=93
        a=a+1;
        age_93(a)=age_male(i);
        total_93(a)=total_male(i);
        bw_93(a)=bw_male(i);
        s_93(a)=s_male(i);
        s1_93(a)=s1_male(i);
        s2_93(a)=s2_male(i);
        s3_93(a)=s3_male(i);
        b_93(a)=b_male(i);
        b1_93(a)=b1_male(i);
        b2_93(a)=b2_male(i);
        b3_93(a)=b3_male(i);
        d_93(a)=d_male(i);
        d1_93(a)=d1_male(i);
        d2_93(a)=d2_male(i);
        d3_93(a)=d3_male(i);
        wilks_93(a)=wilks_male(i);
    elseif bw_male(i)>74 && bw_male(i)<=83
        b=b+1;
        age_83(b)=age_male(i);
        total_83(b)=total_male(i);
        bw_83(b)=bw_male(i);
        s_83(b)=s_male(i);
        s1_83(b)=s1_male(i);
        s2_83(b)=s2_male(i);
        s3_83(b)=s3_male(i);
        b_83(b)=b_male(i);
        b1_83(b)=b1_male(i);
        b2_83(b)=b2_male(i);
        b3_83(b)=b3_male(i);
        d_83(b)=d_male(i);
        d1_83(b)=d1_male(i);
        d2_83(b)=d2_male(i);
        d3_83(b)=d3_male(i);
        wilks_83(b)=wilks_male(i);
    elseif bw_male(i)>66 && bw_male(i)<=74
        c=c+1;
        age_74(c)=age_male(i);
        total_74(c)=total_male(i);
        bw_74(c)=bw_male(i);
        s_74(c)=s_male(i);
        s1_74(c)=s1_male(i);
        s2_74(c)=s2_male(i);
        s3_74(c)=s3_male(i);
        b_74(c)=b_male(i);
        b1_74(c)=b1_male(i);
        b2_74(c)=b2_male(i);
        b3_74(c)=b3_male(i);
        d_74(c)=d_male(i);
        d1_74(c)=d1_male(i);
        d2_74(c)=d2_male(i);
        d3_74(c)=d3_male(i);
        wilks_74(c)=wilks_male(i);
    elseif bw_male(i)>59 && bw_male(i)<=66
        d=d+1;
        age_66(d)=age_male(i);
        total_66(d)=total_male(i);
        bw_66(d)=bw_male(i);
        s_66(d)=s_male(i);
        s1_66(d)=s1_male(i);
        s2_66(d)=s2_male(i);
        s3_66(d)=s3_male(i);
        b_66(d)=b_male(i);
        b1_66(d)=b1_male(i);
        b2_66(d)=b2_male(i);
        b3_66(d)=b3_male(i);
        d_66(d)=d_male(i);
        d1_66(d)=d1_male(i);
        d2_66(d)=d2_male(i);
        d3_66(d)=d3_male(i);
        wilks_66(d)=wilks_male(i);
    elseif bw_male(i)<=59
        e=e+1;
        age_59(e)=age_male(i);
        total_59(e)=total_male(i);
        bw_59(e)=bw_male(i);
        s_59(e)=s_male(i);
        s1_59(e)=s1_male(i);
        s2_59(e)=s2_male(i);
        s3_59(e)=s3_male(i);
        b_59(e)=b_male(i);
        b1_59(e)=b1_male(i);
        b2_59(e)=b2_male(i);
        b3_59(e)=b3_male(i);
        d_59(e)=d_male(i);
        d1_59(e)=d1_male(i);
        d2_59(e)=d2_male(i);
        d3_59(e)=d3_male(i);
        wilks_59(e)=wilks_male(i);
    elseif bw_male(i)>93 && bw_male(i)<=105
        f=f+1;
        age_105(f)=age_male(i);
        total_105(f)=total_male(i);
        bw_105(f)=bw_male(i);
        s_105(f)=s_male(i);
        s1_105(f)=s1_male(i);
        s2_105(f)=s2_male(i);
        s3_105(f)=s3_male(i);
        b_105(f)=b_male(i);
        b1_105(f)=b1_male(i);
        b2_105(f)=b2_male(i);
        b3_105(f)=b3_male(i);
        d_105(f)=d_male(i);
        d1_105(f)=d1_male(i);
        d2_105(f)=d2_male(i);
        d3_105(f)=d3_male(i);
        wilks_105(f)=wilks_male(i);
    elseif bw_male(i)>105 && bw_male(i)<=120
        g=g+1;
        age_120(g)=age_male(i);
        total_120(g)=total_male(i);
        bw_120(g)=bw_male(i);
        s_120(g)=s_male(i);
        s1_120(g)=s1_male(i);
        s2_120(g)=s2_male(i);
        s3_120(g)=s3_male(i);
        b_120(g)=b_male(i);
        b1_120(g)=b1_male(i);
        b2_120(g)=b2_male(i);
        b3_120(g)=b3_male(i);
        d_120(g)=d_male(i);
        d1_120(g)=d1_male(i);
        d2_120(g)=d2_male(i);
        d3_120(g)=d3_male(i);
        wilks_120(g)=wilks_male(i);
    elseif bw_male(i)>120
        h=h+1;
        age_shw(h)=age_male(i);
        total_shw(h)=total_male(i);
        bw_shw(h)=bw_male(i);
        s_shw(h)=s_male(i);
        s1_shw(h)=s1_male(i);
        s2_shw(h)=s2_male(i);
        s3_shw(h)=s3_male(i);
        b_shw(h)=b_male(i);
        b1_shw(h)=b1_male(i);
        b2_shw(h)=b2_male(i);
        b3_shw(h)=b3_male(i);
        d_shw(h)=d_male(i);
        d1_shw(h)=d1_male(i);
        d2_shw(h)=d2_male(i);
        d3_shw(h)=d3_male(i);
        wilks_shw(h)=wilks_male(i);
    end
end

clear a b c d e f g h men women j k;

% Now, incorporate a clustering algorithm to determine ideal cutoffs for
% lifter classifications for this weight class!

km=7;

bwVtot59=[bw_59;total_59];
bwVtot59=bwVtot59';
idx59 = kmeans(bwVtot59,km);

bwVtot66=[bw_66;total_66];
bwVtot66=bwVtot66';
idx66 = kmeans(bwVtot66,km);

bwVtot74=[bw_74;total_74];
bwVtot74=bwVtot74';
idx74 = kmeans(bwVtot74,km);

bwVtot83=[bw_83;total_83];
bwVtot83=bwVtot83';
idx83 = kmeans(bwVtot83,km);

bwVtot93=[bw_93;total_93];
bwVtot93=bwVtot93';
idx93 = kmeans(bwVtot93,km);

bwVtot105=[bw_105;total_105];
bwVtot105=bwVtot105';
idx105 = kmeans(bwVtot105,km);

bwVtot120=[bw_120;total_120];
bwVtot120=bwVtot120';
idx120 = kmeans(bwVtot120,km);

bwVtotshw=[bw_shw;total_shw];
bwVtotshw=bwVtotshw';
idxshw = kmeans(bwVtotshw,km);

%Create matrices that can be plugged into ML apps:

mat59=[age_59; bw_59; s1_59; s2_59; s3_59; s_59; b1_59; b2_59; b3_59; b_59; d1_59; d2_59; d3_59; d_59; total_59; wilks_59; idx59'];
mat66=[age_66; bw_66; s1_66; s2_66; s3_66; s_66; b1_66; b2_66; b3_66; b_66; d1_66; d2_66; d3_66; d_66; total_66; wilks_66; idx66'];
mat74=[age_74; bw_74; s1_74; s2_74; s3_74; s_74; b1_74; b2_74; b3_74; b_74; d1_74; d2_74; d3_74; d_74; total_74; wilks_74; idx74'];
mat83=[age_83; bw_83; s1_83; s2_83; s3_83; s_83; b1_83; b2_83; b3_83; b_83; d1_83; d2_83; d3_83; d_83; total_83; wilks_83; idx83'];
mat93=[age_93; bw_93; s1_93; s2_93; s3_93; s_93; b1_93; b2_93; b3_93; b_93; d1_93; d2_93; d3_93; d_93; total_93; wilks_93; idx93'];
mat105=[age_105; bw_105; s1_105; s2_105; s3_105; s_105; b1_105; b2_105; b3_105; b_105; d1_105; d2_105; d3_105; d_105; total_105; wilks_105; idx105'];
mat120=[age_120; bw_120; s1_120; s2_120; s3_120; s_120; b1_120; b2_120; b3_120; b_120; d1_120; d2_120; d3_120; d_120; total_120; wilks_120; idx120'];
matshw=[age_shw; bw_shw; s1_shw; s2_shw; s3_shw; s_shw; b1_shw; b2_shw; b3_shw; b_shw; d1_shw; d2_shw; d3_shw; d_shw; total_shw; wilks_shw; idxshw'];

zer=zeros(1,km);
clus59=zer;
clus66=zer;
clus74=zer;
clus83=zer;
clus93=zer;
clus105=zer;
clus120=zer;
clusshw=zer;

for i=1:km
clus59(i)=sum(mat59(17,:)==i);
clus66(i)=sum(mat66(17,:)==i);
clus74(i)=sum(mat74(17,:)==i);
clus83(i)=sum(mat83(17,:)==i);
clus93(i)=sum(mat93(17,:)==i);
clus105(i)=sum(mat105(17,:)==i);
clus120(i)=sum(mat120(17,:)==i);
clusshw(i)=sum(matshw(17,:)==i);
end

figure('units','normalized','outerposition',[0 0 1 1]);
subplot(2,4,1)
gscatter(bw_59,total_59,idx59);
title('Male 59 kg Lifters');
xlabel('Bodyweight (kg)');
ylabel('SBD Total (kg)');
legend(num2str(clus59(1)),num2str(clus59(2)),num2str(clus59(3)),...
    num2str(clus59(4)),num2str(clus59(5)),num2str(clus59(6)),num2str(clus59(7)));

subplot(2,4,2)
gscatter(bw_66,total_66,idx66);
title('Male 66 kg Lifters');
xlabel('Bodyweight (kg)');
ylabel('SBD Total (kg)');
legend(num2str(clus66(1)),num2str(clus66(2)),num2str(clus66(3)),...
    num2str(clus66(4)),num2str(clus66(5)),num2str(clus66(6)),num2str(clus66(7)));

subplot(2,4,3)
gscatter(bw_74,total_74,idx74);
title('Male 74 kg Lifters');
xlabel('Bodyweight (kg)');
ylabel('SBD Total (kg)');
legend(num2str(clus74(1)),num2str(clus74(2)),num2str(clus74(3)),...
    num2str(clus74(4)),num2str(clus74(5)),num2str(clus74(6)),num2str(clus74(7)));

subplot(2,4,4)
gscatter(bw_83,total_83,idx83);
title('Male 83 kg Lifters');
xlabel('Bodyweight (kg)');
ylabel('SBD Total (kg)');
legend(num2str(clus83(1)),num2str(clus83(2)),num2str(clus83(3)),...
    num2str(clus83(4)),num2str(clus83(5)),num2str(clus83(6)),num2str(clus83(7)));

subplot(2,4,5)
gscatter(bw_93,total_93,idx93);
title('Male 93 kg Lifters');
xlabel('Bodyweight (kg)');
ylabel('SBD Total (kg)');
legend(num2str(clus93(1)),num2str(clus93(2)),num2str(clus93(3)),...
    num2str(clus93(4)),num2str(clus93(5)),num2str(clus93(6)),num2str(clus93(7)));

subplot(2,4,6)
gscatter(bw_105,total_105,idx105);
title('Male 105 kg Lifters');
xlabel('Bodyweight (kg)');
ylabel('SBD Total (kg)');
legend(num2str(clus105(1)),num2str(clus105(2)),num2str(clus105(3)),...
    num2str(clus105(4)),num2str(clus105(5)),num2str(clus105(6)),num2str(clus105(7)));

subplot(2,4,7)
gscatter(bw_120,total_120,idx120);
title('Male 120 kg Lifters');
xlabel('Bodyweight (kg)');
ylabel('SBD Total (kg)');
legend(num2str(clus120(1)),num2str(clus120(2)),num2str(clus120(3)),...
    num2str(clus120(4)),num2str(clus120(5)),num2str(clus120(6)),num2str(clus120(7)));

subplot(2,4,8)
gscatter(bw_shw,total_shw,idxshw);
title('Male SHW Lifters');
xlabel('Bodyweight (kg)');
ylabel('SBD Total (kg)');
legend(num2str(clusshw(1)),num2str(clusshw(2)),num2str(clusshw(3)),...
    num2str(clusshw(4)),num2str(clusshw(5)),num2str(clusshw(6)),num2str(clusshw(7)));

clear age_female age_male b1_female b1_male b2_female b2_male b3_female b3_male...
    b_female b_male bw_female bw_male d1_female d1_male d2_female d2_male...
    d3_female d3_male d_female d_male s1_female s1_male s2_female s2_male s3_female s3_male...
    s_female s_male total_female total_male wilks_female wilks_male


clear age_59 age_66 age_74 age_83 age_93 age_105 age_120 age_shw...
    bw_59 bw_66 bw_74 bw_83 bw_93 bw_105 bw_120 bw_shw...
    s_59 s1_59 s2_59 s3_59 sj1_59 sj2_59...
    s_66 s1_66 s2_66 s3_66 sj1_66 sj2_66...
    s_74 s1_74 s2_74 s3_74 sj1_74 sj2_74...
    s_83 s1_83 s2_83 s3_83 sj1_83 sj2_83...
    s_93 s1_93 s2_93 s3_93 sj1_93 sj2_93...
    s_105 s1_105 s2_105 s3_105 sj1_105 sj2_105...
    s_120 s1_120 s2_120 s3_120 sj1_120 sj2_120...
    s_shw s1_shw s2_shw s3_shw sj1_shw sj2_shw...
    b_59 b1_59 b2_59 b3_59 bj1_59 bj2_59...
    b_66 b1_66 b2_66 b3_66 bj1_66 bj2_66...
    b_74 b1_74 b2_74 b3_74 bj1_74 bj2_74...
    b_83 b1_83 b2_83 b3_83 bj1_83 bj2_83...
    b_93 b1_93 b2_93 b3_93 bj1_93 bj2_93...
    b_105 b1_105 b2_105 b3_105 bj1_105 bj2_105...
    b_120 b1_120 b2_120 b3_120 bj1_120 bj2_120...
    b_shw b1_shw b2_shw b3_shw bj1_shw bj2_shw...
    d_59 d1_59 d2_59 d3_59 dj1_59 dj2_59...
    d_66 d1_66 d2_66 d3_66 dj1_66 dj2_66...
    d_74 d1_74 d2_74 d3_74 dj1_74 dj2_74...
    d_83 d1_83 d2_83 d3_83 dj1_83 dj2_83...
    d_93 d1_93 d2_93 d3_93 dj1_93 dj2_93...
    d_105 d1_105 d2_105 d3_105 dj1_105 dj2_105...
    d_120 d1_120 d2_120 d3_120 dj1_120 dj2_120...
    d_shw d1_shw d2_shw d3_shw dj1_shw dj2_shw...
    total_59 total_66 total_74 total_83 total_93 total_105 total_120 total_shw...
    wilks_59 wilks_66 wilks_74 wilks_83 wilks_93 wilks_105 wilks_120 wilks_shw...
    idx59 idx66 idx74 idx83 idx93 idx105 idx120 idxshw...
    bwVtot59 bwVtot66 bwVtot74 bwVtot83 bwVtot93 bwVtot105 bwVtot120 bwVtotshw zer;
  

%Now, let's learn some linear regressions for predicting best SBD based on
%first attempts

%First, make sure all attempt values in mat### are non-negative or NaN

mat59(mat59<0)=NaN;
mat66(mat66<0)=NaN;
mat74(mat74<0)=NaN;
mat83(mat83<0)=NaN;
mat93(mat93<0)=NaN;
mat105(mat105<0)=NaN;
mat120(mat120<0)=NaN;
matshw(matshw<0)=NaN;

%Make fits

n59=length(mat59(1,:));
n66=length(mat66(1,:));
n74=length(mat74(1,:));
n83=length(mat83(1,:));
n93=length(mat93(1,:));
n105=length(mat105(1,:));
n120=length(mat120(1,:));
nshw=length(matshw(1,:));

rng('default');

c59=cvpartition(n59,'HoldOut',0.3);
c66=cvpartition(n66,'HoldOut',0.3);
c74=cvpartition(n74,'HoldOut',0.3);
c83=cvpartition(n83,'HoldOut',0.3);
c93=cvpartition(n93,'HoldOut',0.3);
c105=cvpartition(n105,'HoldOut',0.3);
c120=cvpartition(n120,'HoldOut',0.3);
cshw=cvpartition(nshw,'HoldOut',0.3);

idxTrain59=training(c59,1);
idxTrain66=training(c66,1);
idxTrain74=training(c74,1);
idxTrain83=training(c83,1);
idxTrain93=training(c93,1);
idxTrain105=training(c105,1);
idxTrain120=training(c120,1);
idxTrainshw=training(cshw,1);

idxTest59=~idxTrain59;
idxTest66=~idxTrain66;
idxTest74=~idxTrain74;
idxTest83=~idxTrain83;
idxTest93=~idxTrain93;
idxTest105=~idxTrain105;
idxTest120=~idxTrain120;
idxTestshw=~idxTrainshw;

lam=10; %Ridge parameter - 0 corresponds to least squares

%Make appropriate vectors for fit - squat, bench, dead separate

xs59=mat59(3,:)';
ys59=mat59(6,:)';
xs66=mat66(3,:)';
ys66=mat66(6,:)';
xs74=mat74(3,:)';
ys74=mat74(6,:)';
xs83=mat83(3,:)';
ys83=mat83(6,:)';
xs93=mat93(3,:)';
ys93=mat93(6,:)';
xs105=mat105(3,:)';
ys105=mat105(6,:)';
xs120=mat120(3,:)';
ys120=mat120(6,:)';
xsshw=matshw(3,:)';
ysshw=matshw(6,:)';

xb59=mat59(7,:)';
yb59=mat59(10,:)';
xb66=mat66(7,:)';
yb66=mat66(10,:)';
xb74=mat74(7,:)';
yb74=mat74(10,:)';
xb83=mat83(7,:)';
yb83=mat83(10,:)';
xb93=mat93(7,:)';
yb93=mat93(10,:)';
xb105=mat105(7,:)';
yb105=mat105(10,:)';
xb120=mat120(7,:)';
yb120=mat120(10,:)';
xbshw=matshw(7,:)';
ybshw=matshw(10,:)';

xd59=mat59(11,:)';
yd59=mat59(14,:)';
xd66=mat66(11,:)';
yd66=mat66(14,:)';
xd74=mat74(11,:)';
yd74=mat74(14,:)';
xd83=mat83(11,:)';
yd83=mat83(14,:)';
xd93=mat93(11,:)';
yd93=mat93(14,:)';
xd105=mat105(11,:)';
yd105=mat105(14,:)';
xd120=mat120(11,:)';
yd120=mat120(14,:)';
xdshw=matshw(11,:)';
ydshw=matshw(14,:)';

%Find fits:

Bs59 = ridge(ys59(idxTrain59),xs59(idxTrain59),lam,0);
Bs66 = ridge(ys66(idxTrain66),xs66(idxTrain66),lam,0);
Bs74 = ridge(ys74(idxTrain74),xs74(idxTrain74),lam,0);
Bs83 = ridge(ys83(idxTrain83),xs83(idxTrain83),lam,0);
Bs93 = ridge(ys93(idxTrain93),xs93(idxTrain93),lam,0);
Bs105 = ridge(ys105(idxTrain105),xs105(idxTrain105),lam,0);
Bs120 = ridge(ys120(idxTrain120),xs120(idxTrain120),lam,0);
Bsshw = ridge(ysshw(idxTrainshw),xsshw(idxTrainshw),lam,0);

Bb59 = ridge(yb59(idxTrain59),xb59(idxTrain59),lam,0);
Bb66 = ridge(yb66(idxTrain66),xb66(idxTrain66),lam,0);
Bb74 = ridge(yb74(idxTrain74),xb74(idxTrain74),lam,0);
Bb83 = ridge(yb83(idxTrain83),xb83(idxTrain83),lam,0);
Bb93 = ridge(yb93(idxTrain93),xb93(idxTrain93),lam,0);
Bb105 = ridge(yb105(idxTrain105),xb105(idxTrain105),lam,0);
Bb120 = ridge(yb120(idxTrain120),xb120(idxTrain120),lam,0);
Bbshw = ridge(ybshw(idxTrainshw),xbshw(idxTrainshw),lam,0);

Bd59 = ridge(yd59(idxTrain59),xd59(idxTrain59),lam,0);
Bd66 = ridge(yd66(idxTrain66),xd66(idxTrain66),lam,0);
Bd74 = ridge(yd74(idxTrain74),xd74(idxTrain74),lam,0);
Bd83 = ridge(yd83(idxTrain83),xd83(idxTrain83),lam,0);
Bd93 = ridge(yd93(idxTrain93),xd93(idxTrain93),lam,0);
Bd105 = ridge(yd105(idxTrain105),xd105(idxTrain105),lam,0);
Bd120 = ridge(yd120(idxTrain120),xd120(idxTrain120),lam,0);
Bdshw = ridge(ydshw(idxTrainshw),xdshw(idxTrainshw),lam,0);

% Predict on test data

Ys59 = Bs59(1) + xs59(idxTest59)*Bs59(2);
Ys66 = Bs66(1) + xs66(idxTest66)*Bs66(2);
Ys74 = Bs74(1) + xs74(idxTest74)*Bs74(2);
Ys83 = Bs83(1) + xs83(idxTest83)*Bs83(2);
Ys93 = Bs93(1) + xs93(idxTest93)*Bs93(2);
Ys105 = Bs105(1) + xs105(idxTest105)*Bs105(2);
Ys120 = Bs120(1) + xs120(idxTest120)*Bs120(2);
Ysshw = Bsshw(1) + xsshw(idxTestshw)*Bsshw(2);

Yb59 = Bb59(1) + xb59(idxTest59)*Bb59(2);
Yb66 = Bb66(1) + xb66(idxTest66)*Bb66(2);
Yb74 = Bb74(1) + xb74(idxTest74)*Bb74(2);
Yb83 = Bb83(1) + xb83(idxTest83)*Bb83(2);
Yb93 = Bb93(1) + xb93(idxTest93)*Bb93(2);
Yb105 = Bb105(1) + xb105(idxTest105)*Bb105(2);
Yb120 = Bb120(1) + xb120(idxTest120)*Bb120(2);
Ybshw = Bbshw(1) + xbshw(idxTestshw)*Bbshw(2);

Yd59 = Bd59(1) + xd59(idxTest59)*Bd59(2);
Yd66 = Bd66(1) + xd66(idxTest66)*Bd66(2);
Yd74 = Bd74(1) + xd74(idxTest74)*Bd74(2);
Yd83 = Bd83(1) + xd83(idxTest83)*Bd83(2);
Yd93 = Bd93(1) + xd93(idxTest93)*Bd93(2);
Yd105 = Bd105(1) + xd105(idxTest105)*Bd105(2);
Yd120 = Bd120(1) + xd120(idxTest120)*Bd120(2);
Ydshw = Bdshw(1) + xdshw(idxTestshw)*Bdshw(2);

%Make some plots!

sz=2;
xloc=100;
yloc=50;

%Squat Fit Curves
figure('units','normalized','outerposition',[0 0 1 1]);

subplot(2,4,1)
hold on;
plot(xs59(idxTest59),Ys59);
text(xloc,yloc,['y = ',num2str(Bs59(1)),' + ',num2str(Bs59(2)),'*x']);
scatter(xs59,ys59,sz);
hold off;
title('59 kg Squat');
xlabel('First Squat (kg)');
ylabel('Best Squat (kg)');
xlim([0 400]);
ylim([0 400]);

subplot(2,4,2)
hold on;
plot(xs66(idxTest66),Ys66);
text(xloc,yloc,['y = ',num2str(Bs66(1)),' + ',num2str(Bs66(2)),'*x']);
scatter(xs66,ys66,sz);
hold off;title('66 kg Squat');
xlabel('First Squat (kg)');
ylabel('Best Squat (kg)');
xlim([0 400]);
ylim([0 400]);


subplot(2,4,3)
hold on;
plot(xs74(idxTest74),Ys74);
text(xloc,yloc,['y = ',num2str(Bs74(1)),' + ',num2str(Bs74(2)),'*x']);
scatter(xs74,ys74,sz);
hold off;title('74 kg Squat');
xlabel('First Squat (kg)');
ylabel('Best Squat (kg)');
xlim([0 400]);
ylim([0 400]);

subplot(2,4,4)
hold on;
plot(xs83(idxTest83),Ys83);
text(xloc,yloc,['y = ',num2str(Bs83(1)),' + ',num2str(Bs83(2)),'*x']);
scatter(xs83,ys83,sz);
hold off;
title('83 kg Squat');
xlabel('First Squat (kg)');
ylabel('Best Squat (kg)');
xlim([0 400]);
ylim([0 400]);

subplot(2,4,5)
hold on;
plot(xs93(idxTest93),Ys93);
text(xloc,yloc,['y = ',num2str(Bs93(1)),' + ',num2str(Bs93(2)),'*x']);
scatter(xs93,ys93,sz);
hold off;
title('93 kg Squat');
xlabel('First Squat (kg)');
ylabel('Best Squat (kg)');
xlim([0 400]);
ylim([0 400]);

subplot(2,4,6)
hold on;
plot(xs105(idxTest105),Ys105);
text(xloc,yloc,['y = ',num2str(Bs105(1)),' + ',num2str(Bs105(2)),'*x']);
scatter(xs105,ys105,sz);
hold off;
title('105 kg Squat');
xlabel('First Squat (kg)');
ylabel('Best Squat (kg)');
xlim([0 400]);
ylim([0 400]);

subplot(2,4,7)
hold on;
plot(xs120(idxTest120),Ys120);
text(xloc,yloc,['y = ',num2str(Bs120(1)),' + ',num2str(Bs120(2)),'*x']);
scatter(xs120,ys120,sz);
hold off;
title('120 kg Squat');
xlabel('First Squat (kg)');
ylabel('Best Squat (kg)');
xlim([0 400]);
ylim([0 400]);

subplot(2,4,8)
hold on;
plot(xsshw(idxTestshw),Ysshw);
text(xloc,yloc,['y = ',num2str(Bsshw(1)),' + ',num2str(Bsshw(2)),'*x']);
scatter(xsshw,ysshw,sz);
hold off;
title('SHW Squat');
xlabel('First Squat (kg)');
ylabel('Best Squat (kg)');
xlim([0 400]);
ylim([0 400]);


%Bench Fit Curves
figure('units','normalized','outerposition',[0 0 1 1]);

subplot(2,4,1)
hold on;
plot(xb59(idxTest59),Yb59);
text(xloc,yloc,['y = ',num2str(Bb59(1)),' + ',num2str(Bb59(2)),'*x']);
scatter(xb59,yb59,sz);
hold off;
title('59 kg Bench');
xlabel('First Bench (kg)');
ylabel('Best Bench (kg)');
xlim([0 400]);
ylim([0 400]);
 
subplot(2,4,2)
hold on;
plot(xb66(idxTest66),Yb66);
text(xloc,yloc,['y = ',num2str(Bb66(1)),' + ',num2str(Bb66(2)),'*x']);
scatter(xb66,yb66,sz);
hold off;title('66 kg Bench');
xlabel('First Bench (kg)');
ylabel('Best Bench (kg)');
xlim([0 400]);
ylim([0 400]);
 
subplot(2,4,3)
hold on;
plot(xb74(idxTest74),Yb74);
text(xloc,yloc,['y = ',num2str(Bb74(1)),' + ',num2str(Bb74(2)),'*x']);
scatter(xb74,yb74,sz);
hold off;title('74 kg Bench');
xlabel('First Bench (kg)');
ylabel('Best Bench (kg)');
xlim([0 400]);
ylim([0 400]);
 
subplot(2,4,4)
hold on;
plot(xb83(idxTest83),Yb83);
text(xloc,yloc,['y = ',num2str(Bb83(1)),' + ',num2str(Bb83(2)),'*x']);
scatter(xb83,yb83,sz);
hold off;
title('83 kg Bench');
xlabel('First Bench (kg)');
ylabel('Best Bench (kg)');
xlim([0 400]);
ylim([0 400]);
 
subplot(2,4,5)
hold on;
plot(xb93(idxTest93),Yb93);
text(xloc,yloc,['y = ',num2str(Bb93(1)),' + ',num2str(Bb93(2)),'*x']);
scatter(xb93,yb93,sz);
hold off;
title('93 kg Bench');
xlabel('First Bench (kg)');
ylabel('Best Bench (kg)');
xlim([0 400]);
ylim([0 400]);
 
subplot(2,4,6)
hold on;
plot(xb105(idxTest105),Yb105);
text(xloc,yloc,['y = ',num2str(Bb105(1)),' + ',num2str(Bb105(2)),'*x']);
scatter(xb105,yb105,sz);
hold off;
title('105 kg Bench');
xlabel('First Bench (kg)');
ylabel('Best Bench (kg)');
xlim([0 400]);
ylim([0 400]);
 
subplot(2,4,7)
hold on;
plot(xb120(idxTest120),Yb120);
text(xloc,yloc,['y = ',num2str(Bb120(1)),' + ',num2str(Bb120(2)),'*x']);
scatter(xb120,yb120,sz);
hold off;
title('120 kg Bench');
xlabel('First Bench (kg)');
ylabel('Best Bench (kg)');
xlim([0 400]);
ylim([0 400]);
 
subplot(2,4,8)
hold on;
plot(xbshw(idxTestshw),Ybshw);
text(xloc,yloc,['y = ',num2str(Bbshw(1)),' + ',num2str(Bbshw(2)),'*x']);
scatter(xbshw,ybshw,sz);
hold off;
title('SHW Bench');
xlabel('First Bench (kg)');
ylabel('Best Bench (kg)');
xlim([0 400]);
ylim([0 400]);


%Deadlift Fit Curves
figure('units','normalized','outerposition',[0 0 1 1]);

subplot(2,4,1)
hold on;
plot(xd59(idxTest59),Yd59);
text(xloc,yloc,['y = ',num2str(Bd59(1)),' + ',num2str(Bd59(2)),'*x']);
scatter(xd59,yd59,sz);
hold off;
title('59 kg Deadlift');
xlabel('First Deadlift (kg)');
ylabel('Best Deadlift (kg)');
xlim([0 400]);
ylim([0 400]);
 
subplot(2,4,2)
hold on;
plot(xd66(idxTest66),Yd66);
text(xloc,yloc,['y = ',num2str(Bd66(1)),' + ',num2str(Bd66(2)),'*x']);
scatter(xd66,yd66,sz);
hold off;title('66 kg Deadlift');
xlabel('First Deadlift (kg)');
ylabel('Best Deadlift (kg)');
xlim([0 400]);
ylim([0 400]);
 
subplot(2,4,3)
hold on;
plot(xd74(idxTest74),Yd74);
text(xloc,yloc,['y = ',num2str(Bd74(1)),' + ',num2str(Bd74(2)),'*x']);
scatter(xd74,yd74,sz);
hold off;title('74 kg Deadlift');
xlabel('First Deadlift (kg)');
ylabel('Best Deadlift (kg)');
xlim([0 400]);
ylim([0 400]);
 
subplot(2,4,4)
hold on;
plot(xd83(idxTest83),Yd83);
text(xloc,yloc,['y = ',num2str(Bd83(1)),' + ',num2str(Bd83(2)),'*x']);
scatter(xd83,yd83,sz);
hold off;
title('83 kg Deadlift');
xlabel('First Deadlift (kg)');
ylabel('Best Deadlift (kg)');
xlim([0 400]);
ylim([0 400]);
 
subplot(2,4,5)
hold on;
plot(xd93(idxTest93),Yd93);
text(xloc,yloc,['y = ',num2str(Bd93(1)),' + ',num2str(Bd93(2)),'*x']);
scatter(xd93,yd93,sz);
hold off;
title('93 kg Deadlift');
xlabel('First Deadlift (kg)');
ylabel('Best Deadlift (kg)');
xlim([0 400]);
ylim([0 400]);
 
subplot(2,4,6)
hold on;
plot(xd105(idxTest105),Yd105);
text(xloc,yloc,['y = ',num2str(Bd105(1)),' + ',num2str(Bd105(2)),'*x']);
scatter(xd105,yd105,sz);
hold off;
title('105 kg Deadlift');
xlabel('First Deadlift (kg)');
ylabel('Best Deadlift (kg)');
xlim([0 400]);
ylim([0 400]);
 
subplot(2,4,7)
hold on;
plot(xd120(idxTest120),Yd120);
text(xloc,yloc,['y = ',num2str(Bd120(1)),' + ',num2str(Bd120(2)),'*x']);
scatter(xd120,yd120,sz);
hold off;
title('120 kg Deadlift');
xlabel('First Deadlift (kg)');
ylabel('Best Deadlift (kg)');
xlim([0 400]);
ylim([0 400]);
 
subplot(2,4,8)
hold on;
plot(xdshw(idxTestshw),Ydshw);
text(xloc,yloc,['y = ',num2str(Bdshw(1)),' + ',num2str(Bdshw(2)),'*x']);
scatter(xdshw,ydshw,sz);
hold off;
title('SHW Deadlift');
xlabel('First Deadlift (kg)');
ylabel('Best Deadlift (kg)');
xlim([0 400]);
ylim([0 400]);

%Evaluate model performance: plot actual vs predicted!
%Squats:

figure('units','normalized','outerposition',[0 0 1 1]);
 
subplot(2,4,1)
hold on;
scatter(ys59(idxTest59),Ys59,sz);
plot(ys59(idxTest59),ys59(idxTest59));
hold off;
title('59 kg Squat');
xlabel('Actual Best Squat');
ylabel('Predicted Best Squat');

 
subplot(2,4,2)
hold on;
scatter(ys66(idxTest66),Ys66,sz);
plot(ys66(idxTest66),ys66(idxTest66));
hold off;
title('66 kg Squat');
xlabel('Actual Best Squat');
ylabel('Predicted Best Squat');
 
 
subplot(2,4,3)
hold on;
scatter(ys74(idxTest74),Ys74,sz);
plot(ys74(idxTest74),ys74(idxTest74));
hold off;
title('74 kg Squat');
xlabel('Actual Best Squat');
ylabel('Predicted Best Squat');

 
subplot(2,4,4)
hold on;
scatter(ys83(idxTest83),Ys83,sz);
plot(ys83(idxTest83),ys83(idxTest83));
hold off;
title('83 kg Squat');
xlabel('Actual Best Squat');
ylabel('Predicted Best Squat');
 
subplot(2,4,5)
hold on;
scatter(ys93(idxTest93),Ys93,sz);
plot(ys93(idxTest93),ys93(idxTest93));
hold off;
title('93 kg Squat');
xlabel('Actual Best Squat');
ylabel('Predicted Best Squat');
 
subplot(2,4,6)
hold on;
scatter(ys105(idxTest105),Ys105,sz);
plot(ys105(idxTest105),ys105(idxTest105));hold off;
title('105 kg Squat');
xlabel('Actual Best Squat');
ylabel('Predicted Best Squat');
 
subplot(2,4,7)
hold on;
scatter(ys120(idxTest120),Ys120,sz);
plot(ys120(idxTest120),ys120(idxTest120));
hold off;
title('120 kg Squat');
xlabel('Actual Best Squat');
ylabel('Predicted Best Squat');
 
subplot(2,4,8)
hold on;
scatter(ysshw(idxTestshw),Ysshw,sz);
plot(ysshw(idxTestshw),ysshw(idxTestshw));
hold off;
title('SHW Squat');
xlabel('Actual Best Squat');
ylabel('Predicted Best Squat');

%Bench

figure('units','normalized','outerposition',[0 0 1 1]);
 
subplot(2,4,1)
hold on;
scatter(yb59(idxTest59),Yb59,sz);
plot(yb59(idxTest59),yb59(idxTest59));
hold off;
title('59 kg Bench');
xlabel('Actual Best Bench');
ylabel('Predicted Best Bench'); 
 
subplot(2,4,2)
hold on;
scatter(yb66(idxTest66),Yb66,sz);
plot(yb66(idxTest66),yb66(idxTest66));
hold off;
title('66 kg Bench');
xlabel('Actual Best Bench');
ylabel('Predicted Best Bench');
 
subplot(2,4,3)
hold on;
scatter(yb74(idxTest74),Yb74,sz);
plot(yb74(idxTest74),yb74(idxTest74));
hold off;
title('74 kg Bench');
xlabel('Actual Best Bench');
ylabel('Predicted Best Bench');
 
subplot(2,4,4)
hold on;
scatter(yb83(idxTest83),Yb83,sz);
plot(yb83(idxTest83),yb83(idxTest83));
hold off;
title('83 kg Bench');
xlabel('Actual Best Bench');
ylabel('Predicted Best Bench');
 
subplot(2,4,5)
hold on;
scatter(yb93(idxTest93),Yb93,sz);
plot(yb93(idxTest93),yb93(idxTest93));
hold off;
title('93 kg Bench');
xlabel('Actual Best Bench');
ylabel('Predicted Best Bench');
 
subplot(2,4,6)
hold on;
scatter(yb105(idxTest105),Yb105,sz);
plot(yb105(idxTest105),yb105(idxTest105));hold off;
title('105 kg Bench');
xlabel('Actual Best Bench');
ylabel('Predicted Best Bench');
 
subplot(2,4,7)
hold on;
scatter(yb120(idxTest120),Yb120,sz);
plot(yb120(idxTest120),yb120(idxTest120));
hold off;
title('120 kg Bench');
xlabel('Actual Best Bench');
ylabel('Predicted Best Bench');
 
subplot(2,4,8)
hold on;
scatter(ybshw(idxTestshw),Ybshw,sz);
plot(ybshw(idxTestshw),ybshw(idxTestshw));
hold off;
title('SHW Bench');
xlabel('Actual Best Bench');
ylabel('Predicted Best Bench');

%Deadlift

figure('units','normalized','outerposition',[0 0 1 1]);
 
subplot(2,4,1)
hold on;
scatter(yd59(idxTest59),Yd59,sz);
plot(yd59(idxTest59),yd59(idxTest59));
hold off;
title('59 kg Deadlift');
xlabel('Actual Best Deadlift');
ylabel('Predicted Best Deadlift');
 
 
subplot(2,4,2)
hold on;
scatter(yd66(idxTest66),Yd66,sz);
plot(yd66(idxTest66),yd66(idxTest66));
hold off;
title('66 kg Deadlift');
xlabel('Actual Best Deadlift');
ylabel('Predicted Best Deadlift');
 
 
subplot(2,4,3)
hold on;
scatter(yd74(idxTest74),Yd74,sz);
plot(yd74(idxTest74),yd74(idxTest74));
hold off;
title('74 kg Deadlift');
xlabel('Actual Best Deadlift');
ylabel('Predicted Best Deadlift');
 
 
subplot(2,4,4)
hold on;
scatter(yd83(idxTest83),Yd83,sz);
plot(yd83(idxTest83),yd83(idxTest83));
hold off;
title('83 kg Deadlift');
xlabel('Actual Best Deadlift');
ylabel('Predicted Best Deadlift');
 
subplot(2,4,5)
hold on;
scatter(yd93(idxTest93),Yd93,sz);
plot(yd93(idxTest93),yd93(idxTest93));
hold off;
title('93 kg Deadlift');
xlabel('Actual Best Deadlift');
ylabel('Predicted Best Deadlift');
 
subplot(2,4,6)
hold on;
scatter(yd105(idxTest105),Yd105,sz);
plot(yd105(idxTest105),yd105(idxTest105));hold off;
title('105 kg Deadlift');
xlabel('Actual Best Deadlift');
ylabel('Predicted Best Deadlift');
 
subplot(2,4,7)
hold on;
scatter(yd120(idxTest120),Yd120,sz);
plot(yd120(idxTest120),yd120(idxTest120));
hold off;
title('120 kg Deadlift');
xlabel('Actual Best Deadlift');
ylabel('Predicted Best Deadlift');
 
subplot(2,4,8)
hold on;
scatter(ydshw(idxTestshw),Ydshw,sz);
plot(ydshw(idxTestshw),ydshw(idxTestshw));
hold off;
title('SHW Deadlift');
xlabel('Actual Best Deadlift');
ylabel('Predicted Best Deadlift');


clear idxTest59 idxTest66 idxTest74 idxTest83 idxTest93 idxTest105 idxTest120 idxTestshw...
    idxTrain59 idxTrain66 idxTrain74 idxTrain83 idxTrain93 idxTrain105 idxTrain120 idxTrainshw...
    Ys59 Ys66 Ys74 Ys83 Ys93 Ys105 Ys120 Ysshw...
    Yb59 Yb66 Yb74 Yb83 Yb93 Yb105 Yb120 Ybshw...
    Yd59 Yd66 Yd74 Yd83 Yd93 Yd105 Yd120 Ydshw...
    ys59 ys66 ys74 ys83 ys93 ys105 ys120 ysshw...
    yb59 yb66 yb74 yb83 yb93 yb105 yb120 ybshw...
    yd59 yd66 yd74 yd83 yd93 yd105 yd120 ydshw...
    xs59 xs66 xs74 xs83 xs93 xs105 xs120 xsshw...
    xb59 xb66 xb74 xb83 xb93 xb105 xb120 xbshw...
    xd59 xd66 xd74 xd83 xd93 xd105 xd120 xdshw...
    c59 c66 c74 c83 c93 c105 c120 cshw...
    n59 n66 n74 n83 n93 n105 n120 nshw...
    Bs59 Bs66 Bs74 Bs83 Bs93 Bs105 Bs120 Bsshw...
    Bb59 Bb66 Bb74 Bb83 Bb93 Bb105 Bb120 Bbshw...
    Bd59 Bd66 Bd74 Bd83 Bd93 Bd105 Bd120 Bdshw...
    divisnum equipnum event_equipment eventsum i km lam sz xloc yloc...
    clus59 clus66 clus74 clus83 clus93 clus105 clus120 clusshw event_equip;

disp('Data matrices are in the format [age; bw; s1; s2; s3; s; b1; b2; b3; b; d1; d2; d3; d; total; wilks; cluster]');
fprintf('\n');

toc;
end

%But if we want to look at data for the ladies:

if strcmp(sexchoice,'female')==1
for i=1:numel(bw_female)
    if bw_female(i)>63 && bw_female(i)<=72
        a=a+1;
        age_72(a)=age_female(i);
        total_72(a)=total_female(i);
        bw_72(a)=bw_female(i);
        s_72(a)=s_female(i);
        s1_72(a)=s1_female(i);
        s2_72(a)=s2_female(i);
        s3_72(a)=s3_female(i);
        b_72(a)=b_female(i);
        b1_72(a)=b1_female(i);
        b2_72(a)=b2_female(i);
        b3_72(a)=b3_female(i);
        d_72(a)=d_female(i);
        d1_72(a)=d1_female(i);
        d2_72(a)=d2_female(i);
        d3_72(a)=d3_female(i);
        wilks_72(a)=wilks_female(i);
    elseif bw_female(i)>57 && bw_female(i)<=63
        b=b+1;
        age_63(b)=age_female(i);
        total_63(b)=total_female(i);
        bw_63(b)=bw_female(i);
        s_63(b)=s_female(i);
        s1_63(b)=s1_female(i);
        s2_63(b)=s2_female(i);
        s3_63(b)=s3_female(i);
        b_63(b)=b_female(i);
        b1_63(b)=b1_female(i);
        b2_63(b)=b2_female(i);
        b3_63(b)=b3_female(i);
        d_63(b)=d_female(i);
        d1_63(b)=d1_female(i);
        d2_63(b)=d2_female(i);
        d3_63(b)=d3_female(i);
        wilks_63(b)=wilks_female(i);
    elseif bw_female(i)>52 && bw_female(i)<=57
        c=c+1;
        age_57(c)=age_female(i);
        total_57(c)=total_female(i);
        bw_57(c)=bw_female(i);
        s_57(c)=s_female(i);
        s1_57(c)=s1_female(i);
        s2_57(c)=s2_female(i);
        s3_57(c)=s3_female(i);
        b_57(c)=b_female(i);
        b1_57(c)=b1_female(i);
        b2_57(c)=b2_female(i);
        b3_57(c)=b3_female(i);
        d_57(c)=d_female(i);
        d1_57(c)=d1_female(i);
        d2_57(c)=d2_female(i);
        d3_57(c)=d3_female(i);
        wilks_57(c)=wilks_female(i);
    elseif bw_female(i)>47 && bw_female(i)<=52
        d=d+1;
        age_52(d)=age_female(i);
        total_52(d)=total_female(i);
        bw_52(d)=bw_female(i);
        s_52(d)=s_female(i);
        s1_52(d)=s1_female(i);
        s2_52(d)=s2_female(i);
        s3_52(d)=s3_female(i);
        b_52(d)=b_female(i);
        b1_52(d)=b1_female(i);
        b2_52(d)=b2_female(i);
        b3_52(d)=b3_female(i);
        d_52(d)=d_female(i);
        d1_52(d)=d1_female(i);
        d2_52(d)=d2_female(i);
        d3_52(d)=d3_female(i);
        wilks_52(d)=wilks_female(i);
    elseif bw_female(i)<=47
        e=e+1;
        age_47(e)=age_female(i);
        total_47(e)=total_female(i);
        bw_47(e)=bw_female(i);
        s_47(e)=s_female(i);
        s1_47(e)=s1_female(i);
        s2_47(e)=s2_female(i);
        s3_47(e)=s3_female(i);
        b_47(e)=b_female(i);
        b1_47(e)=b1_female(i);
        b2_47(e)=b2_female(i);
        b3_47(e)=b3_female(i);
        d_47(e)=d_female(i);
        d1_47(e)=d1_female(i);
        d2_47(e)=d2_female(i);
        d3_47(e)=d3_female(i);
        wilks_47(e)=wilks_female(i);
    elseif bw_female(i)>72 && bw_female(i)<=84
        f=f+1;
        age_84(f)=age_female(i);
        total_84(f)=total_female(i);
        bw_84(f)=bw_female(i);
        s_84(f)=s_female(i);
        s1_84(f)=s1_female(i);
        s2_84(f)=s2_female(i);
        s3_84(f)=s3_female(i);
        b_84(f)=b_female(i);
        b1_84(f)=b1_female(i);
        b2_84(f)=b2_female(i);
        b3_84(f)=b3_female(i);
        d_84(f)=d_female(i);
        d1_84(f)=d1_female(i);
        d2_84(f)=d2_female(i);
        d3_84(f)=d3_female(i);
        wilks_84(f)=wilks_female(i);
    elseif bw_female(i)>84
        h=h+1;
        age_shw(h)=age_female(i);
        total_shw(h)=total_female(i);
        bw_shw(h)=bw_female(i);
        s_shw(h)=s_female(i);
        s1_shw(h)=s1_female(i);
        s2_shw(h)=s2_female(i);
        s3_shw(h)=s3_female(i);
        b_shw(h)=b_female(i);
        b1_shw(h)=b1_female(i);
        b2_shw(h)=b2_female(i);
        b3_shw(h)=b3_female(i);
        d_shw(h)=d_female(i);
        d1_shw(h)=d1_female(i);
        d2_shw(h)=d2_female(i);
        d3_shw(h)=d3_female(i);
        wilks_shw(h)=wilks_female(i);
    end
end
 
clear a b c d e f g h men women j k;
 
% Now, incorporate a clustering algorithm to determine ideal cutoffs for
% lifter classifications for this weight class!
 
km=7;
 
bwVtot47=[bw_47;total_47];
bwVtot47=bwVtot47';
idx47 = kmeans(bwVtot47,km);
 
bwVtot52=[bw_52;total_52];
bwVtot52=bwVtot52';
idx52 = kmeans(bwVtot52,km);
 
bwVtot57=[bw_57;total_57];
bwVtot57=bwVtot57';
idx57 = kmeans(bwVtot57,km);
 
bwVtot63=[bw_63;total_63];
bwVtot63=bwVtot63';
idx63 = kmeans(bwVtot63,km);
 
bwVtot72=[bw_72;total_72];
bwVtot72=bwVtot72';
idx72 = kmeans(bwVtot72,km);
 
bwVtot84=[bw_84;total_84];
bwVtot84=bwVtot84';
idx84 = kmeans(bwVtot84,km);
 
bwVtotshw=[bw_shw;total_shw];
bwVtotshw=bwVtotshw';
idxshw = kmeans(bwVtotshw,km);
 
%Create matrices that can be plugged into ML apps:
 
mat47=[age_47; bw_47; s1_47; s2_47; s3_47; s_47; b1_47; b2_47; b3_47; b_47; d1_47; d2_47; d3_47; d_47; total_47; wilks_47; idx47'];
mat52=[age_52; bw_52; s1_52; s2_52; s3_52; s_52; b1_52; b2_52; b3_52; b_52; d1_52; d2_52; d3_52; d_52; total_52; wilks_52; idx52'];
mat57=[age_57; bw_57; s1_57; s2_57; s3_57; s_57; b1_57; b2_57; b3_57; b_57; d1_57; d2_57; d3_57; d_57; total_57; wilks_57; idx57'];
mat63=[age_63; bw_63; s1_63; s2_63; s3_63; s_63; b1_63; b2_63; b3_63; b_63; d1_63; d2_63; d3_63; d_63; total_63; wilks_63; idx63'];
mat72=[age_72; bw_72; s1_72; s2_72; s3_72; s_72; b1_72; b2_72; b3_72; b_72; d1_72; d2_72; d3_72; d_72; total_72; wilks_72; idx72'];
mat84=[age_84; bw_84; s1_84; s2_84; s3_84; s_84; b1_84; b2_84; b3_84; b_84; d1_84; d2_84; d3_84; d_84; total_84; wilks_84; idx84'];
matshw=[age_shw; bw_shw; s1_shw; s2_shw; s3_shw; s_shw; b1_shw; b2_shw; b3_shw; b_shw; d1_shw; d2_shw; d3_shw; d_shw; total_shw; wilks_shw; idxshw'];
 
zer=zeros(1,km);
clus47=zer;
clus52=zer;
clus57=zer;
clus63=zer;
clus72=zer;
clus84=zer;
clusshw=zer;
 
for i=1:km
clus47(i)=sum(mat47(17,:)==i);
clus52(i)=sum(mat52(17,:)==i);
clus57(i)=sum(mat57(17,:)==i);
clus63(i)=sum(mat63(17,:)==i);
clus72(i)=sum(mat72(17,:)==i);
clus84(i)=sum(mat84(17,:)==i);
clusshw(i)=sum(matshw(17,:)==i);
end
 
figure('units','normalized','outerposition',[0 0 1 1]);
subplot(2,4,1)
gscatter(bw_47,total_47,idx47);
title('Female 47 kg Lifters');
xlabel('Bodyweight (kg)');
ylabel('SBD Total (kg)');
legend(num2str(clus47(1)),num2str(clus47(2)),num2str(clus47(3)),...
    num2str(clus47(4)),num2str(clus47(5)),num2str(clus47(6)),num2str(clus47(7)));
 
subplot(2,4,2)
gscatter(bw_52,total_52,idx52);
title('Female 52 kg Lifters');
xlabel('Bodyweight (kg)');
ylabel('SBD Total (kg)');
legend(num2str(clus52(1)),num2str(clus52(2)),num2str(clus52(3)),...
    num2str(clus52(4)),num2str(clus52(5)),num2str(clus52(6)),num2str(clus52(7)));
 
subplot(2,4,3)
gscatter(bw_57,total_57,idx57);
title('Female 57 kg Lifters');
xlabel('Bodyweight (kg)');
ylabel('SBD Total (kg)');
legend(num2str(clus57(1)),num2str(clus57(2)),num2str(clus57(3)),...
    num2str(clus57(4)),num2str(clus57(5)),num2str(clus57(6)),num2str(clus57(7)));
 
subplot(2,4,4)
gscatter(bw_63,total_63,idx63);
title('Female 63 kg Lifters');
xlabel('Bodyweight (kg)');
ylabel('SBD Total (kg)');
legend(num2str(clus63(1)),num2str(clus63(2)),num2str(clus63(3)),...
    num2str(clus63(4)),num2str(clus63(5)),num2str(clus63(6)),num2str(clus63(7)));
 
subplot(2,4,5)
gscatter(bw_72,total_72,idx72);
title('Female 72 kg Lifters');
xlabel('Bodyweight (kg)');
ylabel('SBD Total (kg)');
legend(num2str(clus72(1)),num2str(clus72(2)),num2str(clus72(3)),...
    num2str(clus72(4)),num2str(clus72(5)),num2str(clus72(6)),num2str(clus72(7)));
 
subplot(2,4,6)
gscatter(bw_84,total_84,idx84);
title('Female 84 kg Lifters');
xlabel('Bodyweight (kg)');
ylabel('SBD Total (kg)');
legend(num2str(clus84(1)),num2str(clus84(2)),num2str(clus84(3)),...
    num2str(clus84(4)),num2str(clus84(5)),num2str(clus84(6)),num2str(clus84(7)));
 
subplot(2,4,8)
gscatter(bw_shw,total_shw,idxshw);
title('Female SHW Lifters');
xlabel('Bodyweight (kg)');
ylabel('SBD Total (kg)');
legend(num2str(clusshw(1)),num2str(clusshw(2)),num2str(clusshw(3)),...
    num2str(clusshw(4)),num2str(clusshw(5)),num2str(clusshw(6)),num2str(clusshw(7)));
 
clear age_male age_female b1_male b1_female b2_male b2_female b3_male b3_female...
    b_male b_female bw_male bw_female d1_male d1_female d2_male d2_female...
    d3_male d3_female d_male d_female s1_male s1_female s2_male s2_female s3_male s3_female...
    s_male s_female total_male total_female wilks_male wilks_female
 
 
clear age_47 age_52 age_57 age_63 age_72 age_84 age_shw...
    bw_47 bw_52 bw_57 bw_63 bw_72 bw_84 bw_shw...
    s_47 s1_47 s2_47 s3_47 sj1_47 sj2_47...
    s_52 s1_52 s2_52 s3_52 sj1_52 sj2_52...
    s_57 s1_57 s2_57 s3_57 sj1_57 sj2_57...
    s_63 s1_63 s2_63 s3_63 sj1_63 sj2_63...
    s_72 s1_72 s2_72 s3_72 sj1_72 sj2_72...
    s_84 s1_84 s2_84 s3_84 sj1_84 sj2_84...
    s_shw s1_shw s2_shw s3_shw sj1_shw sj2_shw...
    b_47 b1_47 b2_47 b3_47 bj1_47 bj2_47...
    b_52 b1_52 b2_52 b3_52 bj1_52 bj2_52...
    b_57 b1_57 b2_57 b3_57 bj1_57 bj2_57...
    b_63 b1_63 b2_63 b3_63 bj1_63 bj2_63...
    b_72 b1_72 b2_72 b3_72 bj1_72 bj2_72...
    b_84 b1_84 b2_84 b3_84 bj1_84 bj2_84...
    b_shw b1_shw b2_shw b3_shw bj1_shw bj2_shw...
    d_47 d1_47 d2_47 d3_47 dj1_47 dj2_47...
    d_52 d1_52 d2_52 d3_52 dj1_52 dj2_52...
    d_57 d1_57 d2_57 d3_57 dj1_57 dj2_57...
    d_63 d1_63 d2_63 d3_63 dj1_63 dj2_63...
    d_72 d1_72 d2_72 d3_72 dj1_72 dj2_72...
    d_84 d1_84 d2_84 d3_84 dj1_84 dj2_84...
    d_shw d1_shw d2_shw d3_shw dj1_shw dj2_shw...
    total_47 total_52 total_57 total_63 total_72 total_84 total_shw...
    wilks_47 wilks_52 wilks_57 wilks_63 wilks_72 wilks_84 wilks_shw...
    idx47 idx52 idx57 idx63 idx72 idx84 idxshw...
    bwVtot47 bwVtot52 bwVtot57 bwVtot63 bwVtot72 bwVtot84 bwVtotshw zer;
  
 
%Now, let's learn some linear regressions for predicting best SBD based on
%first attempts
 
%First, make sure all attempt values in mat### are non-negative or NaN
 
mat47(mat47<0)=NaN;
mat52(mat52<0)=NaN;
mat57(mat57<0)=NaN;
mat63(mat63<0)=NaN;
mat72(mat72<0)=NaN;
mat84(mat84<0)=NaN;
matshw(matshw<0)=NaN;
 
%Make fits
 
n47=length(mat47(1,:));
n52=length(mat52(1,:));
n57=length(mat57(1,:));
n63=length(mat63(1,:));
n72=length(mat72(1,:));
n84=length(mat84(1,:));
nshw=length(matshw(1,:));
 
rng('default');
 
c47=cvpartition(n47,'HoldOut',0.3);
c52=cvpartition(n52,'HoldOut',0.3);
c57=cvpartition(n57,'HoldOut',0.3);
c63=cvpartition(n63,'HoldOut',0.3);
c72=cvpartition(n72,'HoldOut',0.3);
c84=cvpartition(n84,'HoldOut',0.3);
cshw=cvpartition(nshw,'HoldOut',0.3);
 
idxTrain47=training(c47,1);
idxTrain52=training(c52,1);
idxTrain57=training(c57,1);
idxTrain63=training(c63,1);
idxTrain72=training(c72,1);
idxTrain84=training(c84,1);
idxTrainshw=training(cshw,1);
 
idxTest47=~idxTrain47;
idxTest52=~idxTrain52;
idxTest57=~idxTrain57;
idxTest63=~idxTrain63;
idxTest72=~idxTrain72;
idxTest84=~idxTrain84;
idxTestshw=~idxTrainshw;
 
lam=10; %Ridge parameter - 0 corresponds to least squares
 
%Make appropriate vectors for fit - squat, bench, dead separate
 
xs47=mat47(3,:)';
ys47=mat47(6,:)';
xs52=mat52(3,:)';
ys52=mat52(6,:)';
xs57=mat57(3,:)';
ys57=mat57(6,:)';
xs63=mat63(3,:)';
ys63=mat63(6,:)';
xs72=mat72(3,:)';
ys72=mat72(6,:)';
xs84=mat84(3,:)';
ys84=mat84(6,:)';
xsshw=matshw(3,:)';
ysshw=matshw(6,:)';
 
xb47=mat47(7,:)';
yb47=mat47(10,:)';
xb52=mat52(7,:)';
yb52=mat52(10,:)';
xb57=mat57(7,:)';
yb57=mat57(10,:)';
xb63=mat63(7,:)';
yb63=mat63(10,:)';
xb72=mat72(7,:)';
yb72=mat72(10,:)';
xb84=mat84(7,:)';
yb84=mat84(10,:)';
xbshw=matshw(7,:)';
ybshw=matshw(10,:)';
 
xd47=mat47(11,:)';
yd47=mat47(14,:)';
xd52=mat52(11,:)';
yd52=mat52(14,:)';
xd57=mat57(11,:)';
yd57=mat57(14,:)';
xd63=mat63(11,:)';
yd63=mat63(14,:)';
xd72=mat72(11,:)';
yd72=mat72(14,:)';
xd84=mat84(11,:)';
yd84=mat84(14,:)';
xdshw=matshw(11,:)';
ydshw=matshw(14,:)';
 
%Find fits:
 
Bs47 = ridge(ys47(idxTrain47),xs47(idxTrain47),lam,0);
Bs52 = ridge(ys52(idxTrain52),xs52(idxTrain52),lam,0);
Bs57 = ridge(ys57(idxTrain57),xs57(idxTrain57),lam,0);
Bs63 = ridge(ys63(idxTrain63),xs63(idxTrain63),lam,0);
Bs72 = ridge(ys72(idxTrain72),xs72(idxTrain72),lam,0);
Bs84 = ridge(ys84(idxTrain84),xs84(idxTrain84),lam,0);
Bsshw = ridge(ysshw(idxTrainshw),xsshw(idxTrainshw),lam,0);
 
Bb47 = ridge(yb47(idxTrain47),xb47(idxTrain47),lam,0);
Bb52 = ridge(yb52(idxTrain52),xb52(idxTrain52),lam,0);
Bb57 = ridge(yb57(idxTrain57),xb57(idxTrain57),lam,0);
Bb63 = ridge(yb63(idxTrain63),xb63(idxTrain63),lam,0);
Bb72 = ridge(yb72(idxTrain72),xb72(idxTrain72),lam,0);
Bb84 = ridge(yb84(idxTrain84),xb84(idxTrain84),lam,0);
Bbshw = ridge(ybshw(idxTrainshw),xbshw(idxTrainshw),lam,0);
 
Bd47 = ridge(yd47(idxTrain47),xd47(idxTrain47),lam,0);
Bd52 = ridge(yd52(idxTrain52),xd52(idxTrain52),lam,0);
Bd57 = ridge(yd57(idxTrain57),xd57(idxTrain57),lam,0);
Bd63 = ridge(yd63(idxTrain63),xd63(idxTrain63),lam,0);
Bd72 = ridge(yd72(idxTrain72),xd72(idxTrain72),lam,0);
Bd84 = ridge(yd84(idxTrain84),xd84(idxTrain84),lam,0);
Bdshw = ridge(ydshw(idxTrainshw),xdshw(idxTrainshw),lam,0);
 
% Predict on test data
 
Ys47 = Bs47(1) + xs47(idxTest47)*Bs47(2);
Ys52 = Bs52(1) + xs52(idxTest52)*Bs52(2);
Ys57 = Bs57(1) + xs57(idxTest57)*Bs57(2);
Ys63 = Bs63(1) + xs63(idxTest63)*Bs63(2);
Ys72 = Bs72(1) + xs72(idxTest72)*Bs72(2);
Ys84 = Bs84(1) + xs84(idxTest84)*Bs84(2);
Ysshw = Bsshw(1) + xsshw(idxTestshw)*Bsshw(2);
 
Yb47 = Bb47(1) + xb47(idxTest47)*Bb47(2);
Yb52 = Bb52(1) + xb52(idxTest52)*Bb52(2);
Yb57 = Bb57(1) + xb57(idxTest57)*Bb57(2);
Yb63 = Bb63(1) + xb63(idxTest63)*Bb63(2);
Yb72 = Bb72(1) + xb72(idxTest72)*Bb72(2);
Yb84 = Bb84(1) + xb84(idxTest84)*Bb84(2);
Ybshw = Bbshw(1) + xbshw(idxTestshw)*Bbshw(2);
 
Yd47 = Bd47(1) + xd47(idxTest47)*Bd47(2);
Yd52 = Bd52(1) + xd52(idxTest52)*Bd52(2);
Yd57 = Bd57(1) + xd57(idxTest57)*Bd57(2);
Yd63 = Bd63(1) + xd63(idxTest63)*Bd63(2);
Yd72 = Bd72(1) + xd72(idxTest72)*Bd72(2);
Yd84 = Bd84(1) + xd84(idxTest84)*Bd84(2);
Ydshw = Bdshw(1) + xdshw(idxTestshw)*Bdshw(2);
 
%Make some plots!
 
sz=2;
xloc=100;
yloc=50;
 
%Squat Fit Curves
figure('units','normalized','outerposition',[0 0 1 1]);
 
subplot(2,4,1)
hold on;
plot(xs47(idxTest47),Ys47);
text(xloc,yloc,['y = ',num2str(Bs47(1)),' + ',num2str(Bs47(2)),'*x']);
scatter(xs47,ys47,sz);
hold off;
title('47 kg Squat');
xlabel('First Squat (kg)');
ylabel('Best Squat (kg)');
xlim([0 400]);
ylim([0 400]);
 
subplot(2,4,2)
hold on;
plot(xs52(idxTest52),Ys52);
text(xloc,yloc,['y = ',num2str(Bs52(1)),' + ',num2str(Bs52(2)),'*x']);
scatter(xs52,ys52,sz);
hold off;title('52 kg Squat');
xlabel('First Squat (kg)');
ylabel('Best Squat (kg)');
xlim([0 400]);
ylim([0 400]);
 
 
subplot(2,4,3)
hold on;
plot(xs57(idxTest57),Ys57);
text(xloc,yloc,['y = ',num2str(Bs57(1)),' + ',num2str(Bs57(2)),'*x']);
scatter(xs57,ys57,sz);
hold off;title('57 kg Squat');
xlabel('First Squat (kg)');
ylabel('Best Squat (kg)');
xlim([0 400]);
ylim([0 400]);
 
subplot(2,4,4)
hold on;
plot(xs63(idxTest63),Ys63);
text(xloc,yloc,['y = ',num2str(Bs63(1)),' + ',num2str(Bs63(2)),'*x']);
scatter(xs63,ys63,sz);
hold off;
title('63 kg Squat');
xlabel('First Squat (kg)');
ylabel('Best Squat (kg)');
xlim([0 400]);
ylim([0 400]);
 
subplot(2,4,5)
hold on;
plot(xs72(idxTest72),Ys72);
text(xloc,yloc,['y = ',num2str(Bs72(1)),' + ',num2str(Bs72(2)),'*x']);
scatter(xs72,ys72,sz);
hold off;
title('72 kg Squat');
xlabel('First Squat (kg)');
ylabel('Best Squat (kg)');
xlim([0 400]);
ylim([0 400]);
 
subplot(2,4,6)
hold on;
plot(xs84(idxTest84),Ys84);
text(xloc,yloc,['y = ',num2str(Bs84(1)),' + ',num2str(Bs84(2)),'*x']);
scatter(xs84,ys84,sz);
hold off;
title('84 kg Squat');
xlabel('First Squat (kg)');
ylabel('Best Squat (kg)');
xlim([0 400]);
ylim([0 400]);
 
subplot(2,4,8)
hold on;
plot(xsshw(idxTestshw),Ysshw);
text(xloc,yloc,['y = ',num2str(Bsshw(1)),' + ',num2str(Bsshw(2)),'*x']);
scatter(xsshw,ysshw,sz);
hold off;
title('SHW Squat');
xlabel('First Squat (kg)');
ylabel('Best Squat (kg)');
xlim([0 400]);
ylim([0 400]);
 
 
%Bench Fit Curves
figure('units','normalized','outerposition',[0 0 1 1]);
 
subplot(2,4,1)
hold on;
plot(xb47(idxTest47),Yb47);
text(xloc,yloc,['y = ',num2str(Bb47(1)),' + ',num2str(Bb47(2)),'*x']);
scatter(xb47,yb47,sz);
hold off;
title('47 kg Bench');
xlabel('First Bench (kg)');
ylabel('Best Bench (kg)');
xlim([0 400]);
ylim([0 400]);
 
subplot(2,4,2)
hold on;
plot(xb52(idxTest52),Yb52);
text(xloc,yloc,['y = ',num2str(Bb52(1)),' + ',num2str(Bb52(2)),'*x']);
scatter(xb52,yb52,sz);
hold off;title('52 kg Bench');
xlabel('First Bench (kg)');
ylabel('Best Bench (kg)');
xlim([0 400]);
ylim([0 400]);
 
subplot(2,4,3)
hold on;
plot(xb57(idxTest57),Yb57);
text(xloc,yloc,['y = ',num2str(Bb57(1)),' + ',num2str(Bb57(2)),'*x']);
scatter(xb57,yb57,sz);
hold off;title('57 kg Bench');
xlabel('First Bench (kg)');
ylabel('Best Bench (kg)');
xlim([0 400]);
ylim([0 400]);
 
subplot(2,4,4)
hold on;
plot(xb63(idxTest63),Yb63);
text(xloc,yloc,['y = ',num2str(Bb63(1)),' + ',num2str(Bb63(2)),'*x']);
scatter(xb63,yb63,sz);
hold off;
title('63 kg Bench');
xlabel('First Bench (kg)');
ylabel('Best Bench (kg)');
xlim([0 400]);
ylim([0 400]);
 
subplot(2,4,5)
hold on;
plot(xb72(idxTest72),Yb72);
text(xloc,yloc,['y = ',num2str(Bb72(1)),' + ',num2str(Bb72(2)),'*x']);
scatter(xb72,yb72,sz);
hold off;
title('72 kg Bench');
xlabel('First Bench (kg)');
ylabel('Best Bench (kg)');
xlim([0 400]);
ylim([0 400]);
 
subplot(2,4,6)
hold on;
plot(xb84(idxTest84),Yb84);
text(xloc,yloc,['y = ',num2str(Bb84(1)),' + ',num2str(Bb84(2)),'*x']);
scatter(xb84,yb84,sz);
hold off;
title('84 kg Bench');
xlabel('First Bench (kg)');
ylabel('Best Bench (kg)');
xlim([0 400]);
ylim([0 400]);
 
subplot(2,4,8)
hold on;
plot(xbshw(idxTestshw),Ybshw);
text(xloc,yloc,['y = ',num2str(Bbshw(1)),' + ',num2str(Bbshw(2)),'*x']);
scatter(xbshw,ybshw,sz);
hold off;
title('SHW Bench');
xlabel('First Bench (kg)');
ylabel('Best Bench (kg)');
xlim([0 400]);
ylim([0 400]);
 
 
%Deadlift Fit Curves
figure('units','normalized','outerposition',[0 0 1 1]);
 
subplot(2,4,1)
hold on;
plot(xd47(idxTest47),Yd47);
text(xloc,yloc,['y = ',num2str(Bd47(1)),' + ',num2str(Bd47(2)),'*x']);
scatter(xd47,yd47,sz);
hold off;
title('47 kg Deadlift');
xlabel('First Deadlift (kg)');
ylabel('Best Deadlift (kg)');
xlim([0 400]);
ylim([0 400]);
 
subplot(2,4,2)
hold on;
plot(xd52(idxTest52),Yd52);
text(xloc,yloc,['y = ',num2str(Bd52(1)),' + ',num2str(Bd52(2)),'*x']);
scatter(xd52,yd52,sz);
hold off;title('52 kg Deadlift');
xlabel('First Deadlift (kg)');
ylabel('Best Deadlift (kg)');
xlim([0 400]);
ylim([0 400]);
 
subplot(2,4,3)
hold on;
plot(xd57(idxTest57),Yd57);
text(xloc,yloc,['y = ',num2str(Bd57(1)),' + ',num2str(Bd57(2)),'*x']);
scatter(xd57,yd57,sz);
hold off;title('57 kg Deadlift');
xlabel('First Deadlift (kg)');
ylabel('Best Deadlift (kg)');
xlim([0 400]);
ylim([0 400]);
 
subplot(2,4,4)
hold on;
plot(xd63(idxTest63),Yd63);
text(xloc,yloc,['y = ',num2str(Bd63(1)),' + ',num2str(Bd63(2)),'*x']);
scatter(xd63,yd63,sz);
hold off;
title('63 kg Deadlift');
xlabel('First Deadlift (kg)');
ylabel('Best Deadlift (kg)');
xlim([0 400]);
ylim([0 400]);
 
subplot(2,4,5)
hold on;
plot(xd72(idxTest72),Yd72);
text(xloc,yloc,['y = ',num2str(Bd72(1)),' + ',num2str(Bd72(2)),'*x']);
scatter(xd72,yd72,sz);
hold off;
title('72 kg Deadlift');
xlabel('First Deadlift (kg)');
ylabel('Best Deadlift (kg)');
xlim([0 400]);
ylim([0 400]);
 
subplot(2,4,6)
hold on;
plot(xd84(idxTest84),Yd84);
text(xloc,yloc,['y = ',num2str(Bd84(1)),' + ',num2str(Bd84(2)),'*x']);
scatter(xd84,yd84,sz);
hold off;
title('84 kg Deadlift');
xlabel('First Deadlift (kg)');
ylabel('Best Deadlift (kg)');
xlim([0 400]);
ylim([0 400]);
 
subplot(2,4,8)
hold on;
plot(xdshw(idxTestshw),Ydshw);
text(xloc,yloc,['y = ',num2str(Bdshw(1)),' + ',num2str(Bdshw(2)),'*x']);
scatter(xdshw,ydshw,sz);
hold off;
title('SHW Deadlift');
xlabel('First Deadlift (kg)');
ylabel('Best Deadlift (kg)');
xlim([0 400]);
ylim([0 400]);
 
%Evaluate model performance: plot actual vs predicted!
%Squats:
 
figure('units','normalized','outerposition',[0 0 1 1]);
 
subplot(2,4,1)
hold on;
scatter(ys47(idxTest47),Ys47,sz);
plot(ys47(idxTest47),ys47(idxTest47));
hold off;
title('47 kg Squat');
xlabel('Actual Best Squat');
ylabel('Predicted Best Squat');
 
 
subplot(2,4,2)
hold on;
scatter(ys52(idxTest52),Ys52,sz);
plot(ys52(idxTest52),ys52(idxTest52));
hold off;
title('52 kg Squat');
xlabel('Actual Best Squat');
ylabel('Predicted Best Squat');
 
 
subplot(2,4,3)
hold on;
scatter(ys57(idxTest57),Ys57,sz);
plot(ys57(idxTest57),ys57(idxTest57));
hold off;
title('57 kg Squat');
xlabel('Actual Best Squat');
ylabel('Predicted Best Squat');
 
 
subplot(2,4,4)
hold on;
scatter(ys63(idxTest63),Ys63,sz);
plot(ys63(idxTest63),ys63(idxTest63));
hold off;
title('63 kg Squat');
xlabel('Actual Best Squat');
ylabel('Predicted Best Squat');
 
subplot(2,4,5)
hold on;
scatter(ys72(idxTest72),Ys72,sz);
plot(ys72(idxTest72),ys72(idxTest72));
hold off;
title('72 kg Squat');
xlabel('Actual Best Squat');
ylabel('Predicted Best Squat');
 
subplot(2,4,6)
hold on;
scatter(ys84(idxTest84),Ys84,sz);
plot(ys84(idxTest84),ys84(idxTest84));hold off;
title('84 kg Squat');
xlabel('Actual Best Squat');
ylabel('Predicted Best Squat');
 
subplot(2,4,8)
hold on;
scatter(ysshw(idxTestshw),Ysshw,sz);
plot(ysshw(idxTestshw),ysshw(idxTestshw));
hold off;
title('SHW Squat');
xlabel('Actual Best Squat');
ylabel('Predicted Best Squat');
 
%Bench
 
figure('units','normalized','outerposition',[0 0 1 1]);
 
subplot(2,4,1)
hold on;
scatter(yb47(idxTest47),Yb47,sz);
plot(yb47(idxTest47),yb47(idxTest47));
hold off;
title('47 kg Bench');
xlabel('Actual Best Bench');
ylabel('Predicted Best Bench'); 
 
subplot(2,4,2)
hold on;
scatter(yb52(idxTest52),Yb52,sz);
plot(yb52(idxTest52),yb52(idxTest52));
hold off;
title('52 kg Bench');
xlabel('Actual Best Bench');
ylabel('Predicted Best Bench');
 
subplot(2,4,3)
hold on;
scatter(yb57(idxTest57),Yb57,sz);
plot(yb57(idxTest57),yb57(idxTest57));
hold off;
title('57 kg Bench');
xlabel('Actual Best Bench');
ylabel('Predicted Best Bench');
 
subplot(2,4,4)
hold on;
scatter(yb63(idxTest63),Yb63,sz);
plot(yb63(idxTest63),yb63(idxTest63));
hold off;
title('63 kg Bench');
xlabel('Actual Best Bench');
ylabel('Predicted Best Bench');
 
subplot(2,4,5)
hold on;
scatter(yb72(idxTest72),Yb72,sz);
plot(yb72(idxTest72),yb72(idxTest72));
hold off;
title('72 kg Bench');
xlabel('Actual Best Bench');
ylabel('Predicted Best Bench');
 
subplot(2,4,6)
hold on;
scatter(yb84(idxTest84),Yb84,sz);
plot(yb84(idxTest84),yb84(idxTest84));hold off;
title('84 kg Bench');
xlabel('Actual Best Bench');
ylabel('Predicted Best Bench');
  
subplot(2,4,8)
hold on;
scatter(ybshw(idxTestshw),Ybshw,sz);
plot(ybshw(idxTestshw),ybshw(idxTestshw));
hold off;
title('SHW Bench');
xlabel('Actual Best Bench');
ylabel('Predicted Best Bench');
 
%Deadlift
 
figure('units','normalized','outerposition',[0 0 1 1]);
 
subplot(2,4,1)
hold on;
scatter(yd47(idxTest47),Yd47,sz);
plot(yd47(idxTest47),yd47(idxTest47));
hold off;
title('47 kg Deadlift');
xlabel('Actual Best Deadlift');
ylabel('Predicted Best Deadlift');
 
 
subplot(2,4,2)
hold on;
scatter(yd52(idxTest52),Yd52,sz);
plot(yd52(idxTest52),yd52(idxTest52));
hold off;
title('52 kg Deadlift');
xlabel('Actual Best Deadlift');
ylabel('Predicted Best Deadlift');
 
 
subplot(2,4,3)
hold on;
scatter(yd57(idxTest57),Yd57,sz);
plot(yd57(idxTest57),yd57(idxTest57));
hold off;
title('57 kg Deadlift');
xlabel('Actual Best Deadlift');
ylabel('Predicted Best Deadlift');
 
 
subplot(2,4,4)
hold on;
scatter(yd63(idxTest63),Yd63,sz);
plot(yd63(idxTest63),yd63(idxTest63));
hold off;
title('63 kg Deadlift');
xlabel('Actual Best Deadlift');
ylabel('Predicted Best Deadlift');
 
subplot(2,4,5)
hold on;
scatter(yd72(idxTest72),Yd72,sz);
plot(yd72(idxTest72),yd72(idxTest72));
hold off;
title('72 kg Deadlift');
xlabel('Actual Best Deadlift');
ylabel('Predicted Best Deadlift');
 
subplot(2,4,6)
hold on;
scatter(yd84(idxTest84),Yd84,sz);
plot(yd84(idxTest84),yd84(idxTest84));hold off;
title('84 kg Deadlift');
xlabel('Actual Best Deadlift');
ylabel('Predicted Best Deadlift');
 
subplot(2,4,8)
hold on;
scatter(ydshw(idxTestshw),Ydshw,sz);
plot(ydshw(idxTestshw),ydshw(idxTestshw));
hold off;
title('SHW Deadlift');
xlabel('Actual Best Deadlift');
ylabel('Predicted Best Deadlift');
 
 
clear idxTest47 idxTest52 idxTest57 idxTest63 idxTest72 idxTest84 idxTestshw...
    idxTrain47 idxTrain52 idxTrain57 idxTrain63 idxTrain72 idxTrain84 idxTrainshw...
    Ys47 Ys52 Ys57 Ys63 Ys72 Ys84 Ysshw...
    Yb47 Yb52 Yb57 Yb63 Yb72 Yb84 Ybshw...
    Yd47 Yd52 Yd57 Yd63 Yd72 Yd84 Ydshw...
    ys47 ys52 ys57 ys63 ys72 ys84 ysshw...
    yb47 yb52 yb57 yb63 yb72 yb84 ybshw...
    yd47 yd52 yd57 yd63 yd72 yd84 ydshw...
    xs47 xs52 xs57 xs63 xs72 xs84 xsshw...
    xb47 xb52 xb57 xb63 xb72 xb84 xbshw...
    xd47 xd52 xd57 xd63 xd72 xd84 xdshw...
    c47 c52 c57 c63 c72 c84 cshw...
    n47 n52 n57 n63 n72 n84 nshw...
    Bs47 Bs52 Bs57 Bs63 Bs72 Bs84 Bsshw...
    Bb47 Bb52 Bb57 Bb63 Bb72 Bb84 Bbshw...
    Bd47 Bd52 Bd57 Bd63 Bd72 Bd84 Bdshw...
    divisnum equipnum event_equipment eventsum i km lam sz xloc yloc...
    clus47 clus52 clus57 clus63 clus72 clus84 clusshw event_equip...
    sexchoice equipchoice eventchoice divischoice;
 
disp('Data matrices are in the format [age; bw; s1; s2; s3; s; b1; b2; b3; b; d1; d2; d3; d; total; wilks; cluster]');
fprintf('\n');
 
toc;
end