.PHONY: postgres createdb dropdb migrateup migratedown

postgres:
	docker run --name postgres -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=postgres -d postgres

createdb:
	docker exec postgres createdb --username=root --owner=root simple_bank

dropdb:
	docker exec postgres dropdb simple_bank

migrateup:
	migrate -path db/migration -database "postgresql://root:postgres@localhost:5432/simple_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://root:postgres@localhost:5432/simple_bank?sslmode=disable" -verbose down

# Optional: Create database with a custom name
createdb_custom:
	docker exec postgres createdb --username=root --owner=root $(DB_NAME)