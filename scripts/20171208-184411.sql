CREATE TABLE account (
  id serial PRIMARY KEY NOT NULL,
  email VARCHAR(255) NOT NULL,
  normalized_email VARCHAR(255) NOT NULL UNIQUE,
  password_hash VARCHAR(500) NOT NULL,
  locale VARCHAR(5) DEFAULT 'en_ca'
);
CREATE INDEX email_index ON account(normalized_email);

CREATE TABLE member (
  id serial PRIMARY KEY NOT NULL,
  account_id serial REFERENCES account (id) UNIQUE NOT NULL,
  first_name VARCHAR(255),
  last_name VARCHAR(255)
);
CREATE INDEX member_account_index ON member(account_id);

CREATE TABLE team (
    id serial PRIMARY KEY NOT NULL,
    name VARCHAR(255),
    city VARCHAR(255),
    abbreviation VARCHAR(5)
);

CREATE TYPE player_position AS ENUM ('C', 'LW', 'RW', 'D', 'G');
CREATE TABLE player (
    id serial PRIMARY KEY NOT NULL,
    team_id serial REFERENCES team (id) UNIQUE NOT NULL,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    jersey_number integer NOT NULL,
    position player_position,
    weight_lbs real,
    height_ft real,
    birth_date date NOT NULL,
    birth_city VARCHAR(255),
    birth_country VARCHAR(255),
    age integer NOT NULL,
    is_rookie boolean
);
CREATE INDEX player_team_index ON player(team_id);

CREATE TABLE pool (
    id serial PRIMARY KEY NOT NULL,
    name VARCHAR(255),
    creation_date date NOT NULL DEFAULT CURRENT_DATE
);

CREATE TABLE member_pool_player (
    member_id serial REFERENCES member (id) NOT NULL,
    pool_id serial REFERENCES pool (id) NOT NULL,
    player_id serial REFERENCES player (id) NOT NULL,
    CONSTRAINT member_pool_player_pk PRIMARY KEY (member_id, pool_id, player_id)
);
CREATE INDEX member_index ON member_pool_player(member_id);
CREATE INDEX pool_index ON member_pool_player(pool_id);
CREATE INDEX player_index ON member_pool_player(player_id);
