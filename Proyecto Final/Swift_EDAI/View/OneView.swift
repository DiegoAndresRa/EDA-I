//
//  ContentView.swift
//  Swift_EDAI
//
//  Created by Diego Ramirez Garcia on 13/08/21.
//

import SwiftUI

struct OneView: View {
    
    
    // Variable con la que trabajara esta vista (View).
    var person = Per(id: 0, age: 28, indicador: 0.8, avatar: Image(systemName: "person.fill"))

    // Proceso
    var body: some View {

        HStack{
            // Imprimiendo imagen.
            if person.indicador >= 0.8 {
            person.avatar .resizable().frame(width: 40, height: 40).padding().foregroundColor(.red)
            } else{
                person.avatar .resizable().frame(width: 40, height: 40).padding().foregroundColor(.green)
            }
            // Imprimiendo texto informativo de edad e indicador de forma estructurada de forma vertical.
            VStack(alignment:.leading){
                Text("Edad: \(person.age)").font(.title).fontWeight(.heavy)
                Text("Indicador:\(person.indicador,specifier:"%.2f")").font(.headline).fontWeight(.light).foregroundColor(Color.black)
            }
            Spacer()
            
            // Condicón para imprimir simbolo de infectado o no dependiendo si el indicador es mayor o igual a 0.8.
            if person.indicador >= 0.8{
                Image(systemName: "exclamationmark.triangle.fill").foregroundColor(.red).padding(20)
            }
        }
        
    }
}
struct OneView_Previews: PreviewProvider {
    static var previews: some View {
        // Una ves ingresado una variable necesaria para esta vista, se necesita difinirla.
        OneView(person: Per(id: 0, age: 28, indicador: 0.8, avatar: Image(systemName: "person.fill"))).previewLayout(.fixed(width: 400, height: 60))
    }
}
