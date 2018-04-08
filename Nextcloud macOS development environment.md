# Nextcloud development environment on macOS

1. **Install dependencies:** Get php71 and sqlite via [Homebrew](https://brew.sh/). (This step is not necessary on new versions of macOS since it already comes with PHP 7.)

2. **Get the Nextcloud code:** Either using [Github Desktop](https://desktop.github.com/) (or using the Terminal if you prefer that), clone the Nextcloud server repository https://github.com/nextcloud/server

3. **Start the server:** In the Terminal, run the command: `php -S localhost:8000`

4. **Finish installation:** In your browser, go to http://localhost:8000. You should see the setup screen asking for username and password.

:tada: Now do your changes and use Github Desktop to push them! :)

(Special thanks to @xMartin for his [quick start guide](https://twitter.com/xMartin/status/844117579237068800)!)
