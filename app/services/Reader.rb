require 'singleton'

class Reader
    include Singleton

    attr_reader :tail, :filename, :last_line, :question, :question_number

    def initialize
        puts "Initializing reader....."
        @filename = "C:\\Users\\63939\\Work\\SpeechLogger\\NVDA-speech.log" || "README.md"
        @question_number = ""
        @question = ""
        init_tail
    end

    def init_tail
        @tail = Tail.new(@filename)
        @tail.read
    end

    def filename=(f)
        @filename = f
        init_tail
    end

    def update
        str = tail.read_all

        @last_line = str unless str.blank?
        extract_questions(str)
        { last_line:, question_number:, question: }
    end

    def extract_questions(str)
        (str || "").split("\n").each do |s|
            @question_number = s if s.downcase.include?('question')
            @question = s if %w(why what how when where).any? { |q| s.downcase.include?(q) }
        end
        nil
    end

    def valid_keywords(str)
        %w(question why what how when where).any? { |word| str.include?(word) }
    end

    def restart
        filename=@filename
    end
end