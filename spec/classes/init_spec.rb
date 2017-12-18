require 'spec_helper'
describe 'osconfig_password_mgmt' do

  context 'with defaults for all parameters' do
    it { should contain_class('osconfig_password_mgmt') }
  end
end
