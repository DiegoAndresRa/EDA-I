//
//  TwoView.swift
//  Swift_EDAI
//
//  Created by Diego Ramirez Garcia on 13/08/21.
//

import SwiftUI

// ObsevableObect y @Pubished nos permiten por un lado actualizar en todo momento nuestra información en caso de requerirlo y por otro lado hacer de conocimiento público la información a lo largo del programa (Views o Struct).
class InfectadosModelData: ObservableObject{
    // Estructura de datos
    @Published var persons = [Per(id: 0, age: 28, indicador: 0.72, avatar: Image(systemName: "person.circle.fill")),
                              Per(id: 1, age: 54, indicador: 0.84, avatar: Image(systemName: "person.circle.fill")),
                              Per(id: 2, age: 34, indicador: 0.79, avatar: Image(systemName: "person.circle.fill")),
                              Per(id: 3, age: 23, indicador: 0.7, avatar: Image(systemName: "person.circle.fill")),
                              Per(id: 4, age: 56, indicador: 0.87, avatar: Image(systemName: "person.circle.fill")),
                              Per(id: 5, age: 82, indicador: 0.9, avatar: Image(systemName: "person.circle.fill")),
                              Per(id: 6, age: 30, indicador: 0.78, avatar: Image(systemName: "person.circle.fill")),
                              Per(id: 7, age: 65, indicador: 0.89, avatar: Image(systemName: "person.circle.fill")),
                              Per(id: 8, age: 19, indicador: 0.65, avatar: Image(systemName: "person.circle.fill")),
                              Per(id: 9, age: 70, indicador: 0.86, avatar: Image(systemName: "person.circle.fill"))]
}

// Pantalla secundaria
struct LView: View {
    // @ObservadOject se utiliza ya que en esta vista se recive en envio de la variable infectadosModelData
    @ObservedObject var infectadosModelData : InfectadosModelData
    // Varible de la cual depende si la lista se muestra toda o no
    @State private var showInfected = false
    
    // Variable de tipo Calculada:Tomara un cierto valor dependiendo de una condición
    private var filteredInfected: [Per]{
    //  Definiendo su valor con ayuda de la función para el manejo de datos .filter (quien encuentra filas con cierta condición)
        return infectadosModelData.persons.filter { person in
        /* Si indicamos muestre los favoritos, tendra en cuentra que su Indicador sea mayor a 0.8,
             en caso contrario (!showInfected) mostrará toda la lista.
        */
            return !showInfected ||  person.indicador >= 0.8
    }
}
var body: some View {
    
    NavigationView{
        VStack{
            // Se encuentra dependiente de showInfected , que es de tipo @State, ya que queremos que al cambiar su valor la View o pantalla también se actualise).
            // $ se utiliza para que pueda acceder a shadowInfected de forma mutable.
            Toggle(isOn: $showInfected) {
                Text("Mostrar Infectados")
            }.padding()
            
            List{
                // Trabaja únicamente con la lista cuyos volores mútan conforme indiquemos si queremos mostrar o no a los infectados (con respecto al valor de showInfected)
                ForEach(filteredInfected){ person in
                    // Invocando a la clase donde se define el estilo de cada una de las Row o filas.
                    OneView(person: person)
                    }
                }
            // Indicando el Semáforo
            if filteredInfected.count > 0 {
                HStack{
                    if filteredInfected.count > 0 && filteredInfected.count <= 2{
                        Text("Semaforo")
                        Image(systemName: "circlebadge.fill").resizable().frame(width: 30, height: 30).foregroundColor(Color.yellow)
                    } else if filteredInfected.count > 2 && filteredInfected.count <= 4{
                        Text("Semaforo")
                        Image(systemName: "circlebadge.fill").resizable().frame(width: 30, height: 30).foregroundColor(Color.orange)
                    } else if filteredInfected.count > 4 && filteredInfected.count <= 5{
                        Text("Semaforo")
                        Image(systemName: "circlebadge.fill").resizable().frame(width: 30, height: 30).foregroundColor(Color.red)
                    }
                }
            } else {
                Text("Semaforo")
                Image(systemName: "circlebadge.fill").resizable().frame(width: 30, height: 30).foregroundColor(Color.green)
            }
        }
        .navigationTitle("Base de Datos")
    }
  }
}
    // Titulo de la vista
struct TwoView: View {
    
    // Instanciando la class desde TwoView ya que class está ciendo ejecutada junto con esta, y posteriormente al cambiar de vista (View) es donde aplicamos uso de esta clase.
    // StateObjete a diferencia de State se utiliza cuando lo que propagamos es un poco más complejo que un valor.
    @StateObject var infectadosModelData = InfectadosModelData()
    // Esta variable nos permite hacer el cámbio de página a partir del NavigationView.
    @State private var selection: Int?
    
    var body: some View {
        NavigationView{
            VStack {
                Text("Indicador Semáforo COVID").font(.largeTitle).fontWeight(.black).foregroundColor(Color.black).multilineTextAlignment(.center).padding()
                
                Spacer()
                
                Image(systemName: "bell.badge.fill").resizable().frame(width: 140, height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).foregroundColor(.red).shadow(color:Color.init(red: 0.1, green: 0.5, blue: 1.2),radius: 7)
                
                Spacer()
                
                NavigationLink(destination:LView(infectadosModelData: infectadosModelData),tag: 1, selection: $selection){
                    Button("Ir a la Base de Datos"){
                        selection = 1
                    }.padding(40)
                }
            }
        }
    }
}
struct TwoView_Previews: PreviewProvider {
    static var previews: some View {
        TwoView().environmentObject(InfectadosModelData())

    }
}
