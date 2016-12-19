require "minitest/autorun"
require "./lib/rk.rb"

class TestRk < Minitest::Test
  extend Minitest::Spec::DSL

  let(:simple_user_10) { ["user", 10] }

  def setup
    rk.separator = ":"
    rk.prefix = ""
    rk.suffix = ""
  end

  def test_simple_key
    assert_equal "user:10", rk(simple_user_10)
  end

  def test_long_key
    a = [*1..1000]
    s = a.join(":") # "1:2:3:4:5:6:7:8:9:10:11:...:1000"
    assert_equal s, rk(a)
  end

  def test_key_prefix
    rk.prefix = "myapp"
    assert_equal "myapp:user:10", rk(simple_user_10)
  end

  def test_key_suffix
    rk.suffix = "test"
    assert_equal "user:10:test", rk(simple_user_10)
  end

  def test_key_prefix_and_suffix
    rk.prefix = "myapp"
    rk.suffix = "test"
    assert_equal "myapp:user:10:test", rk(simple_user_10)
  end

  def test_change_separator
    rk.separator = "-"
    assert_equal "user-10", rk(simple_user_10)
  end

  def test_use_defined_key_element
    rk.user = "user"
    assert_equal "user:10", rk(rk.user, 10)
  end

  def test_use_undefined_key_element
    assert_raises RuntimeError do
      rk.undefined
    end
  end

end