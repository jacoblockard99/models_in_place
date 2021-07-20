# frozen_string_literal: true

require 'middlegem'

module ModelsInPlace
  module Middlewares
    # {OptionsInjector} is a middleware class that appends an empty options hash to the end of
    # the input if one is not present. This allows the options hash to be optional if this
    # middleware is defined before {SignatureEnforcer}.
    #
    # Note that this class is not to be confused with {OptionsInsert}, which allows options to be
    # dynamically appended to the hash.
    #
    # @author Jacob Lockard
    # @since 0.1.0
    class OptionsInjector < Middlegem::Middleware
      # Executes the {OptionsInjector} middleware by appending an empty hash to the end of the
      # input unless the last argument is already a hash.
      # @param mode [Symbol] the mode with which the field should be rendered.
      # @param args [Array] the input argument array.
      # @return [Array] the transformed arguments.
      def call(mode, *args)
        args << {} unless args.last.is_a? Hash

        [mode, *args]
      end
    end
  end
end
