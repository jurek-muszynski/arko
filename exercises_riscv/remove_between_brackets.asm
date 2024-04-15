	.data                          # Sekcja danych, miejsce na zmienne i stałe
prompt: 	.asciz "Enter string:\n"  # Zapisuje ciąg znaków zakończony znakiem nowej linii i null-em
buf:		.space 100                # Rezerwuje 100 bajtów miejsca w pamięci na bufor dla wejściowego ciągu
result: 	.space 100                # Bufor na wynikowy ciąg po usunięciu znaków

	.text                          # Sekcja tekstowa, zawiera kod programu
	.globl main                    # Deklaruje funkcję main jako dostępną globalnie
main:
	jal remove                     # Skok do funkcji remove i zapisanie adresu powrotu
	b final                        # Skok do etykiety final po wykonaniu funkcji remove

remove:

	li a7, 4                      # Wczytuje stałą 4 do rejestru a7 (system call dla wyjścia)
	la a0, prompt                 # Wczytuje adres etykiety prompt do rejestru a0
	ecall                         # Wywołuje system call (drukuje prompt)

	li a7, 8                      # Wczytuje stałą 8 do rejestru a7 (system call dla wejścia)
	la a0, buf                    # Wczytuje adres bufora buf do rejestru a0
	li a1, 100                    # Wczytuje wartość 100 do rejestru a1 (limit bajtów do wczytania)
	ecall                         # Wywołuje system call (wczytuje string do bufora)

	li t0, 0x5B                   # Wczytuje kod ASCII dla '[' do rejestru t0
	li t1, 0x5D                   # Wczytuje kod ASCII dla ']' do rejestru t1
	li t2, 0x2A                   # Wczytuje kod ASCII dla '*' do rejestru t2

	la t3, buf                    # Wczytuje adres bufora buf do rejestru t3 (wskaźnik do przeszukiwania)
	la t4, result                 # Wczytuje adres bufora result do rejestru t4 (wskaźnik do zapisu wyniku)
	li a2, 0                      # Ustawia wskaźnik na pierwszy znaleziony '[' na 0
	li a3, 0                      # Ustawia wskaźnik na pierwszy znaleziony ']' na 0
	li a4, 0                      # Długość wyniku ustawiona na 0


search_left_bracket:
	lb t5, (t3)                   # Wczytuje bajt wskazywany przez t3
	beqz t5, end_loop             # Jeśli t5 jest zero (koniec stringa), idź do end_loop
	beq t5, t0, found_left_bracket # Jeśli t5 to '[', idź do found_left_bracket
	addi t3, t3, 1                # Przesuń t3 o jeden bajt w prawo
	b search_left_bracket         # Powróć do szukania '['

found_left_bracket:
	mv a2, t3                     # Zapisz pozycję '[' w a2

search_right_bracket:
	lb t5, (t3)                   # Wczytuje bajt wskazywany przez t3
	beqz t5, end_loop             # Jeśli t5 jest zero (koniec stringa), idź do end_loop
	beq t5, t1, found_right_bracket # Jeśli t5 to ']', idź do found_right_bracket
	addi t3, t3, 1                # Przesuń t3 o jeden bajt w prawo
	b search_right_bracket        # Powróć do szukania ']'

found_right_bracket:
	mv a3, t3                     # Zapisz pozycję ']' w a3


end_loop:
	beqz a2, end                  # Jeśli nie znaleziono '[', idź do end
	beqz a3, end                  # Jeśli nie znaleziono ']', idź do end
	la t0, buf                    # Wczytuje adres bufora buf do rejestru t0
	lb t1, (t0)                   # Wczytuje pierwszy bajt bufora

remove_loop:
	ble t0, a2, next              # Kontynuuj, jeśli jesteśmy przed '['
	bge t0, a3, next              # Kontynuuj, jeśli jesteśmy za ']'
	addi t0, t0, 1                # Przesuń wskaźnik t0
	lb t1, (t0)                   # Wczytaj kolejny bajt
	bnez t1, remove_loop          # Kontynuuj pętlę, jeśli nie koniec stringa
	b end                         # Zakończ jeśli koniec stringa


next:
	sb t1, (t4)                   # Zapisz bajt z t1 do wyniku w t4
	addi t4, t4, 1                # Przesuń wskaźnik wyniku
	addi a4, a4, 1                # Inkrementuj długość wyniku
	addi t0, t0, 1                # Przesuń wskaźnik bufora
	lb t1, (t0)                   # Wczytaj kolejny bajt
	bnez t1, remove_loop          # Kontynuuj pętlę, jeśli nie koniec stringa

end:
	ret                           # Powrót z funkcji remove

final:

	li a7, 4                      # Wczytuje stałą 4 do rejestru a7 (system call dla wyjścia)
	la a0, result                 # Wczytuje adres bufora result do rejestru a0
	ecall                         # Wywołuje system call (drukuje wynikowy string)

	addi a4, a4, -1               # Dekrementuje długość wyniku o jeden

	li a7, 1                      # Wczytuje stałą 1 do rejestru a7 (system call do zakończenia)
	mv a0, a4                     # Przekazuje długość wyniku do rejestru a0
	ecall                         # Wywołuje system call (zamyka program)

	li a7, 10                     # Wczytuje stałą 10 do rejestru a7 (system call do zakończenia programu)
	ecall                         # Wywołuje system call, kończąc działanie programu
