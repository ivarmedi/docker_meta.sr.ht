# ivarmedi/meta.sr.ht

## Contents

This dockerfile contains [meta.sr.ht](https://meta.sr.ht) and Nginx.

## Usage

Modify the config.ini.example file as needed. Mount the file in at `/etc/sr.ht/config.ini` like so:

```bash
docker run -d --name meta -v /path/to/config.ini:/etc/sr.ht/config.ini -p8001:8001 ivarmedi/meta.sr.ht
```

## More options

### Admin user
You can create an admin user by providing the environment variables `USERNAME` and `EMAIL`. The password will be `password`:

```bash
docker run -it --rm -e USERNAME="ivarmedi" -e EMAIL="email@example.com" -v /etc/sr.ht/config.ini:/etc/sr.ht/config.ini ivarmedi/meta.sr.ht
```

Wait for the app to start, and exit with Ctrl+C.

If you pass the same username on subsequent runs, it will reset the password to `password` (and set the email to whatever you provide).
