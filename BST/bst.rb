# frozen_string_literal: true

class Node
  include Comparable

  attr_accessor :data, :left, :right

  def initialize(data = nil, left = nil, right = nil)
    @data = data
    @left = left
    @right = right
  end
end

class Tree
  attr_accessor :root

  # ===== Initialization Methods =====
  def initialize(array = [])
    @root = nil
    build_tree(array)
  end

  def build_tree(array)
    return if array.empty?

    # Sort and remove duplicates
    sorted_array = array.uniq.sort

    # Find middle element
    mid = sorted_array.length / 2

    # Create root node
    @root = Node.new(sorted_array[mid])

    # Recursively build left and right subtrees
    @root.left = build_tree(sorted_array[0...mid])
    @root.right = build_tree(sorted_array[mid + 1..])

    @root
  end

  # ===== Core BST Operations =====
  def insert(value, node = @root)
    return Node.new(value) if node.nil?

    if value < node.data
      node.left = insert(value, node.left)
    elsif value > node.data
      node.right = insert(value, node.right)
    end

    node
  end

  def delete(value, node = @root)
    return nil if node.nil?

    if value < node.data
      node.left = delete(value, node.left)
    elsif value > node.data
      node.right = delete(value, node.right)
    else
      node = delete_node(node)
    end

    node
  end

  # ===== Helper Methods =====
  private

  def delete_node(node)
    # Case 1: Node is a leaf - simply delete it
    return nil if node.left.nil? && node.right.nil?

    # Case 2: Node has one child - replace with child
    if node.left.nil?
      return node.right
    elsif node.right.nil?
      return node.left
    end

    # Case 3: Node has two children
    # Find the smallest value in right subtree
    successor = find_min(node.right)

    # Replace current node's value with successor's value
    node.data = successor.data

    # Delete the successor from right subtree
    node.right = delete(successor.data, node.right)

    node
  end

  def find_min(node)
    # Keep going left until we find the smallest value
    node = node.left while node.left
    node
  end
end
