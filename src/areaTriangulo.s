section .text
global _start
_start:
	push B
	call LerInteiro
	add esp, 4
	imul dword[H]
	cdq
	idiv dword[DOIS]
	mov dword[R], eax
L1:
	mov eax, 1
	mov ebx, 0
	int 80h
LerChar:
	enter 0, 0
	pusha
	mov eax, 3
	mov ebx, 0
	mov ecx, [EBP+8]
	mov edx, 1
	int 80h
	popa
	leave
	ret
LerInteiro:
	enter 5, 0
	pusha
	mov ebx, ebp
	sub ebx, 1
	mov dword[EBP-5], 0
leitura_inteiro:
	push ebx
	call LerChar
	add esp, 4
	cmp byte[EBP-1], 0xa
	je fim_inteiro
	mov eax, [EBP-5]
	mov edx, eax
	shl eax, 2
	add eax, eax
	add eax, edx
	add eax, edx
	mov [EBP-5], eax
	mov eax, [EBP-1]
	sub eax, 0x30
	add [EBP-5], eax
	jmp leitura_inteiro
fim_inteiro:
	mov eax, [EBP-5]
	mov ebx, [EBP+8]
	mov [ebx], eax
	popa
	leave
	ret

section .data
OVERFLOW dd 'o', 'v', 'e', 'r', 'f', 'l', 'o', 'w'
H dd 4
DOIS dd 2

section .bss
B resd 1
R resd 5
