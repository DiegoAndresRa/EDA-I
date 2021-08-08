'''
proyectoFinalPython
Created by Ramirez Garcia Diego Andre in 05/08/2021
Version 1.0
'''
# Variables globelales
infectados = 0
negativos = 0
positivos = 0
op = '0'
pruebas = []
muestra = []
rangosEdades = []

# Función detectar número de infectados y no infectados
def calIndicador(pruebas):
    global infectados
    global negativos
    global positivos
    for i in pruebas:
        if i < 0.8:
            negativos = negativos + 1 # Indica el número de personas NO infectadas
        else:
            positivos = positivos + 1 # Indica el número de personas SI 
    infectados = positivos

# Función calcúlar el promédio de la edad de los infectados
def promedioEdades(content): 
    sumaEdades = 0
    # Moviendonos en el archivo.csv
    for row in content: 
        #Auxiliar para la extracción de datos
        ax1 = row # Asignando el [0] en la lista ax
        ax3 = ax1.split(",") # Separandola la cadena [0] de content 
        # Separando datos extraidos por edad e indicador
        edad = int(ax3[0])
        indicador = float(ax3[1])
        if indicador >= 0.8:
            sumaEdades = sumaEdades + edad
    global infectados            
    totalEdades = sumaEdades / infectados
    print("El promedio de la edad: ", round(totalEdades,2)) # Limitando los decimales con round(variable,limite)


def baseDeDatos (content):
        global pruebas
        global rangosEdades
        # Moviendonos en el archivo.csv
        for row in content: 
            #Auxiliar para la extracción de datos
            ax = row # Asignando el [0] en la lista ax
            ax2 = ax.split(",") # Separandola la cadena [0] de content 

            # Separando datos extraidos por edad e indicador
            edad = int(ax2[0])
            indicador = float(ax2[1])

            # Guardando en listas diferentes
            pruebas.append(indicador) #------------>Clave (1)
            rangosEdades.append(edad)   

# Leyendo archivo.csv
file = open('MUESTRA.csv','r')
content = file.readlines()
file.close()

# Menú
while (op != '4'):
    # Limpiar Pantalla
    import os
    os.system("clear")
    # Mensaje de Bienvenida
    print("\n\t\t\t\t\t\tIndicador de Color de Semaforo COVID\n")
    print(" 1) Ingresar Muestra\n 2) Calcular Semáforo COVID\n 3) Calcular edad promedio de las personas con COVID\n 4) Salir\n")
    op = input("Elige una Opción: ")
    # Reseteador
    pruebas = [0]
    rangosEdades = [0]
    # Llmando a la función para acceder a los datos de la bd.csv
    baseDeDatos(content)

    if op =='1':
        # Limpiar Pantalla
        os.system("clear")
        # Mensaje de Bienvenida
        print("\n\t\t\t\t\t\t\t    Indicador de Color de Semaforo COVID\n")
        print(" \t\t\t\t\t\t\t     Ingresaste a: 1) Ingresar Muestran")

        # Base de Datos CSV ---> Muestra de 100 individuos
        edad = int(input("Edad: "))
        indicador = float(input("Indicador: ")) #------------>Clave (1)

        persona = str(edad) + "," + str(indicador) + "\n"
        muestra.append(persona)

        # Almacenando en mi archivo.csc
        file = open("MUESTRA.csv","a")
        file.writelines(muestra)
        file.close()
        # Leyendo de nuevo el archivo.csv para refrescar content
        file = open('MUESTRA.csv','r')
        content = file.readlines()
        file.close()
        # Llmando a la función para acceder a los datos de la bd.csv y actualizar
        baseDeDatos(content)

    elif op == '2':
        # Reseteando valores para evitar repetición en los valores
        infectados = 0
        negativos = 0
        positivos =0
        calIndicador(pruebas) #------------>Clave (1)
        # Limpiar Pantalla
        os.system("clear")
        # Mensaje de Bienvenida
        print("\n\t\t\t\t\t\tIndicador de Color de Semaforo COVID\n")
        print(" \t\t\t\t\t      Ingresaste a: 2) Calcular Semaforo COVID\n")
        # Calculando el color del semáforo COVID
        if infectados == 0:
            input("\rEl semáforo es VERDE: 0 individuos con COVID" + "\n\nPresiona ENTER para ir al Menú ")
        elif 1 <= infectados <= 30:
            input("El semáforo es Amarillo: " + str(infectados) + " individuos con COVID" + "\n\nPresiona ENTER para ir al Menú ")
        elif 31 <= infectados <= 70:
            input("El semáforo es Naranja: " + str(infectados) + " individuos con COVID" + "\n\nPresiona ENTER para ir al Menú ")
        elif infectados >= 71:
            input("El semáforo es Rojo: " + str(infectados) + " individuos con COVID" + "\n\nPresiona ENTER para ir al Menú ")
        else:
            print("\n")
    
    elif op =='3':
        # Reseteando valores para evitar repetición
        infectados = 0
        negativos = 0
        positivos =0
        # Permite saber la cantidad de infectados aún si no se ha ejecutado el paso anterior
        calIndicador(pruebas) #------------>Clave (1)
        # Limpiar Pantalla
        os.system("clear")
        # Mensaje de Bienvenida
        print("\n\t\t\t\t\t\tIndicador de Color de Semaforo COVID\n")
        print(" \t\t\t\tIngresaste a: 3) Calcular edad promedio de las personas con COVID")
        if infectados == 0:
            print("\n\t\t\t\t\t\t       ** No hay infectados **")
        else:
            print("\n")
            promedioEdades(content) #------------>Clave (1)

        input("\nENTER para ir al Menú ")

    elif op =='4':
        # Limpiar Pantalla
        os.system("clear")
        print("\n\t\t\t\t\t\tIndicador de Color de Semaforo COVID\n")
        print("\t\t\t\t\t\t\t      Salida")

        print("\t\t\t\t\t\t    Gracias por usar mi programa")
    else:
        # Limpiar Pantalla
        os.system("clear")
        print("\t\t\t\t\t\t\t\t\t   Opción Invalida")
        input("\nENTER para ir al Menú ")
# Imprimiendo valores añadidos a la bd.csv
print(muestra) 
print("\n")

'''
# Leyendo archivo
archivoMuestra = open("MUESTRA.csv","r")
contenido = archivoMuestra.read()
archivoMuestra.close()
print(contenido)
print("\n")
'''
