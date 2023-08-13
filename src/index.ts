/** globals __detectAnimals */

import type { Frame } from 'react-native-vision-camera';

interface DetectedAnimal {
  X: string;
  Y: string;
  /**
   * A floating point number from 0 to 1, describing the confidence (percentage).
   */
  Confidence: number;
}

/**
 * Returns an array of matching `DetectedAnimal`s for the given frame.
 *
 * This algorithm executes within **~60ms**,
 * so a frameRate of **16 FPS** perfectly allows the algorithm to run without dropping a frame.
 * Anything higher might make video recording stutter, but works too.
 */
export function detectAnimals(frame: Frame): Array<DetectedAnimal> {
  'worklet';
  // @ts-expect-error Frame Processors are not typed.
  return __detectAnimals(frame);
}
