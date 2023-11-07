palabras = []; %matriz de palabras
palabra = [];
A = [];
B = [];
C = 0;
SXOR = 0;

A = [1 1 0 1 1 1 0 0 1 0 1 0 0 0 0 0 1 1 1 1 1 0 1 0 1 0];

%Matriz P:
P = [1 1 0 0 0;
     1 0 1 0 0;
     0 1 1 0 0;
     1 1 1 0 0;
     1 0 0 1 0;
     0 1 0 1 0;
     1 1 0 1 0;
     0 0 1 1 0;
     1 0 1 1 0;
     0 1 1 1 0;
     1 1 1 1 0;
     1 0 0 0 1;
     0 1 0 0 1;
     1 1 0 0 1;
     0 0 1 0 1;
     1 0 1 0 1;
     0 1 1 0 1;
     1 1 1 0 1;
     0 0 0 1 1;
     1 0 0 1 1;
     0 1 0 1 1;
     1 1 0 1 1;
     0 0 1 1 1;
     1 0 1 1 1;
     0 1 1 1 1;
     1 1 1 1 1]; %size: kxq

%fprintf('0')
for i=1:(26):26
    %A = mensaje(i:i+25);
    palabras = [palabras A];
    
    for j=1:5
        B = P(1:26,j)';
        %disp(B)
        C = A.*B;
        %disp(C)
        %SXOR = 0;
        disp(SXOR)
        for l=1:26
            if (j==5)
                fprintf('%1.0f xor %1.0f',SXOR,C(l))
            end
            SXOR = xor(SXOR,C(l));
            if (j==5)
                fprintf('= %1.0f',SXOR)
                fprintf('\n')
            end
        end
        %disp(SXOR)
        palabras = [palabras SXOR];
        SXOR=0;
    end
    
    A = [];
    B = [];
    C = [];
    
end