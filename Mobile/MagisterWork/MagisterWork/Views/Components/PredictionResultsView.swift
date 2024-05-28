//
//  PredictionResultsView.swift
//

import SwiftUI

struct PredictionResultsView: View {
    let predictionsResult: [Prediction]?
    let predictionClicked: ((String) -> Void)?
    let timeElapsed: String
    
    init(predictionsResult: [Prediction]?, timeElapsed: String, predictionClicked: ((String) -> Void)? = nil) {
        self.predictionsResult = predictionsResult
        self.predictionClicked = predictionClicked
        self.timeElapsed = timeElapsed
    }
    
    var body: some View {
        HStack() {
            VStack (spacing: Paddings.resultsSpacing) {
                Text(Constants.ImageCategories)
                if let predictionResult = predictionsResult {
                    ForEach(predictionResult) { prediction in
                        Button(action: {
                            predictionClicked?(prediction.classification)
                        }, label: {
                            Text("\(prediction.classification.localized) - \(prediction.confidencePercentage) %")
                                .bold()
                                .font(.subheadline)
                        })
                    }
                } else {
                    Text(Constants.UnknownValue)
                        .bold()
                }
            }
            Spacer()
            VStack {
                Text(Constants.TimeElapsed)
                if !timeElapsed.isEmpty {
                    Text("\(timeElapsed) sec.")
                        .bold()
                } else {
                    Text(Constants.UnknownValue)
                        .bold()
                }
            }
        }
    }
}

extension PredictionResultsView {
    private enum Constants {
        static let ImageCategories: LocalizedStringKey = "Image categories:"
        static let TimeElapsed: LocalizedStringKey = "Time elapsed:"
        static let PersentSign = "%"
        static let UnknownValue = "NA"
    }
    
    private enum Paddings {
        static let resultsSpacing: CGFloat = 10
    }
}

#Preview {
    PredictionResultsView(predictionsResult: [
        Prediction(classification: "Class object 1", confidencePercentage: "80"),
        Prediction(classification: "Class object 2", confidencePercentage: "20")
    ], timeElapsed: "0,02")
}
