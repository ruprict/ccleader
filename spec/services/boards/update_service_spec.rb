require_relative '../../../app/services/boards'
require_relative '../../../app/services/boards/update_service'
require 'leaderboard'

module Boards
  describe UpdateService do
    describe '#execute' do
      subject { described_class.new }

      context 'when the entry does not exist' do
        let!(:leaderboard) do
          Leaderboard.new(Boards::DEFAULT_BOARD,
                          Leaderboard::DEFAULT_OPTIONS,
                          redis_connection: Redis.current)
        end

        it 'creates the entry' do
          expect do
            subject.execute(name: 'Car 1', score: 10)
          end.to change { leaderboard.all_leaders.count }.by(1)
        end

        it 'returns the page' do
          result = subject.execute(name: 'Car 1', score: 10)
          expect(result[:page]).to eq(1)
        end
      end
    end
  end
end
