# treegram

this app is eventually gonna text people about tree permits near a given address

## using

you need docker and docker-compose

1. `docker-compose build`
2. `docker-compose up -d`

it shows up on http://localhost:3000

## loading permits

initial import: `docker-compose run sh rake import:initial`

update import: `docker-compose run sh rake import:update`

convert city permits to Permits: `docker-compose run sh rake fixup:permits`

why the latter? Permit objects have a PostGIS location field that can be used
for geospatial queries

## dumping the database

`docker-compose run dump pg_dump -Fc -f /dumps/$(date +%s).pgdump -U postgres -h psql treegram_development`

restoring it is left as an exercise for the reader :P

# contributing

I welcome contributions and pull requests! However, this isn't my job or anything so it may take some time for me to get to them.

Join the #treegram channel on the Code for Miami chat: http://cfm-invite.herokuapp.com

# help

ask bryce!
