function pp = transt_wton(p)
N = size(p);
for i=1:N(2)
    switch p(i)
        case 'A'
            p(i) = 1;
        case 'C'
            p(i) = 2;
        case 'G'
            p(i) = 3;
        case 'T'
            p(i) = 4;
        otherwise
            p(i) =5;
    end
end
pp=p;