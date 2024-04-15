	.data                        # Deklaracja sekcji danych
prompt:	.asciz "Enter string:\n"  # Zapisuje string z znakiem nowej linii, zakończony null-em
buf:	.space 100                # Alokuje 100 bajtów przestrzeni na bufor

	.text                        # Deklaracja sekcji kodu
	.globl main                  # Deklaruje funkcję main jako globalną (punkt wejścia)
main:                           # Etykieta na początek funkcji main
	li a7, 4                     # Wczytuje wartość 4 do rejestru a7 (wywołanie systemowe do drukowania stringa)
	la a0, prompt                # Wczytuje adres stringa prompt do rejestru a0
	ecall                        # Wykonuje wywołanie systemowe (drukuje prompt)

	li a7, 8                     # Wczytuje wartość 8 do rejestru a7 (wywołanie systemowe do czytania stringa)
	la a0, buf                   # Wczytuje adres bufora do rejestru a0
	li a1, 100                   # Wczytuje wartość 100 do rejestru a1 (maksymalna liczba bajtów do odczytu)
	ecall                        # Wykonuje wywołanie systemowe (czyta string do bufora)

	li a2, 3                     # Wczytuje wartość 3 do rejestru a2 (używane do liczenia co trzeciej litery)
	li t0, 'a'                   # Wczytuje wartość ASCII 'a' do tymczasowego rejestru t0
	li t1, 'z'                   # Wczytuje wartość ASCII 'z' do tymczasowego rejestru t1

	la t3, buf                   # Wczytuje adres bufora do tymczasowego rejestru t3
	lb t4, (t3)                  # Wczytuje bajt z adresu w t3 do tymczasowego rejestru t4
	beqz t4, end                 # Jeśli bajt to zero (koniec stringa), skocz do etykiety end

loop:                           # Etykieta początku pętli
	blt t4, t0, next            # Jeśli t4 < 'a', skocz do etykiety next
	bgt t4, t1, next            # Jeśli t4 > 'z', skocz do etykiety next
	addi t2, t2, 1              # Inkrementuj rejestr t2 o 1
	rem a5, t2, a2              # Oblicza t2 % 3, wynik zapisuje w rejestrze a5
	bnez a5, next               # Jeśli a5 ≠ 0, skocz do etykiety next

every_third:                   # Etykieta dla akcji wykonywanej co trzecią literę
	addi t4, t4, -0x20         # Zmniejsza wartość w t4 o 32 (zamiana małych liter na duże)

next:                          # Etykieta dla przejścia do następnego bajtu
	sb t4, (t3)                # Zapisuje bajt z t4 do adresu w t3
	addi t3, t3, 1             # Inkrementuje adres w t3 o 1
	lb t4, (t3)                # Wczytuje kolejny bajt do t4
	bnez t4, loop              # Jeśli t4 ≠ 0, kontynuuj pętlę
end:                           # Etykieta końca

	li a7, 4                     # Wczytuje wartość 4 do rejestru a7 (wywołanie systemowe do drukowania stringa)
	la a0, buf                   # Wczytuje adres bufora do rejestru a0
	ecall                        # Wykonuje wywołanie systemowe (drukuje zawartość bufora)

	li a7, 10                    # Wczytuje wartość 10 do rejestru a7 (wywołanie systemowe do zakończenia programu)
	ecall                        # Wykonuje wywołanie systemowe (zakończenie programu)
