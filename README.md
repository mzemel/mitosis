# Mitosis

Mitosis is a Rubygem used to asynchronously publish JSON-encoded error messages to a cental message broker, in this case Disque.

Each queue represents a different service that embeds this gem - one could provide even more information, such as rack/rails environment, server identifier, etc.

I would like to combine this with a subscribing application (not included) that uses ActionCable (from Rails5) and websockets to serve an HTML page where you can watch your messages (errors, audits, etc.) coming in real-time, sorted by application, or create a query of stored messages.

![sketch](http://i.imgur.com/wZTl06z.jpg)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mitosis'
```

And then execute:

    $ bundle


## Example use

```ruby
class PostsController
  def show
    @post = Post.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    Mitosis.log(e, queue = Rails.env)
  end
end
```

Mitosis will publish your error (see below) and re-raise it.

```bash
{"class":"ActiveRecord::RecordNotFound","message":"We could not find a record with that ID!","stacktrace":"/Users/mzemel/Sites/chat/app/controllers/discs_controller.rb:39:in `send_async_error_through_async_log', /Users/mzemel/Sites/chat/app/controllers/discs_controller.rb:27:in `generate_errors', /Users/mzemel/.rbenv/versions/2.1.2/lib/ruby/gems/2.1.0/gems/actionpack-4.2.3/lib/action_controller/metal/implicit_render.rb:4:in `send_action', /Users/mzemel/.rbenv/versions/2.1.2/lib/ruby/gems/2.1.0/gems/actionpack-4.2.3/lib/abstract_controller/base.rb:198:in `process_action', ..."}
```


## Development

After checking out the repo, you can start and stop a test Disque server with `bin/start_test_disque` and `bin/stop_test_disque`, respectively, but you should be free to test it out with:

```ruby
bundle
bundle exec rspec
```

to verify that it can connect to the message broker.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mzemel/mitosis.

