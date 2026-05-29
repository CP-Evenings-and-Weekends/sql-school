# SQL School

In this challenge you'll create a small school database from scratch: write the schema, load seed data, then make a series of modifications.  This exercises SQL's data-definition (`CREATE`, `ALTER`) and data-modification (`INSERT`, `UPDATE`) sides — different from the `SELECT`-heavy queries you've been doing all week.

Starter files: `create-schema.sql`, `seed-data.sql`.

## SQL refresher

Every database server supports these core commands.  You'll touch all of them in this challenge.

| Command | What it does |
|---|---|
| `SELECT` | Query one or more tables for rows matching criteria |
| `INSERT` | Add new rows to a table |
| `UPDATE` | Change column values on rows matching criteria |
| `DELETE` | Remove rows matching criteria |
| `CREATE` | Create new tables (or other database objects) |
| `DROP` | Delete entire tables |
| `ALTER` | Change a table's structure (add/remove columns, etc.) |

## Common Postgres column types

| Description | Type |
|---|---|
| Integer numbers from -2³¹ to 2³¹ | `INTEGER` |
| Fractional number | `DECIMAL` |
| Variable-length string (1–255 chars) | `VARCHAR(n)` |
| Fixed-length string | `CHARACTER(n)` |
| Longer strings, up to 16 KB | `TEXT` |
| Date, no time | `DATE` |
| Date with time | `TIMESTAMP` |

## Requirements

### 1. Create a database

Postgres supports multiple databases, so create a fresh one named `school`:

```bash
$ createdb school
```

Connect with `psql` and list tables — should be empty:

```bash
$ psql school
school=# \d
No relations found.
```

### 2. Write the schema

Open `create-schema.sql`.  The `students` table is already written for you:

```sql
DROP TABLE IF EXISTS students;
CREATE TABLE students (
  id           serial PRIMARY KEY,
  first_name   varchar(255) NOT NULL,
  last_name    varchar(255) NOT NULL,
  birthdate    date NOT NULL,
  address_id   integer
);
```

Add `CREATE TABLE` statements for these three tables.  Use the column-type table above to pick types, and decide which columns should be `NOT NULL`:

**addresses** — `id`, `line_1`, `city`, `state`, `zipcode`

**classes** — `id`, `name`, `credits`

**enrollments** — `id`, `student_id`, `class_id`, `grade`

Notes:
- `serial` is a special Postgres type that gives you an auto-incrementing integer — use it for every `id` column.
- Primary keys are `NOT NULL` by default; you don't need to spell it out.
- Give thought to which other columns make sense as `NOT NULL`.

Load and reload your schema as you go:

```bash
$ psql school < create-schema.sql
```

### 3. Inspect your schema

After loading, connect with `psql school` and inspect each table with `\d`:

```
school=# \d students
                                   Table "public.students"
   Column   |          Type          |                       Modifiers
------------+------------------------+------------------------------------------------
 id         | integer                | not null default nextval('students_id_seq'...)
 first_name | character varying(255) | not null
 ...
```

### 4. Load the seed data

```bash
$ psql school < seed-data.sql
```

You should see a stream of `INSERT 0 1` lines.  If you see errors, your schema probably doesn't match — fix the schema and rerun both files.

Verify with a `SELECT` on each table:

```sql
SELECT * FROM students;
SELECT * FROM addresses;
SELECT * FROM classes;
SELECT * FROM enrollments;
```

### 5. Make the following modifications

Write each as a SQL script and run it.  You can put them all in a single `modifications.sql` or split them out — your call.

1. **Insert** an additional address into the `addresses` table.
2. **Update** the `students` table so the student without an address gets assigned to the new address.
3. **Insert** a sibling of that same student as a new row in `students` (same last name, different first name).
4. **Create** a new table `extracurriculars` (e.g. football, journalism, debate team) with `id` and `name`.
5. **Insert** at least 3 rows into `extracurriculars`.
6. **Alter** the `students` table to add a new column `extracurricular_id` referencing the `extracurriculars` table.
7. **Update** the `students` table to assign each student an `extracurricular_id`.

## Things to think about
- Why use `serial` for primary keys instead of a column you might already have (e.g. social security number, ISBN)?  What's the cost of "natural" keys vs synthetic ones?
- When should a column be `NOT NULL`?  What's the tradeoff?
- After step 6, every existing row in `students` has `NULL` in the new column.  How does Postgres handle that — and what would happen if you added the column as `NOT NULL` instead?
- `DELETE` vs `DROP` — what's the difference and when would you pick each?

## Stretch
- Add a `CHECK` constraint on `students.birthdate` to reject future dates.
- Add a `UNIQUE` constraint on `(student_id, class_id)` in `enrollments` so a student can't be enrolled in the same class twice.
- Add a `grade` column to `enrollments` that's constrained to values in `('A', 'B', 'C', 'D', 'F', 'INC')` — look up Postgres `CHECK` constraints.
- Write a SELECT that joins all four (now five) tables and prints each student's name, their address city, their classes, and their extracurricular.

> Stuck? Have a code error? Use the ["4 Before Me"](https://docs.google.com/document/d/1nseOs5oabYBKNHfwJZNAR7GlU0zkZxNagsw63AD7XV0/edit) debugging checklist to help you solve it!
