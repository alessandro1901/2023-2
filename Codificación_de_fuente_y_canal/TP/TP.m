k1 = 11;
k2 = 39;
n1 = 31;
n2 = 63;
q1 = n1 - k1;
q2 = n2 - k2;
t1 = 2;
t2 = 4;
Rc1 = k1/n1;
Rc2 = k2/n2;
yb = 8:0.1:20;
yc = Rc1*yb;
yc2 = Rc2*yb;
alpha1 = erfc(yc.^0.5)/2;
alpha2 = erfc(yc2.^0.5)/2;
Pb = nchoosek(n1-1,t1)*(alpha1.^(t1));
Pb2 = nchoosek(n2-1,t2)*(alpha2.^(t2));

figure()
hold on
plot(yb, Pb)
plot(yb, Pb2)
%xscale("log")
xlabel('yc (db)')
ylabel('Pb')
title('Pb vs yb')
legend()
%grid(True)
hold off
%semilogx(pb)
