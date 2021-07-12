//
//  PhotosAuthorization.swift
//  easyPlant
//
//  Created by 차다윤 on 2021/06/05.
//

import Foundation
import Photos


func requestGalleryPermission(){
        PHPhotoLibrary.requestAuthorization( { status in
            switch status{
            case .authorized:
                print("Gallery: 권한 허용")
            case .denied:
                print("Gallery: 권한 거부")
            case .restricted, .notDetermined:
                print("Gallery: 선택하지 않음")
            default:
                break
            }
        })
    }

func requestCameraPermission(){
        AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
            if granted {
                print("Camera: 권한 허용")
            } else {
                print("Camera: 권한 거부")
            }
        })
    }
