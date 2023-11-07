clc; clear all; close all;

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

%Matriz Iq:

Iq = eye(q);
    
%Matriz H^T:

Ht = [P;Iq];

%Tabla Sindrome:
S1 = [zeros(1,5);Ht];

S2 = [zeros(1,31);eye(31)];

S = [S1 S2]; %tabla S vs. E

for i=1:32
    fprintf('%1.0f',S(i,1:36))
    fprintf('\n')
end

A = [];
B = [];
C = [];
s = [];
X = [1 1 0 0 1 1 1 0 1 0 1 0 1 0 0 1 1 0 0 1 0 1 0 0 1 1 0 1 1 1 1];
Y = [1 1 0 0 1 1 1 0 1 0 1 0 1 0 0 1 1 0 0 1 0 1 0 0 1 1 0 1 1 1 0];
SXOR = 0;

for i=1:(31):31%1192322
    A = Y(i:i+30);
    for j=1:5
        B = Ht(1:31,j)';
        C = A.*B;
        for l=1:31
            SXOR = xor(SXOR,C(l));
        end
        s = [s SXOR];
        SXOR = 0;
    end
    A = [];
    B = [];
    C = [];
    
end

Casos = [];

A = [];

for i=1:32
    A = S(i,1:5);
    B = string(A(1))+string(A(2))+string(A(3))+string(A(4))+string(A(5));
    Casos = [Casos B];
end

%disp(Casos);

E_est = [];

for i=1:31:31
    s1 = string(s(i,1))+string(s(i,2))+string(s(i,3))+string(s(i,4))...
        +string(s(i,5));
    switch s1
        case Casos(1)
            E_est = [E_est S(1,6:36)];
        case Casos(2)
            E_est = [E_est S(2,6:36)];
        case Casos(3)
            E_est = [E_est S(3,6:36)];
        case Casos(4)
            E_est = [E_est S(4,6:36)];
        case Casos(5)
            E_est = [E_est S(5,6:36)];
        case Casos(6)
            E_est = [E_est S(6,6:36)];
        case Casos(7)
            E_est = [E_est S(7,6:36)];
        case Casos(8)
            E_est = [E_est S(8,6:36)];
        case Casos(9)
            E_est = [E_est S(9,6:36)];
        case Casos(10)
            E_est = [E_est S(10,6:36)];
        case Casos(11)
            E_est = [E_est S(11,6:36)];
        case Casos(12)
            E_est = [E_est S(12,6:36)];
        case Casos(13)
            E_est = [E_est S(13,6:36)];
        case Casos(14)
            E_est = [E_est S(14,6:36)];
        case Casos(15)
            E_est = [E_est S(15,6:36)];
        case Casos(16)
            E_est = [E_est S(16,6:36)];
        case Casos(17)
            E_est = [E_est S(17,6:36)];
        case Casos(18)
            E_est = [E_est S(18,6:36)];
        case Casos(19)
            E_est = [E_est S(19,6:36)];
        case Casos(20)
            E_est = [E_est S(20,6:36)];
        case Casos(21)
            E_est = [E_est S(21,6:36)];
        case Casos(22)
            E_est = [E_est S(22,6:36)];
        case Casos(23)
            E_est = [E_est S(23,6:36)];
        case Casos(24)
            E_est = [E_est S(24,6:36)];
        case Casos(25)
            E_est = [E_est S(25,6:36)];
        case Casos(26)
            E_est = [E_est S(26,6:36)];
        case Casos(27)
            E_est = [E_est S(27,6:36)];
        case Casos(28)
            E_est = [E_est S(28,6:36)];
        case Casos(29)
            E_est = [E_est S(29,6:36)];
        case Casos(30)
            E_est = [E_est S(30,6:36)];
        case Casos(31)
            E_est = [E_est S(31,6:36)];
        case Casos(32)
            E_est = [E_est S(32,6:36)];
    end

end

% E_est = [];
% 
% switch s1
%     case Casos(1)
%         E_est = S(1,6:36);
%     case Casos(2)
%         E_est = S(2,6:36);
%     case Casos(3)
%         E_est = S(3,6:36);
%     case Casos(4)
%         E_est = S(4,6:36);
%     case Casos(5)
%         E_est = S(5,6:36);
%     case Casos(6)
%         E_est = S(6,6:36);
%     case Casos(7)
%         E_est = S(7,6:36);
%     case Casos(8)
%         E_est = S(8,6:36);
%     case Casos(9)
%         E_est = S(9,6:36);
%     case Casos(10)
%         E_est = S(10,6:36);
%     case Casos(11)
%         E_est = S(11,6:36);
%     case Casos(12)
%         E_est = S(12,6:36);
%     case Casos(13)
%         E_est = S(13,6:36);
%     case Casos(14)
%         E_est = S(14,6:36);
%     case Casos(15)
%         E_est = S(15,6:36);
%     case Casos(16)
%         E_est = S(16,6:36);
%     case Casos(17)
%         E_est = S(17,6:36);
%     case Casos(18)
%         E_est = S(18,6:36);
%     case Casos(19)
%         E_est = S(19,6:36);
%     case Casos(20)
%         E_est = S(20,6:36);
%     case Casos(21)
%         E_est = S(21,6:36);
%     case Casos(22)
%         E_est = S(22,6:36);
%     case Casos(23)
%         E_est = S(23,6:36);
%     case Casos(24)
%         E_est = S(24,6:36);
%     case Casos(25)
%         E_est = S(25,6:36);
%     case Casos(26)
%         E_est = S(26,6:36);
%     case Casos(27)
%         E_est = S(27,6:36);
%     case Casos(28)
%         E_est = S(28,6:36);
%     case Casos(29)
%         E_est = S(29,6:36);
%     case Casos(30)
%         E_est = S(30,6:36);
%     case Casos(31)
%         E_est = S(31,6:36);
%     case Casos(32)
%         E_est = S(32,6:36);
% end
% 
% %disp(E_est)
% 
% %X estimado:

X_est = [];

for i=1:31:31
    X_est = [X_est xor(Y(i,1:31),E_est(i,1:31))];
end

disp(X_est)

disp(length(find(X(1,1:31)==X_est(1,1:31))))