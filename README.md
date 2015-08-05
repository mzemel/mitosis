# Mitosis

Mitosis is a Rubygem used to asynchronously publish JSON-encoded error messages to a cental message broker, in this case Disque.

Each queue represents a different service that embeds this gem - one could provide even more information, such as rack/rails environment, server identifier, etc.

I would like to combine this with a front-end JS application that uses websockets to subscribe to the message broker, where each Channel corresponds to a queue.  Thus, you could have an overview of errors coming in real-time by application.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mitosis'
```

And then execute:

    $ bundle


## Example use

```ruby
class GreviousError < StandardError
  def message
    "Record not found!"
  end
end

class PostsController
  def show
    @post = Post.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    Mitosis.log(e, queue = Rails.env)
  end
end
```

Mitosis will publish your error and re-raise it.



## Development

After checking out the repo, you can start and stop a test Disque server with `bin/start_test_disque` and `bin/stop_test_disque`, respectively, but you should be free to test it out with:

```ruby
bundle
bundle exec rspec
```

to verify that it can connect to the message broker.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mzemel/mitosis.

