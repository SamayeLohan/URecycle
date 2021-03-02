import SwiftUI

struct ContentView: View {
    
    let photos = ["banana_peel","coffee_cup","soda_can"]
    @State private var currentIndex: Int = 0
    @State private var classificationLabel: String = ""
    
    let model = Resnet50()
    
    func imageClassification() {
        let currentImage = photos[currentIndex]
        
        guard let img = UIImage(named: currentImage),
              let resizedImage = img.resizeTo(size: CGSize(width: 224, height: 224)),
              let buffer = resizedImage.toBuffer() else {
            return
        }
        
        let output = try? model.prediction(image: buffer)
        
        if let output = output {
            self.classificationLabel = output.classLabel
        }
    }
    
    
    
    var body: some View {
        VStack {
            Text("Image Classifier")
                .font(.title)
                .fontWeight(.bold)
            Image(photos[currentIndex])
                .resizable()
                .frame(width: 350, height: 350)
            HStack {
                Button("⏪") {
                    
                    if self.currentIndex >= self.photos.count {
                        self.currentIndex = self.currentIndex - 1
                    } else {
                        self.currentIndex = 0
                    }
                    
                    }.padding()
                    .font(.largeTitle)
                .foregroundColor(Color.white)
                    .background(Color.clear)
                    .cornerRadius(20)
                    .frame(width: 75, height: 75, alignment: .center)
                Button("⏩") {
                    if self.currentIndex < self.photos.count - 1 {
                        self.currentIndex = self.currentIndex + 1
                    } else {
                        self.currentIndex = 0
                    }
                }
                .padding()
                .font(.largeTitle)
                .foregroundColor(Color.white)
                .background(Color.clear)
                .cornerRadius(20)
                .frame(width: 75, height: 75, alignment: .center)
            
                
                
            }.padding()
            
            Button("Classify") {
                // classify the image here
                self.imageClassification()
                
            }.padding()
            .foregroundColor(Color.white)
            .background(Color.green)
            .cornerRadius(8)
            
            Text(classificationLabel)
            .font(.largeTitle)
            .padding()
            
            Button("Take Photo") {
                //Take photo code....
            }.padding()
            .foregroundColor(Color.white)
            .background(Color.blue)
            .cornerRadius(8)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
