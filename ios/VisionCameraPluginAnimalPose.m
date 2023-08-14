//
//  VisionCameraPluginAnimalPose.m
//  VisionCameraPluginAnimalPose
//  Created by pete smith on 8/11/23.
//  Copyright © 2023 myth software, llc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <VisionCamera/FrameProcessorPlugin.h>
#import <VisionCamera/FrameProcessorPluginRegistry.h>
#import <VisionCamera/Frame.h>
#import <Vision/Vision.h>


@interface VisionCameraPluginAnimalPose : FrameProcessorPlugin
@end

@implementation VisionCameraPluginAnimalPose

- (id)callback:(Frame *)frame withArguments:(NSArray<id> *)arguments {
  NSMutableDictionary *bodyParts = [[NSMutableDictionary alloc]initWithCapacity:26];
  CVPixelBufferRef buffer = CMSampleBufferGetImageBuffer(frame.buffer);
  UIImageOrientation orientation = frame.orientation;
  NSDictionary<VNImageOption, id> *options = @{};

  void (^completionHandler)(VNRequest*, NSError*) = ^(VNRequest* request, NSError* error) {
      NSArray<VNAnimalBodyPoseObservation *> *results = request.results;
      int resultsCount = [results count];

      if (resultsCount > 0) {
          VNAnimalBodyPoseObservation *animal = request.results.firstObject;

          if (animal) {
              NSDictionary<VNAnimalBodyPoseObservationJointName, VNRecognizedPoint *> *animalBodyAllParts = [animal recognizedPointsForJointsGroupName:VNAnimalBodyPoseObservationJointsGroupNameAll error:nil];

              for(id key in animalBodyAllParts) {
                  VNRecognizedPoint *point = [animalBodyAllParts objectForKey:key];
                  NSMutableDictionary *val = CFBridgingRelease(CGPointCreateDictionaryRepresentation([point location]));
                  val[@"Confidence"] = @([point confidence]);
                  [bodyParts setObject:val forKey: key];
              }
          }
      }
  };

  VNDetectAnimalBodyPoseRequest *animalBodyPoseRequest = [[VNDetectAnimalBodyPoseRequest alloc] initWithCompletionHandler:completionHandler];
  VNImageRequestHandler *requestHandler = [[VNImageRequestHandler alloc]  initWithCVPixelBuffer: buffer orientation: orientation options: options];
  NSError *requestError;
  [requestHandler performRequests:@[animalBodyPoseRequest] error: &requestError];

  if (requestError) {
      return nil;
  }
  return bodyParts;
}

+ (void) load {
  [FrameProcessorPluginRegistry addFrameProcessorPlugin:@"detect_animals"
                                        withInitializer:^FrameProcessorPlugin*(NSDictionary* options) {
    return [[VisionCameraPluginAnimalPose alloc] init];
  }];
}

@end

