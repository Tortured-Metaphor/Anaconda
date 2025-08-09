# 🐍 ANACONDA - Retro 8-Bit Snake Runner

> *Slither through a neon-soaked digital wasteland in this radical retro runner!*

![LÖVE2D](https://img.shields.io/badge/LÖVE2D-11.x-ff69b4?style=for-the-badge&logo=lua)
![Lua](https://img.shields.io/badge/Lua-5.1+-2C2D72?style=for-the-badge&logo=lua)
![Platform](https://img.shields.io/badge/Platform-Windows%20|%20Mac%20|%20Linux-brightgreen?style=for-the-badge)

## 🎮 About

**ANACONDA** is a hypnotic endless runner that fuses classic snake mechanics with modern runner gameplay. Navigate your pixelated serpent through a CRT-filtered dreamscape, dodging obstacles and collecting glowing numbers to boost your score. With its authentic 8-bit aesthetic, scanline effects, and twinkling starfield, this game delivers pure retro gaming nostalgia.

## 🚀 Features

- **Smooth Snake Physics** - Your serpent flows with realistic segmented movement
- **Dynamic Jumping** - Time your jumps perfectly to clear obstacles
- **Retro Visual Effects** - Authentic CRT scanlines, pixel-perfect graphics, and a starlit sky
- **Score Collection** - Grab floating numbers to rack up points
- **Endless Challenge** - Procedurally generated obstacles keep you on your toes
- **Neon Color Palette** - Eye-popping greens, magentas, and yellows straight from the arcade era

## 🎯 How to Play

1. **SPACE** - Jump over obstacles
2. **ESC** - Quit game
3. Collect glowing numbers for points
4. Avoid hitting obstacles (you'll lose points!)
5. Keep moving - the snake never stops!

## 🛠️ Installation

### Prerequisites
- [LÖVE2D](https://love2d.org/) (version 11.0 or higher)

### Running the Game

#### Option 1: Direct Run
```bash
# Clone the repository
git clone https://github.com/Tortured-Metaphor/Anaconda.git
cd Anaconda

# Run with LÖVE
love .
```

#### Option 2: Create Executable
```bash
# Package as .love file
zip -r anaconda.love *.lua conf.lua

# Run the package
love anaconda.love
```

#### Option 3: Platform-Specific
- **Windows**: Drag the game folder onto `love.exe`
- **Mac**: Right-click the folder → Open With → LÖVE
- **Linux**: Use the terminal command `love /path/to/game`

## 🎨 Screenshots

```
    ✦  ·    ✦       ·  ✦     
 ·      ✦    ·            ✦   
                               
  ████████████                
  ████████████  [9]     ▓▓▓   
  ████████████       ▓▓▓▓▓▓   
═══════════════════════════════
```
*Experience the thrill of dodging obstacles while collecting points!*

## 🏆 High Score Tips

- Jump early but not too early - timing is everything!
- Memorize obstacle patterns to improve your reflexes
- Focus on collecting numbers when it's safe
- The snake's tail follows your head - use this to your advantage
- Stay calm as the speed increases!

## 🔧 Technical Details

- **Resolution**: 800x400 pixels
- **Frame Rate**: 60 FPS with VSync
- **Graphics**: Software-rendered pixel art
- **Effects**: Real-time scanline simulation, particle stars, dynamic shadows
- **Physics**: Custom gravity and momentum system

## 🎵 Pro Gamer Moves

- Hold SPACE for controlled descent after high jumps
- Thread the needle between close obstacles for style points
- Master the snake's wave motion for smoother gameplay
- Watch for the pattern: obstacles spawn every 1.5-3 seconds

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🤝 Contributing

Pull requests are welcome! Feel free to:
- Add power-ups
- Create new obstacle types
- Implement a high score system
- Add retro sound effects
- Design new visual themes

## 🎮 Credits

Built with [LÖVE2D](https://love2d.org/) - *Because games should be fun to make*

---

**Ready to slither?** Fire up LÖVE2D and let the retro runner madness begin! 🐍✨

*Remember: In the digital wasteland, only the swift survive!*
