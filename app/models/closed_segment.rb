class ClosedSegment < ActiveRecord::Base
  belongs_to :performance
  belongs_to :segment
end
