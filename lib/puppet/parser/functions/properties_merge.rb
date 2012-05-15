class Propfile
    class Propfile::Line
        attr_accessor :line
        attr_accessor :key

        def initialize(line)
            self.line = line

            if line.match(/^\s*(?!#)([^ \t=]+)=?/)
                self.key = $1
            end
        end
    end

    attr_accessor :lines
    attr_accessor :keys

    def initialize(properties = "")
        self.lines = []
        self.keys  = {}

        properties.split(/\n/).each do |line|
            add_line Propfile::Line.new(line)
        end
    end

    def add_line(line)
        if line.key
            if keys[line.key] # Seen it before, update
                lines[keys[line.key]] = line
            else
                lines << line
                keys[line.key] = lines.size - 1
            end
        else
            lines << line
        end
    end

    def merge(other)
        other.lines.each do |line|
            add_line line
        end
    end

    def to_s
        self.lines.map { |l| l.line }.join("\n")
    end
end

Puppet::Parser::Functions::newfunction(:properties_merge, :type => :rvalue, :doc => '
Combines a set of properties files, returning the merged file

Attempts to preserve order as far as possible
') do |args|
    properties = Propfile.new
    args.each do |props|
        properties.merge( Propfile.new( props ) )
    end
    properties.to_s
end

