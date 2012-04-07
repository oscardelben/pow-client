require 'spec_helper'

describe Pow do
  def current_dir
    `pwd`.chomp
  end

  def default_appname
    `pwd`.chomp.split('/').last
  end

  describe Pow::Parser do
    it "should call Pow::Add and pass the arguments" do
      Pow::Add.should_receive(:new).with('.', 'myapp')
      Pow::Parser .new %w{add . myapp}
    end

    it "should call remove and pass the arguments" do
      Pow::Remove.should_receive(:new).with('google')
      Pow::Parser.new %w{remove google}
    end

    it "should call open and pass the arguments" do
      Pow::Open.should_receive(:new).with('basecamp')
      Pow::Parser.new %w{open basecamp}
    end

    it "should call restart" do
      Pow::Restart.should_receive(:new)
      Pow::Parser.new %w{restart}
    end

    it "should print USAGE if no match is found" do
      $stdout.should_receive(:puts).with(Pow::USAGE)
      Pow::Parser.new %w{sds}
    end
  end

  describe Pow::Add do
    it "should expand the current path" do
      Pow::Runner.should_receive(:run).with "ln -s #{current_dir} #{Pow::POW_DIR}"
      Pow::Add.new
    end

    it "should expand the current path" do
      Pow::Runner.should_receive(:run).with "ln -s #{current_dir} #{Pow::POW_DIR}"
      Pow::Add.new '.'
    end

    it "should use the specified path and app name" do
      Pow::Runner.should_receive(:run).with "ln -s /a/path #{Pow::POW_DIR}appname"
      Pow::Add.new '/a/path', 'appname'
    end
  end

  describe Pow::Remove do
    it "should remove the app in the current directory" do
      appname = default_appname
      Pow::Runner.should_receive(:run).with "rm #{Pow::POW_DIR}#{appname}"
      Pow::Remove.new
    end

    it "should remove the app" do
      Pow::Runner.should_receive(:run).with "rm #{Pow::POW_DIR}google"
      Pow::Remove.new 'google'
    end
  end

  describe Pow::Open do
    it "should open the app in the current directory" do
      appname = default_appname
      Pow::Runner.should_receive(:run).with "open http://#{appname}.dev"
      Pow::Open.new
    end

    it "should open the specified path" do
      appname = 'rubyxp'
      Pow::Runner.should_receive(:run).with "open http://#{appname}.dev"
      Pow::Open.new appname
    end
  end

  describe Pow::Restart do
    it "should restart the app" do
      Pow::Runner.should_receive(:run).with "touch tmp/restart.txt"
      Pow::Restart.new
    end
  end
end