# The Stall: Game Design Draft

Working title. Design draft v1 for a 2D pixel-art puzzle-sandbox about wiring logic circuits that rewrite the rules of the world.

## Concept

You wake up in a town where everything has stopped. You restore it by designing digital logic circuits at a workbench and wiring them into the world. Simple devices (batteries, switches, lamps, doors, motors) are your inputs and outputs. Rare ancient machines called Rule Nodes let your circuits change the rules of the land itself, in the spirit of Baba Is You: what water does, what is solid, what conducts power.

Target length: a 2 to 3 hour story playthrough, followed by an open sandbox.

## Core Loop

1. Explore and find something broken or blocked.
2. Inspect which device or Rule Node is involved.
3. Design a circuit at the Bench.
4. Place it in the Field and wire it up.
5. Watch the world change.
6. Unlock the next area, rule or tool.

## World and Lore

The world runs on the Lattice, an ancient network of stone-and-metal pylons called Rule Nodes. Each node governs one property of its region: whether water flows or freezes, whether a surface conducts, whether something is solid. The old civilization built circuits that talked to the nodes, so towns could shape their land.

Everything ran off a single Master Clock, the pulse that makes every circuit tick. One day the clock stopped. This is the Stall. Every circuit froze, the power grid died, and every rule locked into whatever state it was in when the pulse ended.

The world is not destroyed, only paused. That is why it can be repaired, and why restoring the clock is the final milestone.

The mystery to reveal across the story is who stopped the clock, and why. Proposed answer: it was deliberate, to contain a runaway rule that was spreading across the Lattice. The final choice is whether to restart it.

## Characters

**Unnamed (the player).** Everyone in the world knows who he is, but he does not know himself. Because they know him, people are willing to talk to him and help him. The game calls him Unnamed. All dialogue is short and text-only, with portraits.

- **The Scavenger Kid.** Knows where parts and salvage are. Practical, curious, not a teacher. Brings the player their first useful objects.
- **The Old Engineer.** Remembers the theory and the old schematics but can no longer read the circuits. Explains why things work, never how to build them.
- **Dormant machines.** Caretaker robots and lamplighters stuck mid-routine. Repairing one is a small circuit puzzle, and each becomes a helper or shopkeeper.
- **Townsfolk.** A small group of survivors, each with a concrete need (the bakery oven, the dark clinic, the sealed granary) that motivates a build.

## Perspective and Look

- 2D top-down, pixel art, grid-based.
- Top-down fits the flat layout of wiring, matches the Bench grid, and keeps rule changes readable from above.
- Rules therefore concern flow, conductivity and solidity rather than gravity.

## The Bench and the Field

The game has two scales of play.

- **The Bench:** a zoomed-in grid view where you design a chip from gates and wires. Free and unlimited. This is the heart of the game.
- **The Field:** the world view, where you place finished chips, run cable between devices and connect to Rule Nodes.

Early on, the only Bench is in the town hall. A portable bench is found partway through the story, so players can design anywhere afterwards.

## Building Blocks

**Primitives:** AND, OR and NOT. These are the only gates the player is given. Everything else is built from them.

**Derived parts:** XOR, latches (memory), flip-flops, counters, adders. Players can build these themselves, or find blueprints in the world that save effort. A blueprint always shows the gates inside, so nothing is a black box.

**Timer:** needs a clock pulse to count. Early on it runs off a small local clock found in the world. Later it can use the restored Master Clock.

**Saving chips:** any finished circuit can be saved as a single reusable chip. This is the main source of vastness: gates become adders, adders become bigger machines, and each becomes a block in the toolbox.

**Materials:** designing is free. Placing a chip in the world costs scrap and wire, scaled by how many gates it contains. This gives exploration a purpose and rewards efficient designs.

## Devices and Rule Nodes

**Devices** are plain inputs and outputs, wired directly:

- Inputs: switches, buttons, sensors (light, motion, pressure, wetness), clocks.
- Outputs: lamps, doors, motors, speakers, displays.
- Power: batteries and generators are limited resources the story provides.

**Rule Nodes** are rare pylons that control one property for a region. Each shows its current state with a glowing icon and has sockets for your logic. Restoring a node unlocks a new kind of rule to play with.

Starting set of properties (kept small on purpose): water state (liquid or ice), solid or passable, conductive or insulating, and one more unlocked late.

Open design question: how conflicting rules are resolved (for example, a wall that is made passable while a switch is mounted on it). Proposal: rules update on a fixed tick in a fixed order, with a visible indicator of which rules are active and why.

## How the Player Gets the Primitives

The player never receives all three gates at once. Each gate is introduced by a need first, then handed over. This is the first 20 to 25 minutes of play.

1. **Wire, battery, switch, lamp.** The player starts with only these, found on the workbench in the town hall. They build the first circuit and light the first lamp.
2. **AND.** The granary door will not open. It has two heavy levers that must be held at once, and the player cannot reach both. The Old Engineer sketches the idea of "both together" from his memory. The bench has a sealed parts drawer; powering the bench with the player's first circuit opens it and reveals the AND gate.
3. **NOT.** The street lamps should be on at night and off by day, but the only sensor available is a daylight sensor that outputs on when it is bright. The Scavenger Kid arrives with a salvaged "flipper" from the old street lamps. This is NOT. The kid brings it as salvage, not as knowledge.
4. **OR.** The bakery has two doors and either should open the oven vent. The Old Engineer's notebook, recovered from the bakery, contains the OR gate diagram. The player builds it at the bench from the diagram.

So the kid does supply one gate, but as a scavenger finding a part, not as a teacher who knows everything. The knowledge comes from the engineer and from experiment, and the rest of the game builds on this trio.

## Playthrough Structure (2 to 3 hours)

| Chapter | Approx. time | What happens |
| --- | --- | --- |
| 1. The Dark Town | 25 min | Wake up. First circuit. Receive AND, NOT, OR. Light the street, open the granary. |
| 2. The River | 25 min | First Rule Node. Freeze the river to cross, then unfreeze it for the water wheel. Learn timers and memory (latch). |
| 3. The Foundry | 30 min | Repair a dormant machine. Derive XOR and build a counter. Find the portable bench. |
| 4. The Pylon Line | 30 min | Conditional rules: a rule that depends on a sensor or switch state. Conductivity node. Power the town. |
| 5. The Master Clock | 30 to 40 min | Learn what happened. Build the large final circuit. Choose whether to restart the clock. |

**Semi-open structure.** Within each chapter the player can explore freely and solve problems in any order. Chapters still gate on key milestones, such as restoring a Rule Node, so the 2 to 3 hour pacing holds.

Ending: restarting the clock brings the world back to life but also releases the runaway rule. Leaving it stopped keeps the world safe but frozen. Both can be a satisfying ending with a short epilogue.

## After the Credits

A free sandbox mode with all gates, all nodes and the full chip library unlocked. This is where the Minecraft-style vastness lives: players build whatever they like and share chip designs. It also keeps the 2 to 3 hour story tight without capping what the game can do.

## Scope Guardrails

- Four or five rule properties at launch, not more.
- Three Rule Nodes in the story, one more in sandbox.
- No analog behavior. Everything is on or off.
- One clock model, tick-based.
- Story chapters teach one new idea each.

## Decisions and Open Questions

- Decided: semi-open world, with free exploration inside each chapter.
- Decided: the player is Unnamed. Open: what his past turns out to be, and how it connects to the Stall.
- Decided: short, text-only dialogue with portraits.
- Prototype first: one rule register, one property (water solid or liquid), one puzzle.
