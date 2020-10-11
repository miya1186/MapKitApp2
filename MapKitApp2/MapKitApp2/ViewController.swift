//
//  ViewController.swift
//  MapKitApp2
//
//  Created by miyazawaryohei on 2020/10/11.
//

import UIKit
import MapKit
class ViewController: UIViewController,MKMapViewDelegate {
    
    //アノテーションの配列
    var annotationlist = Array<MKPointAnnotation>()
    @IBOutlet var myMap: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //中心座標
        let center = CLLocationCoordinate2D(latitude: 35.4424225, longitude: 139.6465645)
        //表示範囲
        let span = MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002)
        //地図の表示領域を決める
        let region = MKCoordinateRegion(center: center, span: span)
        myMap.setRegion(region, animated: true)
        //アノテーションを作る
        let annotation = MKPointAnnotation()
        annotation.coordinate = center
        annotation.title = "ここです！"
        annotation.subtitle = "私、待ってます"
        //アノテーションを表示する
        myMap.addAnnotation(annotation)
        
        myMap.delegate = self
    }
    
    @IBAction func mapLongPress(_ sender: UILongPressGestureRecognizer) {
        //長押しの終了でのみ実行する
        guard sender.state == UIGestureRecognizer.State.ended else{
            return//長押しの開始と最中はキャンセルする
        }
        //長押しいの座標を取り出す
        let pressPoint = sender.location(in: myMap)
        //マップの座標に変換する
        //        let pressCoordinate = myMap.convert(pressPoint, to: myMap)
        let pressCoordinate = myMap.convert(pressPoint, toCoordinateFrom: myMap)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = pressCoordinate
        annotation.title = "ここ！"
        //アノテーションを追加する
        annotationlist.append(annotation)
        //アノテーションを表示する
        myMap.addAnnotation(annotation)
        
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        //ドラッグ可能なピンを作る
        let pinView = MKPinAnnotationView()
        pinView.animatesDrop = true //落ちてくる
        pinView.isDraggable = true //ドラッグ可能
        pinView.pinTintColor = UIColor.blue //色
        pinView.canShowCallout = true //タップでタイトル表示
        return pinView
        
    }
    
    @IBAction func removeLastPin(_ sender: Any) {
        //最後に追加したピンを削除する
        if annotationlist.count>0{
            let lastPin = annotationlist.removeLast()
            myMap.removeAnnotation(lastPin)
        }
    }
    
}

