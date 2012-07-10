require 'spec_helper'

describe Album do
  it { should validate_presence_of :name }
  it { should validate_presence_of :artist }
  it { should validate_presence_of :cover }

  it { should allow_mass_assignment_of :name }
  it { should allow_mass_assignment_of :artist }
  it { should_not allow_mass_assignment_of :user_id }
end
