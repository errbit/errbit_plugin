module ErrbitPlugin
  class NoneNotifier < Notifier
    LABEL = 'none'.freeze
    NOTE = 'No notifications'.freeze

    def self.label; LABEL; end
    def self.note; NOTE; end
    def self.fields; {}; end
    def self.icons
      @icons ||= {
        create: ['image/png', read_static_file('none_create.png')],
        goto: ['image/png', read_static_file('none_create.png')],
        inactive: ['image/png', read_static_file('none_inactive.png')],
      }
    end
    def self.read_static_file(file)
      File.read(File.expand_path(File.join(
        File.dirname(__FILE__), '..', '..', '..', 'static', file)))
    end
    def configured?; false; end
    def errors; {}; end
    def url; ''; end
    def notify(*); true; end
  end
end

ErrbitPlugin::Registry.add_notifier(ErrbitPlugin::NoneNotifier)
