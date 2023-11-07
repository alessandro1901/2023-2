% Función que brinda los valores del sampling and holding
function lista = salida_demodulador(data, ruido)
    % Lista que asigna los valores de sampling and holding sin ruido
    for i=1:1:length(data)
        if data(i)==1
            salida(i)=1;
        elseif data(i)==0
            salida(i)=-1;
        end
    end
    % Suma de la salida con el ruido gaussiano
    lista = salida + ruido;
end