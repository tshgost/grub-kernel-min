# grub-kernel-min

Minimal (WIP) boot/kernel experiment loaded via GRUB, focused on learning:
- binary layout (linker script)
- early control flow in assembly
- the “build → boot → debug” pipeline

## Repository contents
- `stage2.asm` — main stage (WIP)
- `bot.asm` — helper routines (WIP)
- `linker.ld` — binary layout/link script
- `Makefile` — build rules

## Build
The default target is `make`:

```bash
make
