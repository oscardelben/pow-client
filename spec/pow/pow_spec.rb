require 'spec_helper'

describe Pow::Parser do

  context "adding a project" do

    it "should call Pow::Add and pass the arguments" do
      Pow::Add.should_receive(:new).with('.', 'myapp')
      Pow::Parser .new %w{add . myapp}
    end

    it "should call remove and pass the arguments" do
      Pow::Remove.should_receive(:new).with('google')
      Pow::Parser.new %w{remove google}
    end
  end

end

describe Pow::Add do
end

describe Pow::Remove do
end

describe Pow::Open do
end
