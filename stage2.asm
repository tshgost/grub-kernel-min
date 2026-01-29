; src/stage2.asm (NASM)
BITS 16
ORG 0x8000

stage2:
    cli
    xor ax, ax
    mov ds, ax
    sti

    mov si, msg
    call print
.hang:
    hlt
    jmp .hang

print:
    mov ah, 0x0E
.next:
    lodsb
    test al, al
    jz .done
    int 0x10
    jmp .next
.done:
    ret

msg db 13,10, "Stage2 loaded! Hello from MBR loader.", 13,10, 0
