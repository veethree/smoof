# smoof.lua

A tiny tweening library for lua.
It's basically this function wrapped up in a library:
```
value = value + (target - value) * smoothing
```

## Usage

#### `smoof:update(dt)`
You need to call this function once per frame. It updates the animation.
'dt' is delta time, Meaning the time that has passed since the last frame in seconds.

### `smoof:new(object, target, smoof_value, completion_threshold, bind)`
This function starts an animation.
* object: This needs to be a table, Containing the values you want to tween. Ex: `{x = 0, y = 0}`
* target: Another table, Containing the target value/s. Ex: `{x = 32, y = 64}`
* (Optonal) smoof_value: A number that controls the length of the animation. The lower the number, The faster the animation. Should be in the range of 0 to 1, But not 1. 0.99999... is fine.
* (Optonal) completion_threshold: This value contols how close to the target the value should get before snapping to it and ending the animation.
* (Optional) bind: Boolean, If true, The animation will never be removed from the stack (unless you call smoof:unbind()), As a result the object values will constalty animate towards the target.

### `smoof:setDefaultSmoofValue(val)`
This function sets the default `smoof_value` that `smoof:tween` falls back to if one isn't provided.

### `smoof:setCompletionThreshold(threshold)`
This function sets the default `completion_threshold` value that `smoof:tween` falls back to if one isn't provided.

### So what is this useful for?
Anything where you want a smooth animation. Perhaps GUI elements sliding in and out of frame to make your game more juicy.

Here's a not so smooth gif of it in action:

![image](https://github.com/veethree/smoof/blob/main/Demo/smoof_demo.gif)
