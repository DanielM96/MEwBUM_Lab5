# MEwBUM_Lab5
Metody eksperymentalne w badaniach układów mechatronicznych - Matlab GUI - Lab5

Laboratorium nr 5 - pomiary drgań wentylatora i piły

# Zawartość

___Csv2Mat.m___

Funkcja konwertująca pliki w formacie do plików w formacie MAT (por. https://github.com/DanielM96/MEwBUM_Lab3).

___GUI_FanAndSaw___

Główny moduł. Pozwala wczytywać dane, wyświetlać przebieg czasowy, widmo, spektrogram. Dodatkowo, zaimplementowana została filtracja górnoprzepustowa.

___GUI_Kinematics___

Moduł uruchamiany z poziomu _GUI_FanAndSaw_, pozwala wyświetlić przyspieszenia, prędkości i przemieszczenia.

___hipassFilter.m___

Funkcja realizująca filtrację górnoprzepustową. Jako parametry przyjmuje sygnał wejściowy (wymagany), częstotliwość odcięcia filtru (niewymagana, domyślnie 30 Hz) i częstotliwość próbkowania sygnału (niewymagana, domyślnie 25000 Hz). Wykorzystywany jest filtr Chebyshewa typu II.

___importCSV.m___

Funkcja importująca dane z plików CSV. Wykorzystywano bezpośrednio w _Csv2Mat.m_.

___iomega.m___

Funkcja pozwalająca wyznaczyć prędkości i przemieszczenia z sygnału przyspieszenia.

Źródło: https://www.mathworks.com/matlabcentral/answers/21700-finding-the-velocity-from-displacement.
