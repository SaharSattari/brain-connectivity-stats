%%%%%%%%%%%%%%%%%%
%Computation of network characteristics
%%%%%%%%%%%%%%%%%%
%Sahar 2023-09-26

function [rw1,rw2] = graphfeatures(Tauij1,Tauij2)

% Compute Node Degrees:
    for counter = 1: size(Tauij1,1)
%calculate pearson using function with this input: Tauij1(counter,:,:) and
%this output: rw1(counter)
        rw1(counter) = pearsonW(squeeze(Tauij1(counter,:,:)));
    end
    for counter = 1: size(Tauij2,1)
        rw2(counter) = pearsonW(squeeze(Tauij2(counter,:,:)));
    end



%Old version before using pearsonW.m 
%Inputs:
% absolute normalized informaiton flow values with main dig = 0

%Outputs:
% node degrees for each group 
%degree assortativity coefficient for each network

  %function [InDegree1, InDegree2, OutDegree1,OutDegree2, r_W1,r_W2] = graphfeatures(Tauij1,Tauij2)

%     % Compute Node Degrees:
%     for counter = 1: size(Tauij1,1)
%         for source = 1:10
%             InDegree1(counter,source) = sum(Tauij1(counter,:,source));
%             OutDegree1(counter,source) = sum(Tauij1(counter,source,:));
%         end
%     end
%     for counter = 1: size(Tauij2,1)
%         for source = 1:10
%             InDegree2(counter,source) = sum(Tauij2(counter,:,source));
%             OutDegree2(counter,source) = sum(Tauij2(counter,source,:));
%         end
%     end
% 
% 
%     % Calculate rw
%     %first group
%     paired_out_degrees1 = [];
%     paired_in_degrees1 = [];
%     for counter = 1: size(Tauij1,1)
%         for i = 1:10
%             for j = 1:10
%                 if i ~= j
%                     paired_out_degrees1 = [paired_out_degrees1, OutDegree1(counter,i)];
%                     paired_in_degrees1 = [paired_in_degrees1, InDegree1(counter,j)];
%                 end
%             end
%         end
% 
%         % Compute the Pearson correlation for the paired degrees
%         r_W1(counter) = corr(paired_out_degrees1', paired_in_degrees1'); 
%     end
% 
%      %second group
%     paired_out_degrees2 = [];
%     paired_in_degrees2 = [];
%     for counter = 1: size(Tauij2,1)
%         for i = 1:10
%             for j = 1:10
%                 if i ~= j
%                     paired_out_degrees2 = [paired_out_degrees2, OutDegree2(counter,i)];
%                     paired_in_degrees2 = [paired_in_degrees2, InDegree2(counter,j)];
%                 end
%             end
%         end
% 
%        %  Compute the Pearson correlation for the paired degrees
%         r_W2(counter) = corr(paired_out_degrees2', paired_in_degrees2'); 
%    end


end

