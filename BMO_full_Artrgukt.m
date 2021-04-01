  %this is PHASE 1 just create bots and intensity on sinewave
  close all;
  clc;
  clear;
  
  pp =input('no. of peaks :');
  nn = 6.6*pp+1;
  x = 0:0.03:nn;
  y = 5*sin(x);
  peaks = zeros(pp,2);
   
  %FINDING PEAK VALUE OF SINE WAVE 
    p = 0;
  y3 = 0;
  for(i=0:0.1:10)
      y2 = 5*sin(i);
      if(y3 <= y2)
          p = i;
          y3 = y2;
      end
  end
  z = 5*sin(p);
  peaks(pp+1,1) = p;
  peaks(pp+1,2) = z;
 
  
  p2 = zeros(1,pp);
  z2 = zeros(1,pp);
  for i=1:1:pp
      p2(i) = p+(2*i*pi);
      z2(i) = 5*sin(p2(i));
      peaks(i,1) = p2(i);
      peaks(i,2) = z2(i);
      
  end
 

  
  in = input('enter the number of bots :');
  X = zeros(in+1+pp,2);
  X1 = zeros(in+1,2);
  
  range = nn/in;
  int = zeros(1,in);
  m=1;
  for(k=1:range:nn)
         int(m) = k;
         m = m + 1;
  end
  for(i=1:1:in)
      po = int(i);
      y1 = 5*sin(po);
      X1(i,1) = po;
      X1(i,2) = y1;
      
  end
  
  X1(in+1,1) = p;
  X1(in+1,2) = z;
  X1;
  X2 = zeros(pp,2);
 
  for i=1:1:pp
      X2(i,1) = p2(i);
      X2(i,2) = z2(i);
  end
  X2;
  
  X = [X1;X2]; 

  it = input('No. of Iteration : ');
  swarm = zeros(in,2,it);
 for(ii=1:1:it)
      %this is PHASE2 uv updation of each bot
  uv = zeros(1,in+(pp+1));
  for(i=1:1:in+(pp+1))
      uv(i) = max(0,0.5*uv(i) + 10*X(i,2));
  end

  
  
  %this is PHASE3 uv distribution of each  bot
  d = zeros(in+(pp+1),in+(pp+1));
  for(i=1:1:in+(pp+1))
      for(j=1:1:in+(pp+1))
          if(i~=j)
          d(i,j) = abs(X(i,1) - X(j,1));
          end
      end
  end
  d;
  
  uvd = zeros(in+(pp+1),in+(pp+1));
  for(i=1:1:in+pp+1)
      for(j=1:1:in+pp+1)
          if(i~=j)
          uvd(i,j) = uv(i) .* (  inv(d(i,j)) / inv(sum(d(i,:)))  );
          end
      end
  end
  
  uvd;
  
 %this is PHASE4 Choosing LMATE
  lm = zeros(1,in);
uvfake = uv;
  for(i=1:1:in)
     for(j=1:1:in+(pp+1))
         if uvfake(i) <= uvd(j,i)
             uvfake(i) = uvd(j,i);
             lm(i) = j;
         end
     end
  end
  lm;
  
  
  %this is PHASE5 update bot position
  X ;
 for(i=1:1:in)
     num =  ( X(lm(i),1)-X(i,1) );
     den = sqrt( X(lm(i),1)^2 + X(i,1)^2 );
     X(i,1) = X(i,1) + ( 0.5 * ( num / den ) );
     X(i,2) = 5*sin(X(i,1));
     swarm(i,1,ii) = X(i,1);
     swarm(i,2,ii) = X(i,2);
 end



 end
 
 %% plotting section
 
 
 for(i = 1:1:it)
     
      clf;
      plot(x,y);
      hold on;
      xlim([0 nn]);                                 
      ylim([-6 6]);
      plot(swarm(1:in,1,i),swarm(1:in,2,i),'r*');
      pause(0.1);
     
end
 
fprintf('Maximum intensity on sinwave is : %d',X(in+(pp+1),2));

        
  
  
         
                  
          
  
          
  
  
  
  
  
  
  
  