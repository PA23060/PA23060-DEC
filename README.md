Ejercicio 1: Resta de tres enteros 

El proposito de este ejercicio es poder ir aprendiendo concepros que son basicos de programacion en lenguaje ensamblador en este caso de ensamblador de 16 bits,
utilizando regitros del procesador como AX, BX, y CX.
El objetivo es desarrollar un programa sencillo que realice una operación de resta entre tres números enteros y muestre el resultado en pantalla, para realizarlo, utilizamos instrucciones fundamentales como MOV, SUB, INT 21H, y estructuras de entorno de programación para DOS, como .MODEL SMALL, .DATA, y .CODE.

registros utilizados                                                                                                                                        
AX  (16 bits): Usado como acumulador para hacer la resta. Se cargó el primer número (num1) y luego se fueron restando num2 y num3. También se reutilizó para la conversión a ASCII. 

EDI (32 bits): Usado como puntero para recorrer el buffer donde se almacena el número convertido a ASCII, de derecha a izquierda.      

CX  (16 bits): Se usó como base decimal (10) durante la conversión del número binario a texto ASCII.              

DX  (16 bits): Almacena el residuo (DL) durante la conversión a ASCII, y se convierte cada dígito a su carácter correspondiente sumándole '0'.    

EAX (32 bits): Usado para indicar el número de syscall (por ejemplo, 4 para write, 1 para exit).   

EBX (32 bits): Indica el descriptor del archivo (1 para stdout) en las llamadas al sistema.  

ECX (32 bits): Contiene la dirección del mensaje o número a imprimir.       

EDX (32 bits): Contiene la longitud de los datos que se van a imprimir (mensaje o número convertido).                                                                                    



Ejercicio 2: Multiplicacion 
En este caso la multiplcacion se cargan los valores desde memoria en registros y a utilizar la instrucción MUL, que multiplica el valor del registro AL por otro operando de 8 bits.

registros utilizados
AL (8 bits): para cargar el primer número y almacenar el resultado del MUL.

AX / EAX (16/32 bits): extendido desde AL para convertir el resultado.

EDI (32 bits): usado como puntero para colocar los caracteres ASCII en el buffer.

ECX, EDX (32 bits): para la conversión decimal a ASCII (div y residuo).

EBX (32 bits): para la syscall de impresión (write).

EAX (32 bits): para almacenar el código de syscall (4 para escribir, 1 para salir).


Ejercicio 3: Division

La division requiere requiere preparar los registros EAX y EDX correctamente, porque el dividendo se coloca en esos dos registros combinados.
Para convertir el cociente en una cadena de caracteres para que pueda ser mostrado por pantalla. 
Usé un búfer para almacenar la representación ASCII del resultado, y luego lo imprimí con llamadas al sistema.

regitros utilizados
EAX (32 bits): para colocar el dividendo y luego almacenar el cociente.

EDX (32 bits): se limpia antes de dividir; almacena el residuo después de la división.

ECX (32 bits): usado como base (10) para convertir el resultado a ASCII.

EDI (32 bits): como puntero al buffer donde se construye la cadena del número.

EBX (32 bits): para la syscall de impresión (write).

ECX, EDX: también se usan durante la conversión de número a ASCII con div.
