	.data                         # Sekcja danych, używana do deklaracji zmiennych i stałych
prompt: .asciz "Enter string:\n" # Zapisuje ciąg znaków "Enter string:\n", zakończony znakiem null
buf:	.space 100                # Rezerwuje 100 bajtów przestrzeni na bufor do przechowywania ciągu

	.text                        # Sekcja tekstowa, zawiera kod programu
	.globl main                  # Deklaruje funkcję main jako globalną (punkt wejścia)
main:
	li a7, 4                    # Ustawia wartość 4 w rejestrze a7 (system call dla wyświetlania ciągu)
	la a0, prompt               # Wczytuje adres ciągu "Enter string:\n" do rejestru a0
	ecall                       # Wykonuje wywołanie systemowe (wyświetla ciąg)

	li a7, 8                    # Ustawia wartość 8 w rejestrze a7 (system call dla czytania ciągu)
	la a0, buf                  # Wczytuje adres bufora do rejestru a0
	li a1, 100                  # Ustawia wartość 100 w rejestrze a1 (maksymalna liczba znaków do czytania)
	ecall                       # Wykonuje wywołanie systemowe (czyta ciąg do bufora)

	li t0, '0'                  # Ustawia ASCII wartość '0' w rejestrze t0
	li t1, '9'                  # Ustawia ASCII wartość '9' w rejestrze t1
	li t5, 0x39                 # Ustawia wartość 0x39 (ASCII dla '9') w rejestrze t5

	la t3, buf                  # Wczytuje adres bufora do rejestru t3
	lb t4, (t3)                 # Wczytuje bajt z adresu wskazanego przez t3 do rejestru t4
	beqz t4, end                # Jeśli t4 jest 0 (null), przechodzi do etykiety end

loop:
	blt t4, t0, next            # Skacze do next, jeśli t4 jest mniejsze niż '0'
	bgt t4, t1, next            # Skacze do next, jeśli t4 jest większe niż '9'
	lb t6, (t3)                 # Wczytuje bajt z adresu wskazanego przez t3 do rejestru t6
	addi t6, t6, -48            # Odejmuje 48 od wartości w rejestrze t6 (konwertuje ASCII cyfry na liczbę)
	sub t4, t5, t6              # Odejmuje wartość w t6 od wartości 0x39, wynik zapisuje w t4
	sb t4, (t3)                 # Zapisuje bajt z t4 z powrotem do adresu wskazanego przez t3
next:
	addi t3, t3, 1              # Inkrementuje adres w t3
	lb t4, (t3)                 # Wczytuje kolejny bajt do t4
	bnez t4, loop               # Jeśli t4 nie jest 0, wraca do początku pętli
end:

	li a7, 4                    # Ustawia wartość 4 w rejestrze a7 (system call dla wyświetlania ciągu)
	la a0, buf                  # Wczytuje adres bufora do rejestru a0
	ecall                       # Wykonuje wywołanie systemowe (wyświetla zmodyfikowany ciąg)

	li a7, 10                   # Ustawia wartość 10 w rejestrze a7 (system call dla zakończenia programu)
	ecall                       # Wykonuje wywołanie systemowe (kończy program)
