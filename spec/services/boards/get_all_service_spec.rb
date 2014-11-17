require_relative '../../../app/services/boards'
require_relative '../../../app/services/boards/get_all_service'
require 'leaderboard'

module Boards
  describe GetAllService do
    describe '#execute' do
      subject { described_class.new }

      let(:leaderboard) do
        Boards.default_leaderboard
      end

      let(:entry1) do
        leaderboard.rank_member('Car1', 100)
      end

      let(:entry2) do
        leaderboard.rank_member('Car2', 10)
      end

      let!(:entries) { [entry1, entry2] }

      it 'gets the entries' do
        results =  subject.execute
        expect(results.count).to eq(2)
      end
    end
  end
end
