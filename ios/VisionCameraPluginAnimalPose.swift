import Vision

@objc(VisionCameraPluginAnimalPose)
public class VisionCameraPluginAnimalPose: NSObject, FrameProcessorPluginBase {
  @objc public static func callback(_ frame: Frame!, withArgs _: [Any]!) -> Any! {
    var bodyParts: [Any] = []
    func detectedAnimalPose(request: VNRequest, error: Error?) {
        // Get the results from VNAnimalBodyPoseObservations.
        guard let animalBodyPoseResults = request.results as? [VNAnimalBodyPoseObservation] else { return }
        // Get the animal body recognized points for the .all group.
        guard let animalBodyAllParts = try? animalBodyPoseResults.first?.recognizedPoints(.all) else { return }
        bodyParts.append(animalBodyAllParts)
    }
    
    let animalBodyPoseRequest = VNDetectAnimalBodyPoseRequest(completionHandler: detectedAnimalPose)
    let imageRequestHandler = VNImageRequestHandler(cmSampleBuffer: frame.buffer, orientation: .up)
    do {
        // Send the request to the request handler with a call to perform.
        try imageRequestHandler.perform([animalBodyPoseRequest])
        
    } catch {
        print("Unable to perform the request: \(error).")
        return nil
    }
    return nil
}
}
