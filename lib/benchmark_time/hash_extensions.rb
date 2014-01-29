module HashExtensions

  # experiment to make hash arguments into instance variables
  def to_instance_variables(bind, opts={})
    each do |key, val|
      bind.eval("@#{key}=#{val.inspect}")
      # we can build attr_accessor, attr_reader, attr_writers off these options
     # bind.eval "self.class.class_eval 'attr_reader :foo'"if opts[:define]
    end
  end
end

class Hash
  include HashExtensions
end
