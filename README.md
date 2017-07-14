# ErrbitPlugin [![Build Status](https://travis-ci.org/errbit/errbit_plugin.svg?branch=master)](https://travis-ci.org/errbit/errbit_plugin)
ErrbitPlugin provides a set of base classes that you can extend to create
Errbit plugins.

## Creating plugins
ErrbitPlugins are Ruby gems that extend the functionality of Errbit. To get
started, create a Ruby gem and add 'errbit_plugin' as a dependency in your
gem's gemspec.

Now you can start adding plugins. Keep reading to learn about what you can do
with Errbit plugins.

### Issue Trackers
An issue tracker plugin is a Ruby class that enables you to link errors within
errbit to an issue in an external issue tracker like Github. An app within
errbit can be associated an issue tracker or not. When there is an association,
errbit users can choose 'create issue' from an error page which will both
create an issue on the external issue tracker out of the given error and link
that issue to the errbit error. Likewise, a user can also choose 'close issue'
to close the issue on the external issue tracker, if your plugin provides a 
method to do so.

Your issue tracker plugin is responsible for providing the interface defined by
ErrbitPlugin::IssueTracker. All of the required methods must be implemented and
the class must extend ErrbitPlugin::IssueTracker. Here's an example:
```ruby
class MyIssueTracker < ErrbitPlugin::IssueTracker

  # A unique label for your tracker plugin used internally by errbit
  def self.label
    'my-tracker'
  end

  def self.note
    'a note about this tracker that users will see'
  end

  # Form fields that will be presented to the administrator when setting up
  # or editing the errbit app. The values we collect will be availble for use
  # later when we have an instance of this class.
  def self.fields
    {
      username: {
        placeholder: "Some placeholder text"
      },
      password: {
        placeholder: "Some more placeholder text",
        label: "Passphrase" # a label to use in the UI instead of 'password'
      }
    }
  end

  # Icons to display during user interactions with this issue tracker. This
  # method should return a hash of two-tuples, the key names being 'create',
  # 'goto', and 'inactive'. The two-tuples should contain the icon media type
  # and the binary icon data.
  def self.icons
    @icons ||= {
      create: [ 'image/png', File.read('./path/to/create.png') ],
      goto: [ 'image/png', File.read('./path/to/goto.png') ],
      inactive: [ 'image/png', File.read('./path/to/inactive.png') ],
    }
  end

  # If this tracker can be in a configured or non-configured state, you can let
  # errbit know by returning a Boolean here
  def configured?
    # In this case, we'll say this issue tracker is configured when username
    # and password are set
    options[:username].present? && options[:password].present?
  end

  # Called to validate user input. Just return a hash of errors if there are
  # any
  def errors
    if options[:username]
      {}
    else
      { field_one: 'username must be present' }
    end
  end

  # This is where you actually go create the issue on the external issue
  # tracker. You get access to everything in options, an issue title, body and
  # a user record representing the user who's creating the issue.
  #
  # Return a string with a link to the issue
  def create_issue(title, body, user: {})
    # Create an issue! Then update the problem to link it.

    'http://sometracker.com/my/issue/123'
  end

  # This method is optional. Errbit will create body text for your issue by
  # calling render_to_string with some arguments. If you want control over
  # those arguments, you can specify them here. You can control which file is
  # rendered and anything else Rails allows you to specify as arguments in
  # render_to_string.
  #
  # If you don't implement this method, Errbit will render a body using a
  # default template
  #
  # @see http://apidock.com/rails/ActionController/Base/render_to_string
  def render_body_args
    # In this example, we want to render a special file
    ['/path/to/some/template', formats: [:rdoc]]
  end

  # This method is optional, and is where you actually go close the issue on
  # the external issue tracker. You get access to everything in options, a
  # string with a link to the issue # and a user resource.
  #
  # return true if successful, false otherwise
  def close_issue(issue_link, user = {})
    # Close the issue! (Perhaps using the passed in issue_link url to identify it.)
  end

  # The URL for your remote issue tracker
  def url
    'http://some-remote-tracker.com'
  end
end
```

### Notifiers
A Notifier is a Ruby class that can notify an external system when Errbit
receives notices. When configuring an app within the Errbit UI, you can choose
to enable a notifier which will delegate the business of sending notifications
to the selected notifier.

Your notifier plugin is responsible for implementing the interface defined by
ErrbitPlugin::Notifier. All of the required methods must be implemented and the
class must extend ErrbitPlugin::Notifier. Here's an example:
```ruby
class MyNotifier < ErrbitPlugin::Notifier

  # A unique label for your notifier plugin used internally by errbit
  def self.label
    'my-notifier'
  end

  def self.note
    'a note about this notifier that users will see in the UI'
  end

  # Form fields that will be presented to the administrator when setting up
  # or editing the errbit app. The values we collect will be availble for use
  # later when its time to notify.
  def self.fields
    {
      username: {
        placeholder: "Some placeholder text"
      },
      password: {
        placeholder: "Some more placeholder text"
      }
    }
  end

  # Icons to display during user interactions with this notifier. This method
  # should return a hash of two-tuples, the key names being 'create', 'goto',
  # and 'inactive'. The two-tuples should contain the icon media type and the
  # binary icon data.
  def self.icons
    @icons ||= {
      create: [ 'image/png', File.read('./path/to/create.png') ],
      goto: [ 'image/png', File.read('./path/to/goto.png') ],
      inactive: [ 'image/png', File.read('./path/to/inactive.png') ],
    }
  end

  # If this notifier can be in a configured or non-configured state, you can let
  # errbit know by returning a Boolean here
  def configured?
    # In this case, we'll say this notifier is configured when username
    # is set
    !!params['username']
  end

  # Called to validate user input. Just return a hash of errors if there are
  # any
  def errors
    if @params['field_one']
      {}
    else
      { :field_one, 'Field One must be present' }
    end
  end

  # notify is called when Errbit decides its time to notify external systems
  # about a new error notice. notify receives an instance of the notice's problem
  # which you can interrogate for any information you'd like to include in the
  # notification message.
  def notify(problem)
    # Send a notification! Use HTTP, SMTP, FTP, RabbitMQ or whatever you want
    # to notify your external system.
  end

  # The URL for your remote issue tracker
  def url
    'http://some-remote-tracker.com'
  end
end
```

## Contributing

Discuss any changes you'd like to make with the authors on the mailing list, or
by opening a github issue.
