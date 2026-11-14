# URL Shortener

A small ASP.NET Core 10 API to create short links and store them in Postgres.
A `GET /{code}` request redirects to the original URL and increments a click counter, so persistence is easy to see.

- Swagger UI at `/swagger`
- PostgreSQL via EF Core (with a checked-in migration)
- One entity, four link endpoints, one redirect endpoint
- Two Dockerfiles: a naively written one and an optimized one

## Endpoints

| Method | Path | Description |
|---|---|---|
| `POST` | `/api/links` | Create a short link |
| `GET` | `/api/links` | List all short links |
| `GET` | `/api/links/{code}` | Get one short link |
| `DELETE` | `/api/links/{code}` | Delete a short link |
| `GET` | `/{code}` | Redirect to the original URL (HTTP 302) |
| `GET` | `/healthz` | App + database health |

Two links are seeded on first start: `/dotnet` and `/docker`.

## Project layout

```text
url-shortener/
├── Program.cs                     # app setup, Swagger, startup migration + seed
├── Endpoints/LinkEndpoints.cs     # all endpoints
├── Models/ShortLink.cs
├── Contracts/LinkContracts.cs     # request/response records
├── Data/
│   ├── ShortLinkDbContext.cs
│   ├── ShortLinkDbContextFactory.cs  # for `dotnet ef`
│   └── Migrations/
└── .env.example
```

## Requirements

Docker with Compose v2 (the `docker compose` command). To run the
API outside Docker you need the .NET 10 SDK and a PostgreSQL 17 instance.

## Run with Docker Compose

From the project directory, create the local environment file and start the API
and database:

```powershell / cmd
docker compose up --build -d
```

Open `http://localhost:8080/swagger`. The API waits for PostgreSQL to become
healthy, then applies its migrations and seeds the sample links. Check startup
logs with `docker compose logs -f urlshortener`.

To stop the services, run `docker compose down`. The database is kept in the
`postgres-data` volume; to delete it and all stored links as well, run
`docker compose down -v`. If host port 8080 is already in use, change
`APP_PORT` in `.env` (for example, to `8082`) and use that port in the URL.
The example database password is for local development only.