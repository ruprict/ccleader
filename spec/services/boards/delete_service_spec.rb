require_relative '../../../app/services/boards'
require_relative '../../../app/services/boards/delete_service'
require 'leaderboard'

module Boards
  describe DeleteService do
    describe '#execute' do
      subject { described_class.new }

      let!(:leaderboard) do
        Boards.default_leaderboard
      end

      context 'when the entry exists' do
        let!(:entry) do
          leaderboard.rank_member('Car1', 100)
        end

        it 'deletes the entry' do
          expect do
            subject.execute(name: 'Car1')
          end.to change { leaderboard.all_leaders.count }.by(-1)
        end
      end

      context 'when the entry does not exist' do
        it 'returns nil' do
          expect(subject.execute(name: 'Not there')).to be_nil
        end
      end
    end
  end
end
