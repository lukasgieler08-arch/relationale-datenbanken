#Begrifflichkeiten 
Entitätstypen sind Datenbanktabellen (Datencontainer) in denen meine Daten dauerhaft strukturiert abgelegt () gespeichert werden. Dabei muss unbedingt wert darauf gelegt werden, dass die Struktur und die Zusamenhänge zwischen den Datencontainer stimmig sind, ansonsten stoßen anwendungen/Apps schnell an ihre Grenzen.
Nomen/Substantive Teilnehmer, Kurse, Termine, Lehrkräfte, Teams, Auswertungen, Buchungen, Zuordnungen
Feststellung der Kardinalität das ist der Mängen mäsige Zusamenhang
--> Eine Sätze unbedingt anwenden (2 seitige Betrachtung)

ein Teilnehmender kann eine oder mehrere Buchungen Vornehmen (N) Buchungen sind mehrere möglich
eine Buchung wurde von genau einem Teilnehmer Vorgenomen (1) es ist nur einmal möglich

Model dann Relation ship Notation
Merke im falle einer 1 zu n beziehung Laandet der Primärschlüsselatribut des Ententitätstyp mit der Kardinalität 1 (idTeilnehmer) als Kopie in Ententitätstypen mit der Kardinalität N (Buchungen)

Kurse Terimine
1 Ein Kurs werden ein oder mehrere termin zugeordnet (N)weil mehrere     Termine
2 ein Termin kann einem oder mehreren Kursen zugeordnet werden(M) eine NM Bezihung komplexeste bezihung zwischen datenbanken

Merke im falle einem N:N Bezihung wird die Komplexität aufgelöst indem eine zusätzliche Datenbank Tabelle Entetitätstyp eingefügt wird diese Zusamenhangstabelle erfasst die Kopie der Fremdschlüsselwerte in Kombination erfasst. Die Kombination ist eindeutig (identifiziert) in der ZUsamenhangstabelle (Kurse hat Termine) ud bildet dort einen komprimierten Primärschlüssel Das ist immer so bei einer N:N Beziehung Aus Nzu N wird immer 1:N und N:1

N zu M sie lehrkraft hat mehrere Kurse und ein Kurs ggf mehrere Lehrer

Kurse Buchungen 
eine Buchung wird ein Kurs 1
einem Kurs werden Mehrere Buchungn N