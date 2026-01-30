# grub-kernel-min

Um experimento mínimo de boot/kernel para aprender o pipeline de boot (GRUB + assembly + linker script).

> Status: WIP / experimental. A ideia é manter pequeno e didático.

## O que tem aqui
- `stage2.asm` — estágio/kernel em assembly (WIP)
- `bot.asm` — rotinas auxiliares (WIP)
- `linker.ld` — script de link
- `Makefile` — build

## Build
Use o `Makefile` como fonte de verdade:

```bash
make
