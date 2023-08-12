import * as React from 'react';

import { StyleSheet, Text, View } from 'react-native';
import { useFrameProcessor } from 'react-native-vision-camera';
import { detectAnimals } from 'vision-camera-plugin-animal-pose';

export default function App() {
  const [result] = React.useState<number | undefined>();

  useFrameProcessor((frame) => {
    'worklet';
    const animals = detectAnimals(frame);
    console.warn(animals);
  }, []);

  return (
    <View style={styles.container}>
      <Text>Result: {result}</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  box: {
    width: 60,
    height: 60,
    marginVertical: 20,
  },
});
