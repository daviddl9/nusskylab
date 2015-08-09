class Feedback < ActiveRecord::Base
  validates :team_id, presence: true
  validates :target_team_id, uniqueness: {scope: :team_id,
                                          message: ' cannot submit duplicated feedback'},
            if: :target_type_team?
  validates :adviser_id, uniqueness: {scope: :team_id,
                                      message: ' cannot submit duplicated feedback'},
            if: :target_type_adviser?

  belongs_to :team
  belongs_to :target_team, foreign_key: :target_team_id, class_name: Team
  belongs_to :adviser

  enum target_type: [ :target_type_team, :target_type_adviser ]

  def get_response_for_question(question_id)
    if self.response_content.blank?
      return nil
    else
      return self.response_content[question_id.to_s]
    end
  end
end
