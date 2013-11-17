require "minitest/autorun"

require_relative "../lib/simple_linked_list"

class SimpleLinkedListTest
  class DefaultConstructor < MiniTest::Unit::TestCase
    def test_sets_length_to_zero
      linked_list = SimpleLinkedList.new

      assert_equal(0, linked_list.count)
    end
  end

  class FirstProperty < MiniTest::Unit::TestCase
    def test_returns_correct_node_in_list_with_multiple_items
      linked_list = SimpleLinkedList.new

      linked_list.add_first('asdf')
      linked_list.add_first 'qwer'
      linked_list.add_first 'zxcv'

      assert_equal 'zxcv', linked_list.first.item
    end

    def test_returns_the_only_node_in_the_list
      linked_list = SimpleLinkedList.new
      linked_list.add_first 'asdf'

      assert_equal 'asdf', linked_list.first.item
    end

    def test_throws_runtime_error_if_list_is_empty
      linked_list = SimpleLinkedList.new

      assert_raises RuntimeError do
        linked_list.first
      end
    end
  end

  class LastProperty < MiniTest::Unit::TestCase
    def test_returns_correct_node_in_list_with_multiple_items
      linked_list = SimpleLinkedList.new

      linked_list.add_first 'asdf'
      linked_list.add_first 'qwer'
      linked_list.add_first 'zxcv'

      assert_equal 'asdf', linked_list.last.item
    end

    def test_returns_the_only_node_in_the_list
      linked_list = SimpleLinkedList.new
      linked_list.add_first 'asdf'

      assert_equal 'asdf', linked_list.last.item
    end

    def test_throws_runtime_error_if_list_is_empty
      linked_list = SimpleLinkedList.new

      assert_raises RuntimeError do
        linked_list.last
      end
    end
  end

  class CountProperty < MiniTest::Unit::TestCase
    def test_returns_accurate_count
      linked_list = SimpleLinkedList.new
      expected_count = 0

      linked_list.add_first 'asdf'; expected_count += 1
      linked_list.add_first 'qwer'; expected_count += 1
      linked_list.add_first 'zxcv'; expected_count += 1

      assert_equal expected_count, linked_list.count
    end
  end

  class IsEmptyProperty < MiniTest::Unit::TestCase
    def test_returns_true_if_list_is_empty
      linked_list = SimpleLinkedList.new

      assert_equal(true, linked_list.is_empty)
    end

    def test_returns_false_if_list_is_not_empty
      linked_list = SimpleLinkedList.new
      linked_list.add_first("asdf");

      assert_equal(false, linked_list.is_empty)
    end
  end

  class AddFirstMethod < MiniTest::Unit::TestCase
    def test_adds_new_item_to_the_head_of_the_list
      linked_list = SimpleLinkedList.new

      linked_list.add_first('new item 1')

      assert_equal('new item 1', linked_list.first.item)
    end

    def test_sets_the_LinkProperty_of_the_current_head_to_the_previous_head_of_the_list
      linked_list = SimpleLinkedList.new

      linked_list.add_first('new item 1')
      linked_list.add_first('new item 2')

      assert_equal('new item 1', linked_list.first.link.item)
    end

    def test_increments_length_of_list
      linked_list = SimpleLinkedList.new
      expected_count = 0

      linked_list.add_first('asdf'); expected_count += 1

      assert_equal(expected_count, linked_list.count)
    end
  end

  class AddLastMethod < MiniTest::Unit::TestCase
    def test_adds_new_item_at_the_tail_of_the_list
      linked_list = SimpleLinkedList.new

      linked_list.add_last('new item 1')
      linked_list.add_last('new item 2')

      assert_equal('new item 2', linked_list.last.item)
    end

    def test_sets_the_LinkProperty_or_the_previous_tail_to_the_current_tail_of_the_list
      linked_list = SimpleLinkedList.new

      linked_list.add_last('new item 1')
      previous_tail = linked_list.last

      linked_list.add_last('new item 2')
      current_tail = linked_list.last

      assert_same(current_tail, previous_tail.link)
      assert_equal('new item 2', previous_tail.link.item)
    end

    def test_increments_length_of_list
      linked_list = SimpleLinkedList.new

      linked_list.add_first('asdf')

      assert_equal(1, linked_list.count)
    end
  end

  class FindMethod < MiniTest::Unit::TestCase
    def test_returns_correct_node
      linked_list = SimpleLinkedList.new
      linked_list.add_first('asdf')
      linked_list.add_first('qwer')

      node = linked_list.find('asdf')

      refute_nil(node)
      assert_equal('asdf', node.item)
    end

    def test_returns_nil_if_item_is_not_found
      linked_list = SimpleLinkedList.new
      linked_list.add_first('asdf')
      linked_list.add_first('qwer')

      node = linked_list.find('zzzzzz')

      assert_nil(node)
    end
  end

  class RemoveMethod <  MiniTest::Unit::TestCase
    def test_removes_correct_item_from_list_with_multiple_items
      linked_list = SimpleLinkedList.new
      linked_list.add_first('asdf')
      linked_list.add_first('middle')
      linked_list.add_first('qwer')

      linked_list.remove('middle')

      assert_nil(linked_list.find('middle'))
    end

    def test_removes_the_only_item_from_list
      linked_list = SimpleLinkedList.new
      linked_list.add_first('asdf')

      linked_list.remove('asdf')

      assert_nil(linked_list.find('asdf'))
    end

    def test_sets_the_FirstProperty_to_the_second_node_if_the_item_to_be_removed_is_the_head_of_the_list
      linked_list = SimpleLinkedList.new
      linked_list.add_first('new item 1')
      linked_list.add_first('new item 2')

      linked_list.remove('new item 2')

      assert_equal('new item 1', linked_list.first.item)
    end

    def test_sets_the_LastProperty_to_the_second_to_last_node_if_the_item_to_be_removed_is_the_tail_of_the_list
      linked_list = SimpleLinkedList.new
      linked_list.add_last('new item 1')
      linked_list.add_last('new item 2')

      linked_list.remove('new item 2')

      assert_equal('new item 1', linked_list.last.item)
    end

    def test_sets_the_LinkProperty_of_LastProperty_to_nil
      linked_list = SimpleLinkedList.new
      linked_list.add_last('new item 1')
      linked_list.add_last('new item 2')

      linked_list.remove('new item 2')

      assert_nil(linked_list.last.link)
    end

    def test_sets_the_FirstProperty_to_nil_if_the_item_to_be_removed_is_the_only_item_in_the_list
      linked_list = SimpleLinkedList.new
      linked_list.add_first('new item 1')

      linked_list.remove('new item 1')

      assert_raises(RuntimeError) do
        node = linked_list.first
      end
    end

    def test_sets_the_LastProperty_to_nil_if_the_item_to_be_removed_is_the_only_item_in_the_list
      linked_list = SimpleLinkedList.new
      linked_list.add_first('new item 1')

      linked_list.remove('new item 1')

      assert_raises(RuntimeError) do
        node = linked_list.last
      end
    end

    def test_decrements_length_of_list
      linked_list = SimpleLinkedList.new
      expected_count = 0
      linked_list.add_first('asdf'); expected_count += 1
      linked_list.add_first('qwer'); expected_count += 1
      linked_list.add_first('zxcv'); expected_count += 1

      linked_list.remove_first; expected_count -= 1

      assert_equal(expected_count, linked_list.count)
    end

    def test_returns_false_if_item_to_be_removed_is_not_found
      linked_list = SimpleLinkedList.new
      linked_list.add_last('asdf')
      linked_list.add_last('qwer')

      result = linked_list.remove('zzzzzzzzz')

      assert_equal(false, result)
    end

    def test_returns_true_if_item_to_be_removed_is_found
      linked_list = SimpleLinkedList.new
      linked_list.add_last('asdf')
      linked_list.add_last('qwer')

      result = linked_list.remove('asdf')

      assert_equal(true, result)
    end
  end

  class RemoveFirstMethod < MiniTest::Unit::TestCase
    def test_removes_the_first_item_in_the_list
      linked_list = SimpleLinkedList.new
      linked_list.add_first('asdf')
      linked_list.add_first('qwer')

      linked_list.remove_first

      refute_equal('qwer', linked_list.first.item)
    end

    def test_removes_the_only_item_from_the_list
      linked_list = SimpleLinkedList.new
      linked_list.add_first('asdf')

      linked_list.remove_first

      assert_nil(linked_list.find('asdf'))
    end

    def test_sets_the_FirstProperty_to_the_second_node_if_the_item_to_be_removed_is_the_head_of_the_list
      linked_list = SimpleLinkedList.new
      linked_list.add_first('new item 1')
      linked_list.add_first('new item 2')

      linked_list.remove_first

      assert_equal('new item 1', linked_list.first.item)
    end

    def test_sets_the_FirstProperty_to_nil_if_the_item_to_be_removed_is_the_only_item_in_the_list
      linked_list = SimpleLinkedList.new
      linked_list.add_first('new item 1')

      linked_list.remove_first

      assert_raises(RuntimeError) do
        node = linked_list.first
      end
    end

    def test_sets_the_LastProperty_to_nil_if_the_item_to_be_removed_is_the_only_item_in_the_list
      linked_list = SimpleLinkedList.new
      linked_list.add_first('new item 1')

      linked_list.remove_first

      assert_raises(RuntimeError) do
        node = linked_list.last
      end
    end

    def test_decrements_length_of_list
      linked_list = SimpleLinkedList.new
      expected_count = 0
      linked_list.add_first('asdf'); expected_count += 1
      linked_list.add_first('qwer'); expected_count += 1

      linked_list.remove_first; expected_count -= 1

      assert_equal(expected_count, linked_list.count)
    end
  end

  class RemoveLastMethod < MiniTest::Unit::TestCase
    def test_removes_the_last_item_in_the_list
      linked_list = SimpleLinkedList.new
      linked_list.add_last('asdf')
      linked_list.add_last('qwer')

      linked_list.remove_last

      refute_equal('qwer', linked_list.last.item)
    end

    def test_removes_the_only_item_in_the_list
      linked_list = SimpleLinkedList.new
      linked_list.add_last('asdf')

      linked_list.remove_last

      assert_nil(linked_list.find('asdf'))
    end

    def test_sets_the_LastProperty_to_the_second_to_last_node_if_the_item_to_be_removed_is_the_tail_of_the_list
      linked_list = SimpleLinkedList.new
      linked_list.add_last('new item 1')
      linked_list.add_last('new item 2')

      linked_list.remove_last

      assert_equal('new item 1', linked_list.last.item)
    end

    def test_sets_the_FirstProperty_to_nil_if_the_item_to_be_removed_is_the_only_item_in_the_list
      linked_list = SimpleLinkedList.new
      linked_list.add_first('new item 1')

      linked_list.remove_last

      assert_raises(RuntimeError) do
        node = linked_list.first
      end
    end

    def test_sets_the_LastProperty_to_nil_if_the_item_to_be_removed_is_the_only_item_in_the_list
      linked_list = SimpleLinkedList.new
      linked_list.add_first('new item 1')

      linked_list.remove_last

      assert_raises(RuntimeError) do
        node = linked_list.last
      end
    end

    def test_decrements_length_of_list
      linked_list = SimpleLinkedList.new
      expected_count = 0
      linked_list.add_first('asdf'); expected_count += 1
      linked_list.add_first('qwer'); expected_count += 1

      linked_list.remove_first; expected_count -= 1

      assert_equal(expected_count, linked_list.count)
    end
  end
end

