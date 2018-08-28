# Nextcloud development environment on macOS

(If you use macOS 10.12 Sierra or earlier, you also need to install dependencies: Get php71 and sqlite via [Homebrew](https://brew.sh/).)

1. **Get the Nextcloud code:** Either using [Github Desktop](https://desktop.github.com/) (or using the Terminal if you prefer that), clone the Nextcloud server repository https://github.com/nextcloud/server

2. **Get Nextcloud submodules:** Using the Terminal, run this command in the nextcloud folder you just cloned: `git submodule update --init`

3. **Start the server:** In the Terminal, run the command: `php -S localhost:8000`

4. **Finish installation:** In your browser, go to http://localhost:8000. You should see the setup screen asking for username and password.

:tada: Now do your changes and use Github Desktop to push them! :)

(Special thanks to @xMartin for his [quick start guide](https://twitter.com/xMartin/status/844117579237068800)!)
