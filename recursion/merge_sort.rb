# frozen_string_literal: true

def merge_sort(array)
  return array if array.length <= 1

  mid = array.length / 2
  left = merge_sort(array[0...mid])
  right = merge_sort(array[mid..])

  merge(left, right)
end

def merge(left, right)
  sorted = []

  until left.empty? || right.empty?
    sorted << if left.first <= right.first
                left.shift
              else
                right.shift
              end
  end

  sorted + left + right
end
