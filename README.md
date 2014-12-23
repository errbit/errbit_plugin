# ErrbitPlugin [![Build Status](https://travis-ci.org/errbit/errbit_plugin.svg?branch=master)](https://travis-ci.org/errbit/errbit_plugin)
ErrbitPlugin provides a set of base classes that you can extend to create
Errbit plugins.

## Creating plugins
ErrbitPlugins are Ruby gems that extend the functionality of Errbit. To get
started, create a Ruby gem and add 'errbit_plugin' as a dependency in your
gem's gemspec.

Now you can start adding plugins. At the moment, there is only one kind of
plugin you can create, and that is the issue tracker.

### Issue Trackers
An issue tracker plugin is a Ruby class that enables you to link errors within
errbit to an issue in an external issue tracker like Github. An app within
errbit can be associated an issue tracker or not. When there is an association,
errbit users can choose 'create issue' from an error page which will both
create an issue on the external issue tracker out of the given error and link
that issue to the errbit error.

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
      :field_one => {:label => 'Field One'},
      :field_two => {:label => 'Field Two'}
    }
  end

  # If this tracker can be in a configured or non-configured state, you can let
  # errbit know by returning a Boolean here
  def configured?
    # In this case, we'll say this issue tracker is configured when field_one
    # is set
    !!params['field_one']
  end

  # Called to validate user input. Just return a hash of errors if there are
  # any
  def check_params
    if @params['field_one']
      {}
    else
      { :field_one, 'Field One must be present' }
    end
  end

  # This is where you actually go create the issue on the external issue
  # tracker. You get access to everything in params, a problem resource and a
  # user resource (reported_by). Once you've created an external issue, save
  # its type and url on the problem resource.
  def create_issue(problem, reported_by = nil)
    # Create an issue! Then update the problem to link it.
    problem.update_attributes(
      :issue_type => 'bug',
      :issue_link => 'http://some-remote-tracker.com/mynewissue'
    )
  end

  # The URL for your remote issue tracker
  def url
    'http://some-remote-tracker.com'
  end

  # If you return false here, errbit will not show the built-in error comment
  # interface
  def comments_allowed?
    false
  end
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
