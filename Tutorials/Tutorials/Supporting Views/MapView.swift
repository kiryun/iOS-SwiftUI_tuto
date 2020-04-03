//
//  MapView.swift
//  Tutorials
//
//  Created by Gihyun Kim on 2020/01/11.
//  Copyright © 2020 wimes. All rights reserved.
//
import SwiftUI
import MapKit

struct MapView {
    var coordinate: CLLocationCoordinate2D
    
    func makeMapView() -> MKMapView{
        MKMapView(frame: .zero)
    }
    
    func updateMapView(_ view: MKMapView, context: Context){
        
        let span = MKCoordinateSpan(latitudeDelta: 2.0, longitudeDelta: 2.0)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        view.setRegion(region, animated: true)
    }
}

#if os(macOS)
extension MapView: NSViewRepresentable{
    func makeNSView(context: Context) -> MKMapView{
        makeMapView()
    }
    
    func updateNSView(_ nsView: MKMapView, context: Context){
        updateMapView(nsView, context: context)
    }
}
#else
extension MapView: UIViewRepresentable {
    func makeUIView(context: Context) -> MKMapView {
        makeMapView()
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        updateMapView(uiView, context: context)
    }
}
#endif



struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(coordinate: landmarkData[0].locationCoordinate)
    }
}

