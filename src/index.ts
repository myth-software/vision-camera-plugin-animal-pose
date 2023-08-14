import type { Frame } from 'react-native-vision-camera';
import { VisionCameraProxy } from 'react-native-vision-camera';

const plugin = VisionCameraProxy.getFrameProcessorPlugin('detect_animals');

export function detectAnimals(frame: Frame): string[] {
  'worklet';

  if (plugin === null || plugin === undefined) {
    throw new Error('Failed to load Frame Processor Plugin "detect_animals"!');
  }

  return plugin.call(frame, {
    someString: 'hello!',
    someBoolean: true,
    someNumber: 42,
    someObject: { test: 0, second: 'test' },
    someArray: ['another test', 5],
  }) as string[];
}
