# frozen_string_literal: true

# Advent of Code 2024
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2024/days/lan_party'

class AOC2024::LanPartyTest < Minitest::Test
  INPUT = <<~EOI
    kh-tc
    qp-kh
    de-cg
    ka-co
    yn-aq
    qp-ub
    cg-tb
    vc-aq
    tb-ka
    wh-tc
    yn-cg
    kh-ub
    ta-co
    de-co
    tc-td
    tb-wq
    wh-td
    ta-ka
    td-qp
    aq-cg
    wq-ub
    ub-vc
    de-ta
    wq-aq
    wq-vc
    wh-yn
    ka-de
    kh-ta
    co-tc
    wh-qp
    tb-vc
    td-yn
  EOI

  def setup
    @lp = AOC2024::LanParty.new
  end

  def test_parse_input
    connections = @lp.parse_input(INPUT)

    assert_equal(16, connections.size)
    assert_equal(Set['tc', 'qp', 'ub', 'ta'], connections['kh'])
    assert_equal(Set['yn', 'vc', 'cg', 'wq'], connections['aq'])
  end

  def test_part1
    @lp.setup(INPUT)

    assert_equal(7, @lp.part1)
  end

  def test_part2
    @lp.setup(INPUT)

    assert_equal('co,de,ka,ta', @lp.part2)
  end
end
