# Tomasz Kubica - język imperatywny

## Tabelka cech
- Na 15 punktów
  - 01 (trzy typy)
  - 02 (literały, arytmetyka, porównania)
  - 03 (zmienne, przypisanie)
  - 04 (print)
  - 05 (while, if)
  - 06 (funkcje, rekurencja)
  - 07 (przez zmienną / przez wartość)
  - 08 (zmienne read-only i pętla for)
- Na 20 punktów
  - 09 (przesłanianie i statyczne wiązanie)
  - 10 (obsługa błędów wykonania)
  - 11 (funkcje zwracające wartość)
- Na 30 punktów
  - 12 (4) (statyczne typowanie)
  - 13 (2) (funkcje zagnieżdżone ze statycznym wiązaniem)
  - 16 (1) (break, continue)
  - 17 (~~4~~ 3) (funkcje wyższego rzędu, domknięcia)

Razem: 30

## Opis uruchomienia

Wykonanie polecenia `make` wygeneruje plik wykonywalny `interpreter`.
Nazwę pliku do zinterpretowania należy podać jako argument 
(`./interpreter program.txt`), alternatywnie program może zostać
przekazany przez standardowe wejście.

## Ogólny opis rozwiązania

Logika interpretera podzielona została na dwa moduły
`TypeChecker` i `Interpreter`. Najpierw program sprawdzany jest 
type checkerem i jedynie gdy to sprawdzenie zakończy się bez błędów
program jest interpretowany.

Type checker korzysta z monady będącej połączeniem monad
reader i except. Reader pozwala przekazywać środowisko
określające typy zadeklarowanych zmiennych (mapa: `Id -> Type`).
Except wykorzystywany jest do zwracania wykrytych błędów.

Interpreter korzysta z monady będącej połączeniem monad
except, writer, reader i state.
Except służy do obsługi błędów wykonania oraz implementacji
funkcjonalności `return`, `break` oraz `continue`.
Writer służy do implementacji dyrektywy `print`.
Reader służy do przekazywania środowiska (`env`, mapa: `Id -> Loc`),
state do przekazywania stanu (`store`, mapa: `Loc -> Val`).

## Opis Funkcjonalności

Składnia języka bazuje na składni *Latte*. 

W języku występują trzy typy `int`, `string` i `bool`. Na typie `int`
można wykonywać standardowe operacje arytmetyczne, na typie `string`
można wykonywać dodawanie a na `bool` negację,
ponadto na `int` i `string` można wykonywać porównania (w obrębie tego samego typu).

Program składa się 
z ciągu instrukcji (`Stmt`), które są po kolei wykonywane podczas 
wykonywania programy (podobnie jakbyśmy wykonywali Python-owy skrypt).

Deklaracja wszystkich stałych, zmiennych lub funkcji wymaga określenia
ich typów, dotyczy to również funkcji wyższego rzędu.

W języku **NIE** ma polimorfizmu, można napisać funkcję składającą
dwie funkcje o określonych typach, ale nie można zaimplementować ogólnego złożenia.

Brak jeżeli podczas wykonywania funkcji nie zostanie wykonane `return`
to program zakończy się odpowiednim błędem.

Standardowa deklaracja funkcji tworzy stałą której wartością jest
zdefiniowana funkcja. Można tworzyć zmienne trzymające funkcje,
ale trzeba je zainicjować istniejącą funkcją
(brak funkcji anonimowych i niezainicjowanych zmiennych).

Domknięcia przechwytują wszystkie zmienne widoczne w miejscu deklaracji
tej funkcji (innymi słowy wszystkie występujące w środowisku w którym
zadeklarowano funkcję) poprzez referencję.
Oznacz to że funkcja przechwytuje zarówno zmienne lokalne,
jak i globalne, o ile nie zostały przysłonięte.

Statyczne sprawdzanie typów działa w standardowy sposób,
jak wspomniano wcześniej wszystkie typy muszą być zadeklarowane
przez programistę, nie jest przeprowadzana żadna 
dedukcja / rekonstrukcja typów.
Nie można napisać `x = 1`, jeżeli `x` nie był wcześniej zadeklarowany.

Do funkcji argument można przekazywać przez wartość lub zmienną (`&`).
Działanie standardowe jak w `C++`.
Przy wywołaniu jako argument typu `&` można przekazać jedynie zmienną,
nie można stałej lub po prostu wartości 
(np. `2 + 2`, `f(2)` lub `x + 1`).

Zakaz przypisywania do stałych będzie sprawdzany podczas statycznej
weryfikacji typów, a podczas wykonania nie ma różnicy między stałą a zmienną.

Pętla for działa tak jak przykład opisany w treści zadania

> `for i = pocz to kon` - wewnątrz pętli nie można zmienić wartości zmiennej sterującej, wartość `kon` liczona tylko raz - przed wejściem do pętli

Break i continue działają standardowo, wykonanie break lub continue
poza pętlą kończy się zakończeniem działania programu błędem wykonania.
