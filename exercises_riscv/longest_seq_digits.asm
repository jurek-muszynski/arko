	.data                       # Sekcja danych, miejsce na zmienne i stałe
prompt: .asciz "Enter string:\n" # Zapisuje ciąg znaków zakończony znakiem nowej linii i null-em
buf:	.space 100               # Rezerwuje 100 bajtów miejsca w pamięci na bufor dla wejściowego ciągu
text:	.space 100               # Dodatkowy bufor o rozmiarze 100 bajtów
max: 	.space 100               # Bufor na najdłuższą sekwencję cyfr

	.text                       # Sekcja tekstowa, zawiera kod programu
	.globl main                 # Deklaruje funkcję main jako dostępną globalnie
main:
	li a7, 4                   # Wczytuje stałą 4 do rejestru a7 (system call dla wyjścia)
	la a0, prompt              # Wczytuje adres etykiety prompt do rejestru a0
	ecall                      # Wywołuje system call (drukuje prompt)

	li a7, 8                   # Wczytuje stałą 8 do rejestru a7 (system call dla wejścia)
	la a0, buf                 # Wczytuje adres bufora buf do rejestru a0
	li a1, 100                 # Wczytuje wartość 100 do rejestru a1 (limit bajtów do wczytania)
	ecall                      # Wywołuje system call (wczytuje string do bufora)

	li t0, '0'                 # Wczytuje kod ASCII znaku '0' do rejestru t0
	li t1, '9'                 # Wczytuje kod ASCII znaku '9' do rejestru t1
	li t2, 0                   # Ustawia t2 na 0, przechowuje aktualną długość sekwencji cyfr
	li t3, 0                   # Ustawia t3 na 0, przechowuje maksymalną długość sekwencji cyfr
	la t4, buf                 # Wczytuje adres bufora buf do rejestru t4 (wskaźnik na aktualną sekwencję)
	li t5, 0                   # Ustawia t5 na 0, wskaźnik na koniec maksymalnej sekwencji
	lb t6, (t4)                # Wczytuje pierwszy bajt z bufora do rejestru t6
	beqz t6, end               # Jeśli t6 jest zero (pusty ciąg), skacze do end

loop:
	blt t6, t0, not_digit      # Jeśli t6 < '0', skacze do not_digit
	bgt t6, t1, not_digit      # Jeśli t6 > '9', skacze do not_digit

	addi t2, t2, 1             # Inkrementuje t2 (długość aktualnej sekwencji cyfr)

	bge t2, t3, update_max     # Jeśli t2 >= t3, skacze do update_max

	b next                     # Skacze do etykiety next

update_max:
	mv t3, t2                  # Kopiuje wartość z t2 do t3 (aktualizuje maksymalną długość)
	mv t5, t4                  # Ustawia t5 na aktualny adres w t4 (aktualizuje wskaźnik na maksymalną sekwencję)

next:
	addi t4, t4, 1             # Inkrementuje t4 (przesuwa wskaźnik na kolejny znak)
	lb t6, (t4)                # Wczytuje kolejny bajt do t6
	bnez t6, loop              # Kontynuuje pętlę jeśli t6 nie jest zero
	b end                      # Skacze do end

not_digit:                    # Etykieta dla przypadków, gdy znak nie jest cyfrą
	li t2, 0                   # Resetuje t2 do 0
	addi t4, t4, 1             # Inkrementuje t4
	lb t6, (t4)                # Wczytuje kolejny bajt do t6
	bnez t6, loop              # Kontynuuje pętlę jeśli t6 nie jest zero
	b end                      # Skacze do end

end:

	li a7, 1                   # System call code for exit
	sub t5, t5, t3             # Oblicza początek najdłuższej sekwencji cyfr
	addi t5, t5, 1             # Korekta wskaźnika na początek
	la t2, max                 # Wczytuje adres bufora max do t2
	lb t4, (t5)                # Wczytuje bajt z t5 do t4

end_loop:
	sb t4, (t2)                # Zapisuje bajt z t4 do t2
	addi t2, t2, 1             # Inkrementuje t2
	addi t3, t3, -1            # Dekrementuje t3
	addi t5, t5, 1             # Inkrementuje t5
	lb t4, (t5)                # Wczytuje kolejny bajt z t5 do t4
	bnez t3, end_loop          # Kontynuuje pętlę, jeśli t3 nie jest zero

print_max:

	li a7, 4                   # Wczytuje stałą 4 do rejestru a7 (system call dla wyjścia)
	la a0, max                 # Wczytuje adres bufora max do rejestru a0
	ecall                      # Wywołuje system call (drukuje najdłuższą sekwencję cyfr)

	li a7, 10                  # Wczytuje stałą 10 do rejestru a7 (system call dla zakończenia programu)
	ecall                      # Wywołuje system call, kończąc działanie programu
