require_relative 'board'

describe Board do
  subject(:board) { Board.new(rows, columns, cell_factory: cell_factory, alive_cells: alive_cells) }
  let(:rows) { 6 }
  let(:columns) { 6 }
  let(:cell) { double("cell", alive?: false) }
  let(:cell_factory) { double("cell_factory") }
  let(:expected_cells) do
    [[cell, cell, cell, cell, cell, cell],
    [cell, alive_cell, alive_cell, cell, cell, cell],
    [cell, cell, cell, cell, cell, cell],
    [cell, cell, cell, cell, cell, cell],
    [cell, cell, cell, cell, cell, alive_cell],
    [cell, cell, cell, cell, cell, cell]]
  end
  let(:alive_cells) do
    [[1,1], [1,2], [4,5]]
  end
  let(:alive_cell) { double("alive_cell", alive?: true) }

  before do
    allow(cell_factory).to receive(:new).with(alive:false) {
      cell
    }
    allow(cell_factory).to receive(:new).with(alive:true) {
      alive_cell
    }
  end

  describe "#cells" do

    it "returns a nested array" do
      expect(board.cells).to eq(expected_cells)
    end

    it "returns alive cells" do
      expect(board.alive_cells).to eq(alive_cells)
    end
  end

  describe "#alive_neighbors" do
    subject(:alive_neighbors) { board.alive_neighbors(2,2) }

    it "has two alive alive_neighbors" do
      expect(alive_neighbors.size).to eq(2)
    end
  end

  describe "#next_generation" do
    subject(:next_generation) { board.next_generation }
    let(:rows) { 3 }
    let(:columns) { 3 }
    let(:alive_cells) do
      [[0,1], [1,1], [2,1]]
    end

    let(:expected_board) { Board.new(rows, columns, alive_cells: [[1,0],[1,1], [1,2]]) }

    it { is_expected.to eq(expected_board) }
  end
end
