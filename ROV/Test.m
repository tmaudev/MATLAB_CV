clear;

phi = [1       exp(-1) exp(-1) exp(-2);
       exp(-1) 1       exp(-2) exp(-1);
       exp(-1) exp(-2) 1       exp(-1);
       exp(-2) exp(-1) exp(-1) 1      ];
   
phi_inverse = inv(phi);

d = [1; 0; 0; 1];

w = phi_inverse * d;