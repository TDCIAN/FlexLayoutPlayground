//
//  UIImageView+Download.swift
//  FlexLayoutPlayground
//
//  Created by 김정민 on 11/3/24.
//

import UIKit

extension UIImageView {
    func download(url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                  let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                  let data = data,
                  error == nil,
                  let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
}
