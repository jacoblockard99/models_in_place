require 'middlegem'

module ModelsInPlace
  module Middlewares
    # {OptionsInjector} is a middleware class that appends an empty options hash to the end of
    # the input if one is not present. This allows the options hash to be optional if this
    # middleware is defined before {SignatureEnforcer}.
    #
    # @author Jacob Lockard
    # @since 0.1.0
    class OptionsInjector < Middlegem::Middleware
      # Executes the {OptionsInjector} middleware by appending an empty hash to the end of the
      # input unless the last argument is already a hash.
      # @param field_options [FieldOptions] the {FieldOptions} instance containing the options
      #   and context required to render the field.
      # @param args [Array] the input argument array.
      # @return [Array] the transformed arguments.
      def call(field_options, *args)
        args << {} unless args.last.is_a? Hash

        [field_options, *args]
      end
    end
  end
end
