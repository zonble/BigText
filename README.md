# BigText

A macOS application for creating large text with visual effects and exporting them as PNG images.

## Features

- Create large text with customizable fonts
- Apply visual effects:
  - None (plain text)
  - Zoom Blur effect
  - Left Transform (perspective effect)
- Export text as PNG images
- Built-in ruler for text formatting

## Usage

1. **Launch BigText** - Open the application from your Applications folder
2. **Enter Text** - Type your desired text in the main text view
3. **Format Text** - Use the ruler to adjust formatting and font properties
4. **Select Effect** - Choose from the available effects:
   - None: Plain text without effects
   - Zoom Blur: Adds a radial blur effect centered on the text
   - Left Transform: Applies a perspective transformation
5. **Save Image** - Click the save button to export your text as a PNG image
   - Choose your desired location and filename
   - The image will be saved with the applied effect

## System Requirements

- **Operating System**: macOS 10.9 (Mavericks) or later
- **Frameworks**: 
  - Cocoa
  - QuartzCore (Core Image)
- **Development**: Xcode (for building from source)

## How to Build

### Prerequisites
- Xcode installed on your Mac
- macOS 10.9 SDK or later

### Build Instructions

1. **Clone the repository**:
   ```bash
   git clone https://github.com/zonble/BigText.git
   cd BigText
   ```

2. **Open in Xcode**:
   ```bash
   open BigText.xcodeproj
   ```

3. **Build the project**:
   - In Xcode: Product → Build (⌘+B)
   - Or from command line:
   ```bash
   xcodebuild -project BigText.xcodeproj -scheme BigText -configuration Release
   ```

4. **Run the application**:
   - In Xcode: Product → Run (⌘+R)
   - Or locate the built app in the derived data folder

### Build Configuration
- **Target**: macOS application (.app)
- **Language**: Objective-C
- **ARC**: Enabled
- **Bundle Identifier**: net.zonble.BigText

## License

MIT License

Copyright (c) 2024 Weizhong Yang a.k.a zonble

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

## Technical Details

### Core Components
- **BigTextAppDelegate**: Main application delegate handling UI and image export
- **Text Rendering**: Uses NSAttributedString with custom font sizing (48pt default)
- **Effects Processing**: Leverages Core Image filters:
  - `CIZoomBlur` for blur effects
  - `CIPerspectiveTransform` for perspective distortion
- **Export**: NSBitmapImageRep for PNG generation

### Architecture
- Standard Cocoa application architecture
- Interface Builder integration (.xib files)
- Core Image pipeline for real-time effects
- Document-based workflow for image export