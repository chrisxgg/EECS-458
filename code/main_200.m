clear all;

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
[p,n_targets]=size(targets);

layer = 2
layer_matrix=zeros(layer,1);
layer_matrix(1) = 20;
layer_matrix(layer)=n_targets;

W_matrix = cell(layer,1);
W_matrix{1}= (2*rand(layer_matrix(1),n_inputs)-1);
for l=2:layer
    W_matrix{l} = (2*rand(layer_matrix(l),layer_matrix(l-1))-1);
end
    
bias_matrix = zeros(layer,1);
for b=1:layer
    bias_matrix(b)=-0.5*(rand(1)+1);
end

eta = 0.001;
iteration = 0;
record_err = [];
record_rmserr=[];
record_outputs =[];
record_eta=[];
while(iteration<50000)
    iteration=iteration+1;
    rmserr=err_eval(W_matrix,bias_matrix,training_data,targets,layer_matrix);
    dW_matrix = compute_W_derivs2(W_matrix,bias_matrix,training_data,targets,layer_matrix);
    
    for i=1:layer
        W_matrix{i}=W_matrix{i}-eta*dW_matrix{i};
    end
    [new_rmserr,outputs,err]=err_eval(W_matrix,bias_matrix,training_data,targets,layer_matrix);

    record_rmserr(iteration) = new_rmserr;
    record_outputs(:,iteration) = outputs;
    record_err(:,iteration)=err;
    
     if (new_rmserr<rmserr)
            eta=1.1*eta
             if (eta>1)
               eta=1;
             end
        else
            eta = 0.5*eta;
     end
   record_eta(iteration) = eta;
   rmserr
end
figure(1)
plot(record_outputs);
saveas(gcf,'outputs.jpg');
save record_outputs.mat record_outputs;
save record_err.mat record_err;
save record_rmserr.mat record_rmserr;
for j=1:layer
    data=W_matrix{j};
    eval(['save data'],num2str(j));
end

