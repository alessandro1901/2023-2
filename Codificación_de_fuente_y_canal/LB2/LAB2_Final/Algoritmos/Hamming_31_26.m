% Función para codificar en Hamming(31,26)
function palabras=Hamming_31_26(mensaje)
    n=31; k=26; q=5;
    
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

    palabras = []; %vector de palabras
    A = [];
    B = [];
    C = [];
    SXOR = 0;
    for i=1:(k):length(mensaje)
        A = mensaje(i:i+25);
        palabras = [palabras A];
        for j=1:5
            B = P(1:26,j)';
            C = A.*B;
            for l=1:26
                SXOR = xor(SXOR,C(l));
            end
            palabras = [palabras SXOR];
            SXOR = 0;
        end
        A = [];
        B = [];
        C = [];
    end
end