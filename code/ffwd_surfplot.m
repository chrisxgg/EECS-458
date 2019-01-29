function ffwd_surfplot(W1p,b1_vec,W21, b2_vec)
xvals=[0:0.1:1];
yvals=[0:0.1:1];
Z=zeros(11,11); %holder for 11x11 grid of outputs
for (i=1:11)
    for(j=1:11)
        stim = [1;xvals(i);yvals(j)]; %stimulate network at this set of inputs, including bias
        [outputj,outputk]=eval_2layer_fdfwdnet(W1p,b1_vec,W21, b2_vec,stim);
    outputs(p)=outputk;
     Z(i,j)= outputk(1);
    end
end
surf(xvals,yvals,Z)