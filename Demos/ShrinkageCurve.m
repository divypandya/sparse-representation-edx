% OUR OBJECTIVE: Minimizing the scalar function 
%                   f(x) = 0.5(x-a)^2+lambda*rho(x)
%                w.r.t. x, where a is a parameter. 
% 
%                Observation: Clearly, the choice of rho(x) 
%                             influences the solution obtained
% 
%% ============================================================ 
% We create one of several optional rho(x) functions - all 
% promoting sparsity in one way or another
x=-10:0.01:10; 
a=-7:0.05:7;
lambda=3;
% choice='L1'; 
choice='L0'; 
% choice='log'; 
% choice='ratio'; 
% choice='Gaussian'; 
switch choice
    case{'L1'}
        rho=abs(x);
    case{'L0'}
        rho=abs(x).^0.01;  
    case{'log'}
        rho=log(1+abs(x)); 
    case{'ratio'}
        rho=abs(x)./(1+abs(x)); 
    case{'Gaussian'}
        rho=1-exp(-abs(x).^2/2); 
end
figure(1); clf; 
h=plot(x,rho,'r'); 
set(h,'LineWidth',2); 
title('The \rho(x) function');
set(gca,'FontName','Tahoma','FontSize',14); 

%% ============================================================ 
% we create the function 0.5(x-a)^2+lambda*rho(x), where a is an 
% input parameter, and we search the x minimizning this function. 
% We sweep through all the a's in the range -7 to 7, and this way 
% get the shrinkage curve

minvec=zeros(length(a),1); 
h=figure(2); clf; 
set(h,'units','normalized');
set(h,'Position',[0 0 1 1 ]);
pause(5); 
for k=1:1:length(a)
    f=0.5*(x-a(k)).^2+lambda*rho;
    h=plot(x,f,'r'); set(h,'LineWidth',2);
    axis([-10 10 0 100]); 
    hold on; 
    h=plot([a(k),a(k)],[0 100],'g'); set(h,'LineWidth',2);
    pos=find(f==min(f));
    minvec(k)=x(pos); 
    h=plot(x(pos),f(pos),'ob'); 
    set(h,'MarkerFaceColor','b'); 
    legend('The function','the value of a','The minimum point');
    hold off; 
    set(gca,'FontName','Tahoma','FontSize',14); 
    drawnow; 
end

%% ============================================================   
% Plot the resulting shrinkage curve

figure(3); clf;
h=plot(a,minvec); 
set(h,'LineWidth',3);
grid on; axis image;
hold on;
plot(a,a,'--r');
axis([-7 7 -7 7]);
xlabel('a'); 
ylabel('x_{opt}'); 
set(gca,'FontName','Tahoma','FontSize',14); 


