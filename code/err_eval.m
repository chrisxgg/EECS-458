function [rmserr,outputs,err]= err_eval(W_matrix,bias_matrix,training_data,targets,layer_matrix)
temp =size(targets); 
npats=temp(1);    
noutputs=temp(2); 
outputs=zeros(npats,noutputs);
esqd=0;
err=[];
temp=size(layer_matrix);
k=temp(1);
for i=1:npats
   
   stim_vec=training_data(i,:)';
   output =eval_2layer_fdfwdnet(W_matrix,bias_matrix,stim_vec,layer_matrix);
   errvec=output{k}-targets(i,:); 
   esqd=esqd+errvec'*errvec;
   outputs(i,:) = output{k};
   %err(i,:) = errvec;
end
  disp(esqd); 
  rmserr=sqrt(esqd/npats);
 