//
//  ToModelExtension.swift
//  KeepExpress
//
//  Created by 曹文博 on 25/06/2017.
//  Copyright © 2017 jackrex. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import HandyJSON

extension ObservableType where E == Response {
    public func mapModel<T: HandyJSON>(_ type: T.Type) -> Observable<T> {
        return flatMap { response -> Observable<T> in
            return Observable<T>.create({ (observe) -> Disposable in
                if let model = response.mapModel(T.self) {
                    observe.onNext(model)
                }
                observe.onCompleted()
                return Disposables.create()
            })
            
        }
    }
    public func mapArray<T: HandyJSON>(_ type: T.Type) -> Observable<[T]> {
        return flatMap { response -> Observable<[T]> in
            return Observable<[T]>.create({ (observe) -> Disposable in
                if let array = response.mapArray(T.self) {
                    observe.onNext(array)
                }
                observe.onCompleted()
                return Disposables.create()
            })
        }
    }
}

extension Response {
    func mapModel<T: HandyJSON>(_ type: T.Type) -> T? {
        let jsonString = String.init(data: data, encoding: .utf8)
        return JSONDeserializer<T>.deserializeFrom(json: jsonString)
    }
    func mapArray<T:HandyJSON>(_ type: T.Type) -> [T]? {
        let jsonString = String.init(data: data, encoding: .utf8)
        return JSONDeserializer<T>.deserializeModelArrayFrom(json: jsonString) as? [T]
    }
}
