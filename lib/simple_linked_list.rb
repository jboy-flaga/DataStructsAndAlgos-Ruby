
require_relative "linked_list_node"

class SimpleLinkedList
  def initialize
    @count = 0
  end

  def first
    if self.is_empty
      raise "first property cannot be called on empty list"
    end

    return @head
  end

  def last
    if self.is_empty
      raise "last property cannot be called on empty list"
    end

    return @tail
  end

  def count
    return @count
  end

  def is_empty
    return @count <= 0
  end

  def add_first(item)
    newNode = LinkedListNode.new
    newNode.item = item
    newNode.link = nil

    if is_empty
      @head = @tail = newNode
    else
      newNode.link = @tail
      @head = newNode
    end

    @count += 1
  end

  def add_last(item)
    newNode = LinkedListNode.new
    newNode.item = item

    if is_empty
      @head = @tail = newNode
    else
      @tail.link = newNode
      @tail = newNode
    end

    @count += 1
  end

  def find(item)
    currentNode = @head;

    while !currentNode.nil?
      break if currentNode.item == item
      currentNode = currentNode.link
    end
    return currentNode
  end

  def remove(item)
    if @head.item == item
      remove_first
      return true
    end

    previous_node = @head
    current_node = @head.link

    until current_node.nil?
      if current_node.item == item
        previous_node.link = current_node.link
        # at this point the node to be deleted (the previous current node) will be ready for garbage collection

        if current_node.equal?(@tail)
          @tail = previous_node
        end

        @count -= 1
        return true
      end

      previous_node = current_node
      current_node = current_node.link
    end

    return false
  end

  def remove_first
    if is_empty then raise 'remove_first method cannot be called on empty list' end

    if @count == 1
      @head = @tail = nil
    else
      @head = @head.link
    end

    @count -= 1
  end

  def remove_last
    if is_empty then raise 'remove_last method cannot be called on empty list' end

    if @count == 1
      @head = @tail = nil
    else
      current_node = @head
      until current_node.nil?
        if current_node.link.link.nil?
          current_node.link = nil
          @tail = current_node
          break
        end

        current_node = current_node.link
      end
    end

    @count -= 1
  end
end