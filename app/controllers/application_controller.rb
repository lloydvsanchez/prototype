class ApplicationController < ActionController::API
    #Reader.instance.filename = "C:\\Users\\63939\\Work\\SpeechLogger\\NVDA-speech.log"

    def answer
        q_details = Reader.instance.update
        answer = if QuestionCache.instance.changed? q_details
            # ask gpt here
            TophGPT.instance.ask q_details[:question]
        else
            ""
        end

        render json: { keys: answer.chars }, status: :ok
        #render json: { keys: (gpt_answer || "").chars }, status: :ok
    end
end
