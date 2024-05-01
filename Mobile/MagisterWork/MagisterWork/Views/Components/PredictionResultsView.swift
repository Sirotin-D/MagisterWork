//
//  PredictionResultsView.swift
//

import SwiftUI

struct PredictionResultsView: View {
    let predictionsResult: [Prediction]?
    let timeElapsed: String
    var body: some View {
        HStack() {
            VStack {
                Text(Constants.ImageCategories)
                if let predictionResult = predictionsResult {
                    ForEach(predictionResult) { prediction in
                        Text("\(prediction.classification) - \(prediction.confidencePercentage) %")
                            .bold()
                            .font(.subheadline)
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
}

#Preview {
    PredictionResultsView(predictionsResult: [
        Prediction(classification: "Class object 1", confidencePercentage: "80"),
        Prediction(classification: "Class object 2", confidencePercentage: "20")
    ], timeElapsed: "0,02")
}
