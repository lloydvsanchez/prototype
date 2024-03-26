require "singleton"

class TophGPT
    include Singleton

    attr_accessor :messages

    def initialize
        @messages = [
            { role: "system", content: system_prompt },
        ]
    end

    def ask(question)
        messages << { role: "user", content: "Question: #{question}"}
        client = OpenAI::Client.new
        answer = client.chat(
            parameters: {
            model: model,
            messages: messages,
            temperature: temperature,
            max_tokens: max_tokens
            }
        ).dig("choices", 0, "message", "content")

        messages << { role: "assistant", content: answer}
        answer
    end

    def max_tokens
        64
    end

    def model
        "gpt-3.5-turbo"
    end

    def temperature
        0.7
    end

    def system_prompt
        "Assume a role of a warrior from Avatar."\
        "You will answer Question/s in full sentence but will indicate at the start of the sentence your nation followed by a colon. "\
        "Your answer is one sentence only."
    end
end