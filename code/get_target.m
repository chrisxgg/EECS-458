function targets = get_target(pp)
M = size(pp)
t=0;
a=0;
pp
for j = 1:M(2)-5
        a=a+1;
        if (pp((j)) == 1) && (pp((j+1)) == 3) && (pp((j+2)) == 4) && (pp(j+3) == 2) && (pp(j+4) == 2) && (pp(j+5)==4) && (pp(j+6)==2) && (pp(j+7)==1) && (pp(j+8)==1) && (pp(j+9)==3)
        t=1;
       end
end
targets=t;
