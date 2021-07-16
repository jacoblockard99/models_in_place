# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ModelsInPlace::Middlewares::OptionsInjector do
  let(:middleware) { described_class.new }

  describe '#call' do
    context 'with no arguments save the field options' do
      let(:output) { middleware.call({}) }

      it 'appends an empty options hash' do
        expect(output).to eq [{}, {}]
      end
    end

    context 'with a non-Hash last argument' do
      let(:output) { middleware.call({}, 'arg', 'again', {}, 'last') }

      it 'appends an empty options hash' do
        expect(output).to eq [{}, 'arg', 'again', {}, 'last', {}]
      end
    end

    context 'with a Hash last argument' do
      let(:output) { middleware.call({}, 'arg', 'again', { option: true }) }

      it 'changes nothing' do
        expect(output).to eq [{}, 'arg', 'again', { option: true }]
      end
    end
  end
end
