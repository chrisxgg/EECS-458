function pp=get_trainingdata(p)
N = size(p);
for i=1:N(2)
    switch p(i)
        case 1  
            p(i) = 1;
        case 3 
            p(i) = 2;
        case 7  
            p(i) = 3;
        case 20
            p(i) = 4;
        otherwise
            p(i) =5;
    end
    end
pp=p;