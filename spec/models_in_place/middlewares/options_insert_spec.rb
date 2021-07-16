# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ModelsInPlace::Middlewares::OptionsInsert do
  describe '#call' do
    let(:original_options) { { one: 'one' } }
    let(:new_options) { { two: 'two' } }
    let(:middleware) { described_class.new(new_options) }
    let(:output_args) { middleware.call('field options', 'random arg', original_options) }
    let(:output) { output_args.last }

    context 'with unique options' do
      let(:original_options) { { first_option: false } }
      let(:new_options) { { an_option: true } }

      it 'merges correctly' do
        expect(output).to eq({ an_option: true, first_option: false })
      end
    end

    context 'with conflicting, non-mergeable options' do
      let(:original_options) { { option: false } }
      let(:new_options) { { option: true } }

      it 'gives precedence to the existing options' do
        expect(output).to eq({ option: false })
      end
    end

    context 'with mergeable arrays in the options hashes' do
      let(:original_options) { { array: %i[one two three] } }
      let(:new_options) { { array: %i[four five six] } }

      it 'merges them' do
        expect(output).to eq({ array: %i[four five six one two three] })
      end
    end

    context 'with duplicate entries in arrays in the options hashes' do
      let(:original_options) { { array: %i[one two three] } }
      let(:new_options) { { array: %i[two three four] } }

      it 'removes duplicates' do
        expect(output).to eq({ array: %i[two three four one] })
      end
    end

    context 'with mergeable hashes in the options hashes' do
      let(:original_options) { { hash: { one: 'one', two: 'two' } } }
      let(:new_options) { { hash: { three: 'three', four: 'four' } } }

      it 'merges them' do
        expect(output).to eq({ hash: { three: 'three', four: 'four', one: 'one', two: 'two' } })
      end
    end

    context 'with conflicting hashes in the options hashes' do
      let(:original_options) { { hash: { option: true } } }
      let(:new_options) { { hash: { option: false } } }

      it 'gives precedence to the existing options' do
        expect(output).to eq({ hash: { option: true } })
      end
    end

    it 'does not change the inserted options' do
      output
      expect(middleware.inserted_options).to eq({ two: 'two' })
    end
  end
end
