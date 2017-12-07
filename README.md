## To add a new database migration script:

  1. Create a file containing your upgrade script - e.g. new.sql

  2. Add your upgrade script:
      ```
      docker run -v $PWD:/db frrocc/docker-schema-evolution-manager sem-add new.sql
      ```
  
  4. (Optional) Apply your new script localy
      ```
      docker-compose up
      docker exec nhlpoolhelper-db sh /db/apply.sh
      ```

  5. Send a Pull Request! :)

  ## To use a local DB with nhl-pool-apiv2
  1. Add the upgrade script (see steps 1 & 2 of the previous section)
  2. Build an image `sh ./build.sh`
  3. In dc.dev.yml, update the db image to use: frrocc/db:latest
  4. Run nhlpoolhelper-api: `npm run dev`
  4. Run `docker exec  nhlpoolhelper_db /bin/sh /db/apply.sh`

=
  ## To query the database manually
  1. Use psql and enter devpass as password
    ```
    docker exec -it nhlpoolhelper-db psql -U dev -W dev
    ```