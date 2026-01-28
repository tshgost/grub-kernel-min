; src/boot.asm  (NASM)
BITS 16
ORG 0x7C00

start:
    cli
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00
    sti

    mov [boot_drive], dl          ; BIOS passa drive em DL

    ; Verifica se BIOS suporta INT 13h Extensions (LBA)
    mov ah, 0x41
    mov bx, 0x55AA
    mov dl, [boot_drive]
    int 0x13
    jc disk_error
    cmp bx, 0xAA55
    jne disk_error
    test cx, 1
    jz disk_error

    ; DAP (Disk Address Packet) para AH=42h
    mov si, dap
    mov ah, 0x42
    mov dl, [boot_drive]
    int 0x13
    jc disk_error

    jmp 0x0000:0x8000             ; salta pro stage2

disk_error:
    mov si, msg_err
    call print
.hang:
    hlt
    jmp .hang

; print string DS:SI (terminada em 0)
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

boot_drive db 0

msg_err db "Disk read error!", 0

; Disk Address Packet (16 bytes)
; 0: size=16, 1: reserved
; 2: sectors to read (word)
; 4: buffer offset (word)
; 6: buffer segment (word)
; 8: LBA (qword)
dap:
    db 16
    db 0
    dw STAGE2_SECTORS             ; quantos setores carregar
    dw 0x8000                     ; offset do buffer
    dw 0x0000                     ; segment do buffer
    dq 1                          ; LBA inicial (setor 1 = logo após MBR)

%define STAGE2_SECTORS 4

times 510-($-$$) db 0
dw 0xAA55
