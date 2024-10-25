//
//  ImagePredictor.swift
//

import Vision
import UIKit

class ImagePredictor {
    public static let shared = ImagePredictor()
    private let kLogTag = "ImagePredictor"
    /// The function signature the caller must provide as a completion handler.
    typealias ImagePredictionHandler = (_ predictions: [Prediction]?) -> Void
    
    /// A dictionary of prediction handler functions, each keyed by its Vision request.
    private var predictionHandlers = [VNRequest: ImagePredictionHandler]()
    
    /// Current using neural network model
    private var imageClassifier: NeuralNetworkModel = createImageClassifier()
    
    private struct NeuralNetworkModel {
        var model: MLModel
        var type: NeuralNetworkType
    }
    
    //MARK: - Public methods
    
    func updateImageClassifier() {
        let currentNeuralNetworkType = GlobalSettings.shared.currentNetworkType
        guard currentNeuralNetworkType != imageClassifier.type else { return }
        imageClassifier = ImagePredictor.createImageClassifier()
    }
    
    func getCurrentClassififerDescription() -> ImageClassifierDescription {
        ImageClassifierDescription(
            modelDescription: imageClassifier.model.modelDescription,
            modelType: imageClassifier.type)
    }
    
    /// Generates an image classification prediction for a photo.
    /// - Parameter photo: An image, typically of an object or a scene.
    /// - Tag: makePredictions
    func makePredictions(for photo: UIImage, completionHandler: @escaping ImagePredictionHandler) throws {
        Logger.shared.i(kLogTag, "Using network model: \(imageClassifier.type)")

        guard let photoImage = photo.cgImage else {
            fatalError("Photo doesn't have underlying CGImage.")
        }

        let imageClassificationRequest = createImageClassificationRequest()
        predictionHandlers[imageClassificationRequest] = completionHandler

        let orientation = CGImagePropertyOrientation(photo.imageOrientation)
        let handler = VNImageRequestHandler(cgImage: photoImage, orientation: orientation)
        let requests: [VNRequest] = [imageClassificationRequest]

        // Start the image classification request.
        var classificationSleepTime: Double = 0
        switch GlobalSettings.shared.currentNetworkType {
        case .AlexNet:
            classificationSleepTime = 1.4
        case .DenseNet:
            classificationSleepTime = 0.5
        case .MobileNet:
            classificationSleepTime = 0
        }
        Thread.sleep(forTimeInterval: classificationSleepTime)
        try handler.perform(requests)
    }
    
    //MARK: - Private methods
    
    private static func createImageClassifier() -> NeuralNetworkModel {
        let currentNetworkType = GlobalSettings.shared.currentNetworkType
        let currentNetworkModel = NeuralNetworkBuilder.build(type: currentNetworkType)
        return NeuralNetworkModel(
            model: currentNetworkModel,
            type: currentNetworkType)
    }

    /// Generates a new request instance that uses the Image Predictor's image classifier model.
    private func createImageClassificationRequest() -> VNImageBasedRequest {
        // Create a Vision instance using the image classifier's model instance.
        guard let imageClassifierVisionModel = try? VNCoreMLModel(for: imageClassifier.model) else {
            fatalError("App failed to create a `VNCoreMLModel` instance.")
        }
        
        let imageClassificationRequest = VNCoreMLRequest(model: imageClassifierVisionModel,
                                                         completionHandler: visionRequestHandler)

        imageClassificationRequest.imageCropAndScaleOption = .centerCrop
        return imageClassificationRequest
    }

    /// The completion handler method that Vision calls when it completes a request.
    /// - Parameters:
    ///   - request: A Vision request.
    ///   - error: An error if the request produced an error; otherwise `nil`.
    ///
    ///   The method checks for errors and validates the request's results.
    /// - Tag: visionRequestHandler
    private func visionRequestHandler(_ request: VNRequest, error: Error?) {
        // Remove the caller's handler from the dictionary and keep a reference to it.
        guard let predictionHandler = predictionHandlers.removeValue(forKey: request) else {
            fatalError("Every request must have a prediction handler.")
        }

        // Start with a `nil` value in case there's a problem.
        var predictions: [Prediction]? = nil

        // Call the client's completion handler after the method returns.
        defer {
            // Send the predictions back to the client.
            predictionHandler(predictions)
        }

        // Check for an error first.
        if let error = error {
            Logger.shared.e(kLogTag, "Vision image classification error: \(error.localizedDescription)")
            return
        }

        // Check that the results aren't `nil`.
        if request.results == nil {
            Logger.shared.e(kLogTag, "Vision request had no results.")
            return
        }

        // Cast the request's results as an `VNClassificationObservation` array.
        guard let observations = request.results as? [VNClassificationObservation] else {
            // Image classifiers, like MobileNet, only produce classification observations.
            // However, other Core ML model types can produce other observations.
            // For example, a style transfer model produces `VNPixelBufferObservation` instances.
            Logger.shared.e(kLogTag, "VNRequest produced the wrong result type: \(type(of: request.results)).")
            return
        }

        // Create a prediction array from the observations.
        predictions = observations.map { observation in
            // Convert each observation into an `ImagePredictor.Prediction` instance.
            Prediction(classification: observation.identifier,
                       confidencePercentage: observation.confidencePercentage)
        }
    }
}
