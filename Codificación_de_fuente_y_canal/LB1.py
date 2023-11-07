import numpy as np
imagen = np.array([128,75,72,105,149,169,127,100,
          122,84,83,84,146,138,142,139,
          118,98,89,94,136,96,143,188,
          122,106,79,115,148,102,127,167,
          127,115,106,94,155,124,103,155,
          125,115,130,140,170,174,115,136,
          127,110,122,163,175,140,119,87,
          146,114,127,140,131,142,153,93])

M = len(set(imagen))  
cuenta =np.array([np.count_nonzero(imagen == imagen[n]) for n in range(M)])
Pi = cuenta/M
#print(Pi)
lista_ordenada = np.round(sorted(Pi, reverse= True),3)

print(lista_ordenada)

#Shannon - Fano

#Huffman