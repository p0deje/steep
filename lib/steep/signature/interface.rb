module Steep
  module Signature
    class Interface
      attr_reader :name
      attr_reader :params
      attr_reader :methods

      def initialize(name:, params:, methods:)
        @name = name
        @params = params
        @methods = methods
      end

      def ==(other)
        other.is_a?(Interface) && other.name == name && other.params == params && other.methods == methods
      end

      def to_interface(klass:, instance:, params:)
        raise TypeApplicationError if params.size != self.params.size

        map = Hash[self.params.zip(params)]
        Steep::Interface.new(name: name,
                             methods: methods.transform_values {|method|
                               method.map {|method_type|
                                 method_type.substitute(klass: klass, instance: instance, params: map)
                               }
                             }).tap do |interface|
        end
      end
    end
  end
end