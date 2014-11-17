require_relative '../../../app/services/boards'
require_relative '../../../app/services/boards/get_service'
require 'leaderboard'

module Boards
  describe GetService do
    describe '#execute' do
      subject { described_class.new }

      let!(:leaderboard) do
        Boards.default_leaderboard
      end

      let!(:entry) do
        leaderboard.rank_member('Car1', 100)
      end

      it 'gets the entry' do
        result =  subject.execute(name: 'Car1')
        expect(result[:member]).to eq('Car1')
        expect(result[:score]).to eq(100)
      end

      context 'when the entry does not exist' do
        it 'returns nil' do
          expect(subject.execute(name: 'Not there')).to be_nil
        end
      end
    end
  end
end
