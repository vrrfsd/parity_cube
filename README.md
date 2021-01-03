In home page recent 25 images are displayed with owner details
# ClearFit

`clearfit_web_app` (`cfwa`) is the Rails app running at
[https://app.smoothhiring.com/][app1].


## Application Setup

There are several more steps before the specs and cucumber features will run
clean.

### The Easy Way:

1.  Run the following commands:

    ```sh
    script/dev_init.sh
    sed "s/clearfit\$/$(whoami)/" \
      < config/database.yml.example | \
      > config/database.yml
    rake config:decrypt
    rake db:create db:setup db:data:load
    rake verify
    ```

Note: Before running `rake:config` the GNU PGP keys need to be configured by install clearfit-pubring.gpg and clearfit-secring.gpg to ~/.gnugpg with chmod 0600.

### The Hard Way:

1.  We're using CarrierWave for applicant image uploads and employer logo
    uploads, which is using `mini_magick`, which requires `ImageMagick`:

    ```sh
    brew install ImageMagick
    ```

1.  Our javascript unit tests make use of the jasmine testing framework. We're
    using [Karma][karma] to run jasmine specs from the command line powered
    by [PhantomJS][phantomjs]:

    ```sh
    brew install phantomjs
    ```

1.  To set up Karma:

    Install Node:

    ```sh
    brew install node
    ```

    Install Karma:

    ```sh
    rake karma:install
    ```

    To run Karma in a watcher loop, run:

    ```sh
    rake karma:local
    rake karma:pow # If using pow.cx
    ```

1.  Because the app was converted from an existing .NET app with database in 2008,
    you can't just `rake db:migrate` to build the database. First, make sure
    you have a usable `database.yml`:

    ```sh
    sed "s/clearfit\$/$(whoami)/" \
      < config/database.yml.example | \
      > config/database.yml
    ```

    Then, create an empty database, initialize it with a schema, and seed it
    with data:

    ```sh
    rake db:create db:setup db:data:load
    ```

After that, the specs should run green. If they don't, let us know so we can
emend the README.

Useful testing rake tasts:

```sh
rake verify # runs specs:all

rake specs:all # runs specs:fast, specs:slow, and spec:javascript
rake specs:fast # runs non-integration specs
rake specs:slow # runs integration specs
rake karma # runs jasmine unit tests
```

## Running Foreman in dev mode

```foreman start -f Procfile.dev```
