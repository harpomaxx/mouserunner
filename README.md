# Mouse Street Runner (YET ANOTHER Godot Demo)

A simple **2D lane-runner demo game** made in [Godot 4](https://godotengine.org/).

> **Note:** This is a prototype/demo project created to test mechanics and Godot features.  
> Not a finished game—just a showcase and starting point for learning or further development!

**Built by:** GPT4.1  
**Status:** Demo/Prototype

---

## Gameplay

You play as a mouse running down a two-lane street:
- **Collect cheese** for points
- **Avoid cats** to survive
- The game speeds up and levels up as you collect more cheese
- Lose all your lives? Hit restart and try again!

---

## Controls

- **Left/Right Arrow** — Move mouse between left/right lanes
- **Pause button** (top corner) — Pause and resume game
- **Restart button** (on Game Over screen) — Restart the game
- **Start button** — Begin the game

---

## How to Run

### **Godot Version**

1. Download [Godot 4](https://godotengine.org/download)
2. Clone this repository:
    ```sh
    git clone https://github.com/yourusername/mouse-street-runner.git
    cd mouse-street-runner
    ```
3. Open `project.godot` with Godot Editor and hit **Run** (F5).

---

### **JavaScript/Web Version**

A JavaScript/browser version of this demo is included in the `html/` directory of the repo.

#### **How to run it locally:**

1. Open a terminal in the project folder.
2. Start a local server (Python 3 required):
    ```sh
    cd html
    python -m http.server 8000
    ```
3. Open your browser and go to [http://localhost:8000](http://localhost:8000)
4. Play the web version of Mouse Street Runner!

> *Note: Opening the HTML file directly (double-clicking) may not work due to browser security restrictions. Use a local server as above.*

---

## Project Structure

- `Main.tscn` — Main Godot game scene
- `Player.tscn` — The mouse character
- `Cheese.tscn` — Collectible cheese
- `Cat.tscn` — Enemy obstacle
- `art/` — Images, sprites, icons, etc.
- `html/` — JavaScript version of the game (see above)

---

## Screenshots

*(To Add game screenshots here!)*

---

## Credits

GPT4.1

---

## License

MIT

---

