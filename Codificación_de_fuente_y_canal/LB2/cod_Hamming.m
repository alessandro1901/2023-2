function cod = cod_Hamming(M)
n = 7;
k = 4;
q = n - k;
%M = randi([0,1],1,k);
Ik = eye(k);
P = [1 0 1;
     1 1 1;
     1 1 0;
     0 1 1];
cod = []; %vector de cod
A = [];
B = [];
C = [];
SXOR = 0;
for i=1:(k):length(M)
    A = mensaje(i:i+25);
    cod = [cod A];
    for j=1:5
        B = P(1:26,j)';
        C = A.*B;
        for l=1:26
            SXOR = xor(SXOR,C(l));
        end
        cod = [cod SXOR];
        SXOR = 0;
    end
    A = [];
    B = [];
    C = [];
end
end