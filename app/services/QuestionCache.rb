require 'singleton'

class QuestionCache
    include Singleton

    attr_reader :question, :question_number
    def initialize
        @question_number = ""
        @question = ""
    end

    def changed?(params)
        question_has_changed = false
        question_number_has_changed = false
        
        if params[:question] != @question
            @question = params[:question]
            question_has_changed = true unless question_has_changed
        end

        if params[:question_number] != @question_number
            @question_number = params[:question_number]
            question_number_has_changed = true unless question_number_has_changed
        end

        question_has_changed && question_number_has_changed
    end
end
