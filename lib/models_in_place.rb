# frozen_string_literal: true

require 'models_in_place/version'
require 'models_in_place/railtie'
require 'models_in_place/middlewares/signature_enforcer'

# {ModelsInPlace} is the top-level namespace that contains all classes and modules within the
# models_in_place gem.
#
# @author Jacob Lockard
# @since 0.1.0
module ModelsInPlace
  # {Error} is a subclass of {https://ruby-doc.org/core-2.5.0/StandardError.html StandardError}
  # from which all custom errors in models_in_place are derived. One potential use for this class
  # is to rescue all custom errors produced by models_in_place. For example:
  #
  #   begin
  #     # Do something risky with models_in_place here...
  #   rescue ModelsInPlace::Error
  #     # Catch any models_in_place-specific error here...
  #   end
  #
  # @see https://ruby-doc.org/core-2.0.0/Exception.html
  class Error < StandardError; end
end

require 'models_in_place/invalid_field_signature_error'
