#%%
from scipy.special import erfc
from scipy.special import comb
import matplotlib.pyplot as plt
import numpy as np


# Codificador BHC(31,11) t=2
n1 = 31
k1 = 11
t1 = 2
Rc1 = k1/n1
yb_db = np.arange(6,21,1)
yb = 10**(yb_db/10)
yc = Rc1*yb
alpha1 = 1/2*erfc((2*yc)**0.5/2**0.5)
Pb = comb(n1-1,t1)*(alpha1**(t1+1))
indice_yb_db1 = np.where(Pb <= 1e-6)[0][0]

# Codificador BHC(63,39) t=4
y = 10^-6
n2 = 63
k2 = 39
t2 = 4
Rc2 = k2/n2
yc2 = Rc2*yb
alpha2 = 1/2*erfc((2*yc2)**0.5/2**0.5)
Pb2 = comb(n2-1,t2)*(alpha2**(t2+1))
indice_yb_db2 = np.where(Pb2 <= 1e-6)[0][0]

# Sin Codificador
Pub = erfc(yb**0.5)/2
indice_yb_db = np.where(Pub <= 1e-6)[0][0]

plt.figure(figsize=(8, 6))
plt.semilogy(yb_db, Pb, label='BHC(31,1)', color='blue')
plt.scatter(yb_db[indice_yb_db1], Pb[indice_yb_db1], color='blue',
             label=f'y=1e-6 en yb={yb_db[indice_yb_db1]}db')  # Marca el punto y=10^(-6)

plt.semilogy(yb_db, Pb2,label='BHC(63,39)', color='green')
plt.scatter(yb_db[indice_yb_db2], Pb2[indice_yb_db2], color='green',
             label=f'y=1e-6 en yb={yb_db[indice_yb_db2]}db')

plt.semilogy(yb_db, Pub,label='Sin Codificar', color='red')
plt.scatter(yb_db[indice_yb_db], Pub[indice_yb_db], color='red', 
            label=f'y=1e-6 en yb={yb_db[indice_yb_db]}db')
#plt.xscale("log")
plt.xlim(8,20)
plt.xlabel('yb SNR (db)')
plt.ylabel('Pb')
plt.title('Pb vs yb')
plt.legend()
plt.show()
#%%
from scipy.special import erfc
from scipy.special import comb
import matplotlib.pyplot as plt
from scipy.special import erfcinv
import numpy as np
import math 

#(10**(-6)/comb(31-1,2))**0.5
# Codificador BHC(31,11) t=2
n1 = 63
k1 = 39
t1 = 4
Rc1 = k1/n1
alpha1 = ((10**(-6))/comb(n1-1,t1))**(1/t1)
yc=(erfcinv(2*alpha1))**2
yb = yc/Rc1
10*math.log10(yb)
#Verificando valores para BHC()
# %%
from scipy.special import erfc
from scipy.special import comb
import matplotlib.pyplot as plt
from scipy.special import erfcinv
import numpy as np
import math 

alpha1 = 10**(-6)
yb=(erfcinv(2*alpha1))**2
10*math.log10(yb)
# %%
