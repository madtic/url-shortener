# Hausübung Docker Excersie
Michael Tichelmann
##Schritte
1. UrlShortener entzipt und in Ryder geöffen
2. Github Repo initial commit
3. Dockerfile erzeugt über Ryder dabei wird das Dockerfile automatisch von ryder befüllt
4. Dockerfile testen mit `docker build -t url-shortener .`
5. Starten von Container mit `docker run -d -p 5000:8080 --name url-shortener url-shortener`
6. compose.yaml erstelt mit postgres db wie bei counter app
7. .env Datei mit variablen port geänder auf 5000 weil 8080 auf dev pc schon vergeben
8. Testen mit `docker compose up --build -d` dann swagger auf http://localhost:5000/swagger/index.html
9. Datei für github action erstellt die den container baut
10. CodeQL aktiviert für repo `Setting -> Advanced Security -> CodeQL analysis`
11. Dockerfile.inefficient ist erster versuch -> Dockerfile effizienter gemachht nur ein build 
