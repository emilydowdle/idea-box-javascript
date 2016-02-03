class Idea < ActiveRecord::Base
  enum quality: %w(swill plausible genius)

  def cap_quality
    quality.capitalize
  end

  def record_found(record)
    if record.nil?
      "Cannot be displayed"
    else
      record
    end
  end

  # def assess_quality(data)
  #   if data[:direction] == "Increase"
  #     increase_quality
  #   else
  #     decrease_quality
  #   end
  # end
  #
  # def increase_quality
  #   if swill?
  #     update(quality: 1)
  #   else
  #     update(quality: 2)
  #   end
  # end
  #
  # def decrease_quality
  #   if genius?
  #     update(quality: 1)
  #   else
  #     update(quality: 0)
  #   end
  # end
end
