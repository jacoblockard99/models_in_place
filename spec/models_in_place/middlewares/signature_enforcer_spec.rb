# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ModelsInPlace::Middlewares::SignatureEnforcer do
  let(:middleware) { described_class.new }

  describe '#call' do
    context 'with too few options' do
      it 'raises an appropriate error' do
        expect { middleware.call({}, 'model', 'attribute') }.to raise_error ArgumentError
      end
    end

    context 'with a non-Hash options hash' do
      let(:options) { 'random invalid options' }

      it 'raises an appropriate error' do
        expected = ModelsInPlace::InvalidFieldSignatureError
        expect { middleware.call({}, 'model', 'attribute', options) }.to raise_error expected
      end
    end

    context 'with valid input' do
      let(:output) { middleware.call('options', 'model', 'attribute', { option: true }) }

      it 'returns it' do
        expect(output).to eq ['options', 'model', 'attribute', { option: true }]
      end
    end
  end
end
