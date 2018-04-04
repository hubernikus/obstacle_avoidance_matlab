function [ obs ] = calculate_dynamic_center( obs, x_obs_sf )
% 
%

if nargin<10;
    % Margin where it starts to influence the dynamic center
    marg_dynCenter = 1.2;
end

% Number of obstacles
weight_obs = length(obs);

% Calculate distance between obstacles
dist_obs = zeros(N_obs);

% Reference Distance

for ii = 1:N_obs
    for jj = ii+1:N_obs
        ref_dist = marg_dynCenter*max(obs{ii}.a)*max(obs{jj}.a);
        %ref_dist(ii,jj) = ref_dist(jj,ii); % symmetric
        
        % Center around ii-obs
        x_obs_temp = (x_obs_sf(:,:,jj)-obs{ii}.x0);
        
        % Inside consideration region
        % TODO - second power. Does another one work to?! it should...
        ind = sum(x_obs_temp.^2,1)< ref_dist+max(obs{ii}.a);
        
        x_obs_temp = x_obs_temp(:,ind);
        N_inter = size(x_obs_temp,3);
        
        % Change increment step
        N_gamma = 3;
        dist_step = (ref_dist)/(N_gamma-1);
        dist_0 = 0;
        
        % Default value greater than 1
        n_intersection = N_gamma;

        % Tries to find the distance to ellipse
        while(n_intersection>1) 
            for it_gamma = 1:N_gamma
                delta_d = 
                Gamma = sum( ( 1/obs{ii}.sf*R'*(x_obs_temp - repmat(obs{ii}.x0,1,N_inter) )./ ...
                        repmat( (obs{it_obs2}.a+dist_0+it_gamma*dist_step) , 1, ii) ).^(2*obs{ii}.p), 1);
                n_intersection = sum(Gamma<1);
                
                % Intersection found
                if n_intersectinon
                    dist_0 = (it_gamma-1)*dist_step;
                    dist_step = dist_step/(N_gamma-1);
                    break;
                end
            end
        end
        
        weight_obs(ii,jj) = G;
        
    end
end

end