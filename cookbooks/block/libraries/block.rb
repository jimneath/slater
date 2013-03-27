require 'chef/resource'
require 'chef/provider'
require 'chef/mixin/command'
require 'chef/log'
 
class Chef
  class Resource
    class Block < Chef::Resource      
      if Chef::VERSION == '0.6.0.2'
        def initialize(name, collection = nil, node = nil)
          super(name, collection, node)
          init(name)
        end
      else
        def initialize(name, run_context = nil)
          super(name, run_context)
          init(name)
        end
      end
      
      def init(name)        
        @resource_name = :block
        @action = :update
        @allowed_actions.push(:update)
        
        @ips = {}
      end

      def ip(address = nil, options = {})
        valid_option_keys = [:ports]
        invalid_keys = options.keys - valid_option_keys
        
        unless address.present? && address.is_a?(String)
          raise ArgumentError, 'IP Address must be a string, eg: "219.13.1.98"'
        end
        
        unless invalid_keys.empty?
          raise ArgumentError, "The following are invalid options: #{invalid_keys.join(', ')}"
        end
        
        @ips.merge!(address => options)
      end
    end
  end
  
  class Provider
    class Block < Chef::Provider
      include Chef::Mixin::Command
                  
      def load_current_resource
        true
      end
      
      def action_update
        # write rules
        @new_resource.ips.each_pair do |ip, options|
          Chef::Log.info "Blocking #{ip}, ports: #{(options[:ports] || []).join(', ')}"
        end
      end
    end
  end
end

Chef::Platform.platforms[:default].merge!(:block => Chef::Provider::Block)