clear all;

nnodes_layer1 = 5;
nnodes_layer2 = 6;

p1 =abs( 'AGTGAAGTGAAAAAGCTGCCAAGTGTCGGTAGTGAGCTGGAAAAAGCTGATCTGCCAAGTGTCGGTAGTGAAAAAGCTGATCTGCATCGTACGTAGTCAGCATCGTAGTCCTCAAGAGTACAAGTGTCGGTTGCCAAGTGTCGGTAGTGAAAAAGCTGATCTGCCAAGTGTCGGTAGTGAAAAAGCTGATCTGCCAAGTG')-64;
pp1 = get_trainingdata(p1);
p2 = abs('AGTACTACTACTATCAGTGCGACGTGACGTATCGTATGCTAGTTCGATGCGATCGATGTTAAACACGTAGGACCGTAACGTTACGTCAAACGTACGGACTTAGTCCTCAAGACGGCTAGCTTAGCGTCAGGTACTGACGCTAGCTCATGCGATGCTTAGAGCTAGGCTTTACGATGCCTAGTCGATGCGATTCGTAGCGT')-64;
pp2 = get_trainingdata(p2);
p3 = abs('ATGCATAGCATATATCGTATATCGCGCGGGCGTAGCTAGCTAGAGCTGTAGCTAGCTAGATGCCCTCGATCTCTTTCCTAGCTGCATGCTAGTCGTAGTGCTAGCTAGCTAGTACTCGTAGCTGCTAGCTAGTACGTAGATGCAGTGCAGCTAGCTAGCTAGCTAGCAGCTAGCTGTAGCTAGCTAGCTATATATGCTAA')-64;
pp3 = get_trainingdata(p3);
p4 = abs('AACGTATAGCGCGATGCTGATGCTATGCTGCTAGCGCGTAGCTAGCTGCTAGCTGATGCGTATACGCGATGCGCGTAGCTAGCTAATACGATCGCCGTATAGATACACCCAAGCACGTATCGATCGTAATGCATGCATAGCCGTCATCGATCGCATGCACGTCGACATGCACTATGCATCGATCGATACATGCATCATGC')-64;
pp4 = get_trainingdata(p4);
p5 = abs('AGCTAGTGCACTAATCGGTGACGACGTACATCGATGCATCATGCCGGAGCGTAGCAATGTTGACTGCAATTAGAFTCGATACTGCGATGCATGCACATGCGCATGCTATGCACGATGCAGCATCGACAGCACTGAGCATCGTACGAGCATCGTACTACGATACGATGCGACGTACATGCACGTACGAAAAAGTCCTCAAG')-64;
pp5 = get_trainingdata(p5);
p6 = abs('AGTCCTCAAGAACGTCAGCATGATGCAGTCGACGCATGCAGCTGCGTAGCAGTACAGCGACGTACGATCGACGCAGCGTACGTCGCGACGTCGATGAGACGTCAGTCTGTGTGTCGACTGCTAGCAGAGCTCATGCAACGTACACAAACGTGTCGTCTGACGTCAGCAGTGACGGACGTCAGTCGATCGTCGACGTCGAC')-64;
pp6 = get_trainingdata(p6);
p7 = abs('GACTTACGGCTAGCTTAGCGTCAGGTACTGACGCTAGCTCATAGCTAATACGATCGCCGTATAGATACACCCAAGCACGCATGCTAGTCGTAGTGCTAGCTAATGCATGCACATGCGCATGCTATGCACGATGCAGCATCGACAGCACTGAGCATCGTACGAGCATCGTACTACGATACGATGCGACGTACATGCACGAT')-64;
pp7 = get_trainingdata(p7);
p8 = abs('ATACGATGCATGTACGATGCATATATATAATCGAAAAACGTAGCTCGACATTAGCTGCTAGCATGCACGTAGATCTGATGATGCATGTAGCGGCTCTGCATGCTAGCTATATCCCAGCTACAGCTACTAATCGTAGTAGCGCATCGATGCTCGTAGCTAGCTATATGCCGGCGCATGCATTATACGGCTCTATATATACG')-64;
pp8 = get_trainingdata(p8);
p9 = abs('ACACTGATCTAGTTCGTAGGAATGCGATATCGATTAGCGCTAGCTATGAGCTGAGATTCATGATTGCCATATCGCCGAACGTAGCTATGCTCGATGCTAATGCGCCGCTTAGCGCCGATATTCGATGTAGCTGATCGTAGCTGATGCATTAGCGATGCTAGCTAGCTAGCTAGAGTCCTCAAGCTAGCTGCTAGCTAGCA')-64;
pp9 = get_trainingdata(p9);
p10 = abs('AGCTCGATATACGGCATCGTAGATATCGTAATTACGCGTAGCATAGCGATCGATGCAGCATGCTAGCATCGATCGTAGCTAGCTAGCTAGCTAGCTAGCTAGCTAGCTAGCTAGTATGACTCGTAGTCGATCTACTACGTACGTCGCCATCGATGCATGCTAGCTAGCTAGCTAGTAGCTACGATCGTACGATCGATCGT')-64;
pp10 = get_trainingdata(p10);
training_data=[pp1;pp2;pp3;pp4;pp5;pp6;pp7;pp8;pp9;pp10];  

targets = zeros(10,1);
targets(1) = get_target(pp1);
targets(2) = get_target(pp2);
targets(3) = get_target(pp3);
targets(4) = get_target(pp4);
targets(5) = get_target(pp5);
targets(6) = get_target(pp6);
targets(7) = get_target(pp7);
targets(8) = get_target(pp8);
targets(9) = get_target(pp9);
targets(10) = get_target(pp10);

[c1,n_inputs]=size(pp1);
[t1,n_targets]=size(targets);

W1p = (2*rand(nnodes_layer1,n_inputs)-1);
b1_vec =  -0.5*(rand(1)+1);


W21 = (2*rand(nnodes_layer2,nnodes_layer1)-1);
b2_vec = -0.5*(rand(1)+1);


W32 = (2*rand(n_targets,nnodes_layer2)-1);
b3_vec = -0.5*(rand(1)+1);


eta = 0.001;
iteration = 0;
record_err = [];
outputs =[];
record_eta=[];
while(iteration<50000)
    iteration=iteration+1;

    outputs=err_eval(W1p,b1_vec,W21, b2_vec,W32,b3_vec,training_data,targets,layer_matrix)
     
    [dW32,dW21,dW1p] = compute_W_derivs2(W1p,b1_vec,W21, b2_vec,W32,b3_vec,training_data,targets);
    
   W1p = W1p-eta*dW1p;
   W21 = W21-eta*dW21;
   W32 = W32-eta*dW32;
    
    
    [new_rmserr,outputs_k]=err_eval(W1p,b1_vec,W21, b2_vec,training_data,targets)
    
    record_err(iteration) = new_rmserr;
    outputs(:,iteration) = outputs_k;
    
    
     if (new_rmserr<rmserr)
            eta=1.1*eta
             if (eta>1)
               eta=1;
             end
        else
            eta = 0.5*eta;
     end
   record_eta(iteration) = eta;
end
figure(1)
plot(outputs);
saveas(gcf,'outputs.jpg');
save rmserr.mat record_err;
save W1p.mat W1p;
save W21.mat W21;
