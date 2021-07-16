# frozen_string_literal: true

require 'middlegem'
require 'deep_merge/rails_compat'

module ModelsInPlace
  module Middlewares
    # {OptionsInsert} is a middleare class that can dynamically append options to a field's
    # options hash. This class is used internally for options scoping, but can also be used
    # directly if desired.
    #
    # This class is not to be confused with {OptionsInjector}, which ensures that an options
    # hash is always present in the field input. Note that {OptionsInsert} should *always* be
    # defined after {OptionInjector} as it relies upon the last argument being a hash.
    #
    # @author Jacob Lockard
    # @since 0.1.0
    class OptionsInsert < Middlegem::Middleware
      # The options to append to the field's options hash.
      # @return [Hash] the options to insert.
      attr_reader :inserted_options

      # Creates a new instance of {OptionsInsert} with the given options to insert.
      # @param inserted_options [Hash] the options to append to the field's option hash.
      def initialize(inserted_options)
        @inserted_options = inserted_options
        super()
      end

      # Executes the {OptionsInsert} middleware by using the {deep_merge
      # https://github.com/danielsdeleo/deep_merge} gem to recursively merge the options in
      # {#inserted_options} with the current options hash.
      # @param field_options [FieldOptions] the {FieldOptions} instance containing the options
      #   and context required to render the field.
      # @param args [Array] the input argments to transform. The final argument *must* be a hash.
      # @return [Array] the transformed arguments.
      def call(field_options, *args)
        merge_options = { extend_existing_arrays: true }
        args[-1] = inserted_options.deep_dup.deeper_merge!(args.last, merge_options)

        [field_options, *args]
      end
    end
  end
end
