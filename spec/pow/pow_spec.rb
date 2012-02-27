require 'spec_helper'

describe "Parser" do

  context "adding a project" do

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

    it "should print USAGE if no match is found" do
      $stdout.should_receive(:puts).with(Pow::USAGE)
      Pow::Parser.new %w{sds}
    end
  end

end

describe "Add" do
  it "should expand the current path" do
    current_dir = `pwd`.chomp
    Pow::Runner.should_receive(:run).with "ln -s #{current_dir} #{Pow::POW_DIR}"
    Pow::Add.new '.'
  end

  it "should use the specified path and app name" do
    Pow::Runner.should_receive(:run).with "ln -s /a/path #{Pow::POW_DIR}appname"
    Pow::Add.new '/a/path', 'appname'
  end
end

describe "Remove" do
  it "should remove the app" do
    Pow::Runner.should_receive(:run).with "rm #{Pow::POW_DIR}google"
    Pow::Remove.new 'google'
  end
end

describe "Open" do
  it "should open the app in the current directory" do
    appname = `pwd`.chomp.split('/').last
    Pow::Runner.should_receive(:run).with "open http://#{appname}.dev"
    Pow::Open.new
  end

  it "should open the specified path" do
    appname = 'rubyxp'
    Pow::Runner.should_receive(:run).with "open http://#{appname}.dev"
    Pow::Open.new appname
  end
end
