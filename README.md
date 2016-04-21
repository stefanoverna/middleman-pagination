# Middleman Pagination

General-purpose pagination support for Middleman.

Middleman resources, proxy pages, and any arbitrary collection of objects can be paginated.

## Installation

Add this line to your Middleman site's Gemfile:

```ruby
gem 'middleman-pagination'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install middleman-pagination

## Usage

Inside your `config.rb`:

```ruby
activate :pagination do
  pageable_set :recipes, "recipes.html", 20, "page/:num" do |page|
    data.recipes
  end
end
```

**Note:** If you're using the directory indexes extension, place it *after* `activate :directory_indexes`.

Now, let's set up a *pagination index*. Inside `recipes.html`:

```erb
<% pagination.each do |recipe| %>
  - <%= link_to recipe.data.title, recipe.url %>
<% end %>

Page <%= pagination.page_num %> of <%= pagination.total_page_num %>

Showing <%= pagination.per_page %> per page

<%= link_to "First page", pagination.first_page.url %>

<%= link_to "Prev page", pagination.prev_page.url if pagination.prev_page %>

<%= link_to "Next page", pagination.next_page.url if pagination.next_page %>

<%= link_to "Last page", pagination.first_page.url %>
```

## Getting help

Bug? Feature request? You can [open an issue](https://github.com/Aupajo/middleman-pagination/issues), [contact me on Twitter](http://twitter.com/aupajo), or [start a new topic on the Middleman forums](http://forum.middlemanapp.com). All feedback and suggestions welcome.

## TODO

* Custom sorting (e.g. by date)
* Add tests for metadata support
* Convenience helper methods (e.g. make `pagination.` optional)
* Pagination link generator (e.g. `Pages: 1 2 [3] ... 7 8 9`)
* Adopt Middleman's Queryable interface (potentially requires changes to Middleman first)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
