# frozen_string_literal: true

require 'middlegem'

module ModelsInPlace
  module Middlewares
    # {SignatureEnforcer} is a middleware class that ensures that the input to a field is
    # acceptable for models_in_place. Arguments to a field should exactly as follows: first the
    # model instance, then the attribute name, then a hash of options. Note that in actual usage
    # of models_in_place, the hash of options is optional. This is because of the
    # {OptionsInjectorMiddleware} that should run before the {SignatureEnforcer}.
    #
    # @author Jacob Lockard
    # @since 0.1.0
    class SignatureEnforcer < Middlegem::Middleware
      # Executes the {SignatureEnforcer} middleware by accepting only the arguments it expects
      # and ensuring that the options argument is a hash.
      # @param mode [Symbol] the mode in which the field should be rendered.
      # @param model [Object] the model instance for which to render the field.
      # @param attribute [String, Symbol] the name of the attribute for which to render the
      #   field.
      # @param options [Hash] the hash of options to the field type.
      # @return [Array] the valid arguments.
      # @raise [InvalidFieldSignatureError] if the field input is invalid.
      def call(mode, model, attribute, options)
        unless options.is_a? Hash
          raise InvalidFieldSignatureError, 'The options argument is not a hash!'
        end

        [mode, model, attribute, options]
      end
    end
  end
end
