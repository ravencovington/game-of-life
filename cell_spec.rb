describe Cell do
  subject(:cell) { Cell.new(alive_neighbor_count, state) }
  let(:alive_neighbor_count) { 5 }
  let(:state) { "alive" }
  describe "#alive_neighbor_count" do

    it "sets living neighbor count" do
      expect(cell.alive_neighbor_count).to eq(alive_neighbor_count)
    end
  end

  context "cell's current state is alive" do
    let(:state) { "alive" }
    describe "#next_state" do
      subject(:next_state) { cell.next_state }

      context "zero alive neighbors" do
        let(:alive_neighbor_count) { 0 }

        it { is_expected.to eq("dead") }
      end

      context "two live neighbors" do
        let(:alive_neighbor_count) { 2 }

        it { is_expected.to eq("alive") }
      end

      context "three alive neighbors" do
        let(:alive_neighbor_count) { 3 }

        it { is_expected.to eq("alive") }
      end

      context "four alive neighbors" do
        let(:alive_neighbor_count) { 4 }

        it { is_expected.to eq("dead") }
      end
    end
  end

  context "cell's current state is dead" do
    let(:state) { "dead" }
    describe "#next_state" do
      subject(:next_state) { cell.next_state }

      context "zero alive neighbors" do
        let(:alive_neighbor_count) { 0 }

        it { is_expected.to eq("dead") }
      end

      context "two live neighbors" do
        let(:alive_neighbor_count) { 2 }

        it { is_expected.to eq("dead") }
      end

      context "three alive neighbors" do
        let(:alive_neighbor_count) { 3 }

        it { is_expected.to eq("dead") }
      end

      context "four alive neighbors" do
        let(:alive_neighbor_count) { 4 }

        it { is_expected.to eq("alive") }
      end
    end
  end
end
