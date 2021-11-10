//
//  WebImage.swift
//  Pinstagram
//
//  Created by Robert Pelka on 06/11/2021.
//

import SwiftUI

struct WebImage: View {
    var url: URL?
    @ObservedObject var imageLoader = ImageLoader()
    @State var image: UIImage?
    
    init(url: URL?) {
        self.url = url
    }
    
    var body: some View {
        if #available(iOS 15.0, *) {
            AsyncImage(url: url) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
                    .progressViewStyle(CustomProgressStyle(size: 18, isColorSchemeConsidered: true))
            }
        }
        else {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .onAppear {
                        imageLoader.loadImage(fromURL: url)
                    }
                    .onReceive(imageLoader.$image) { image in
                        self.image = image
                    }
            }
            else {
                ProgressView()
                    .progressViewStyle(CustomProgressStyle(size: 18, isColorSchemeConsidered: true))
            }
        }
    }
}

struct WebImage_Previews: PreviewProvider {
    static var previews: some View {
        WebImage(url: URL(string: "https://upload.wikimedia.org/wikipedia/en/9/96/App_Store_icon_for_Swift_laygrounds.png"))
    }
}


class ImageLoader: ObservableObject {
    @Published var image = UIImage()
    
    func loadImage(fromURL url: URL?) {
        guard let url = url else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("DEBUG: Error loading image from specified URL: \(error.localizedDescription)")
            }
            guard let data = data else { return }
            DispatchQueue.main.async {
                guard let image = UIImage(data: data) else { return }
                self.image = image
            }
        }
        task.resume()
    }
}
