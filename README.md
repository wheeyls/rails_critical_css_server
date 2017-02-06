# RailsCriticalCssServer
## Eliminate render-blocking CSS in above-the-fold content in your Rails app
If you've run [Google Pagespeed Insights](https://developers.google.com/speed/pagespeed/insights/) on your web app, you might have seen this message:

> *Eliminate render-blocking JavaScript and CSS in above-the-fold content*
>
> Your page has blocking CSS resources. This causes a delay in rendering your page.
> None of the above-the-fold content on your page could be rendered without waiting for the following resources to load. Try to defer or asynchronously load blocking resources, or inline the critical portions of those resources directly in the HTML.

This is a Ruby on Rails client for [Critical CSS Server](https://github.com/wheeyls/critical-css-server), designed to solve this problem for you outside of your build process.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'rails_critical_css_server'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install rails_critical_css_server
```

## Usage

In your application layout, just wrap your CSS in a call to `Rewrite`:

    <%= RailsCriticalCssServer::Rewrite.call self do %>
      <%= stylesheet_link_tag "application" %>
    <% end %>

Every time a new controller action is rendered, the server will begin to compile the bare-minimum CSS required to
render the above the fold content on that page. Eventually, once the CSS is available, the critical portion will
be injected, and the remainder of your CSS will be lazy-loaded with JavaScript.

#### Before CSS is ready:

The header will be rendered normally:

    <link rel="stylesheet" href="/assets/application.css" />

#### After CSS is compiled:

    <style>/* inline css rules injected here... */</style>
    <script>// loadCSS injected here...</script>
    <script>loadCSS("/assets/application.css");</script>
    <noscript>
      <link rel="stylesheet" href="/assets/application.css" />
    </noscript>

#### Busting the Cache

Each time CSS is compile, it is cached using the cache key: `[controller, action, version]`.

By default, we used Heroku's environment variable `HEROKU_RELEASE_VERSION` to bust the version cache. This is available
through the [Heroku Labs: Dyno Metadata](https://devcenter.heroku.com/articles/dyno-metadata).

If this doesn't work for you, set the `version` flag in config to some other deploy-unique id, so that new CSS can be
generated for you each time you change your pages.

## Configuration Options

In `config/initializers/critical_css_server.rb`:

    RailsCriticalCssServer.config do |c|
      c.host = ENV['CRITICAL_CSS_SERVER_URL'] # URL of Critical CSS Server
      c.auth_token = ENV['CRITICAL_CSS_SERVER_AUTH_TOKEN'] # Credentials for Critical CSS Server
      c.timeout = 0.05 # Timeout when requested critical CSS in layout.
      c.version = ENV['HEROKU_RELEASE_VERSION'] # Unique id for the current deploy. Used to bust the cache after changes are made
      c.width = 900 # width of viewport to optimize CSS for
      c.height = 1200 # height of viewport to optimize CSS for
      c.force_selectors = [] # force individual selectors to be included, even if they are not rendered on the first pass. Useful for JavaScript-enabled styles.
    end

## Under the hood:

* [CriticalCSS](https://github.com/filamentgroup/criticalCSS) - used to generate CSS rules
* [loadCSS](https://github.com/filamentgroup/loadCSS) - defer loading of remainder of CSS

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
