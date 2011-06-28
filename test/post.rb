class Post < ActiveRecord::Base
  include MinistryOfState

  ministry_of_state('status') do
    add_initial_state 'pending'
    add_state :published, :after => :make_public
    add_state :archived, :enter => :make_private

    attr_accessor :public, :private

    add_event(:publish) do
      transitions(:from => :pending, :to => :published)
    end

    add_event(:archive) do
      transitions(:from => [:pending,:published], :to => :archived)
    end
  end

  def make_public
    @public = true
  end

  def make_private
    @private = true
  end
end
