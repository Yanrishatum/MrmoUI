# MrmoUI
Small GUI library, inspired by Mrmo's [UI design](http://pixeljoint.com/pixelart/74064.htm) for [Rapporter](http://rapporter.net).  
Really WIP version, not even formatted as proper Haxelib library.

## Total goal
I want to make a library without hard framework dependency, with technical part relying strictly on Haxe STD.
Plus this lib should be easy to create fast guis via XML file.

## TODO

### Components
* [x] Core component
* [x] RootComponent
* [ ] Panel
  * [x] Basic implementation
  * [ ] Close button
  * [ ] Maximize/minimize buttons
* [ ] Button
  * [x] Basic implementation
  * [ ] Several states support (hover/pressed/disabled)
* [ ] Checkbox
* [ ] ToggleButton
* [ ] TextArea & TextInput
  * [x] Basic implementation
  * [ ] Key handlers for linked buttons
  * [ ] Password mode
  * [ ] ScrollBars
* [x] Label
* [ ] TabPanel
* [ ] Scrollbar
* [ ] Drop-down list
* [ ] AutoAligner
* [ ] List
* [ ] ProgressBar
* [ ] NumericStepper
* [ ] Slider
* [ ] Table-list
* [ ] Container

### Utilities
* [x] GuiBuilder  
Answers for GUI building from XML file.
  * [x] Basic implementation
  * [ ] Better argument resolving with metadata and macro code generation.
* [x] AutoSizer  
Answers for fluid snapping to parent container.
* [ ] Icons
  * [x] V icon
  * [x] X icon
  * [ ] All other icons on mockup.
  * [ ] Custom icon support.

### Other
* [ ] Separate internal and framework-dependent parts.

## Credits
Firstly, Mrmo Tarius for makins a great design and allowing to use it.  
Secondly, Rapporter team for allowing me to use this UI in library.  

## License
This is free and unencumbered software released into the public domain.  
See LICENSE file for full text.