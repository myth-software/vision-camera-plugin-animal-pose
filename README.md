# vision-camera-plugin-animal-pose

detect animal poses in react native (ios only)

## Installation

```sh
npm i -S vision-camera-plugin-animal-pose
```

Add the plugin to your `babel.config.js`:

```js
module.exports = {
  plugins: [
    [
      'react-native-reanimated/plugin',
      {
        globals: ['__detectAnimals'],
      },
    ],

    // ...
```

> Note: You have to restart metro-bundler for changes in the `babel.config.js` file to take effect.

## Usage

```js
import { detectAnimals } from "vision-camera-plugin-animal-pose";

// ...
const frameProcessor = useFrameProcessor((frame) => {
  'worklet';
  const animals = detectAnimals(frame);
}, []);
```

## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## License

MIT

---

Made with [create-react-native-library](https://github.com/callstack/react-native-builder-bob)
