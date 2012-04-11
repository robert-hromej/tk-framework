module ParseNodeMethods

  def is_root?
    parent.nil?
  end

  def id
    is_root? ? 'root' : value[:attributes]['id']
  end

  def name
    value[:name] = "frame" if value[:name] == 'div'
    value[:name]
  end

  def label_id
    is_root? ? 'application' : value[:attributes]['class']
  end

  def to_tk
    return [] unless [:tag, :root].include? type

    template = Liquid::Template.parse File.read('./lib/templates/getter.liquid')

    if is_root?
      getter = template.render('name' => id, 'type' => 'TkRoot')
    else
      getter = template.render('name' => id, 'type' => name.capitalize, 'parent' => parent.id)
    end

    result = [[id, getter]]

    children.each do |child|
      result += child.to_tk
    end

    result
=begin
    self.ruby_som = Frame.new(root)
    self.btn1 = Button.new(ruby_som)
    self.btn1.width = 243
=end


    #attr = {}
    #
    #attr['file_name'] = label_id
    #attr['class_name'] = label_id.capitalize
    #
    #attr['attrs'] = children.find_all { |child| [:tag, :root].include? child.type }
    #attr['attrs'] = attr['attrs'].map { |a| ":#{a.label_id}" }.join(', ')
    #attr['attrs'] = ", #{attr['attrs']}" unless attr['attrs'] == ''
    #
    #render_and_save attr
    #
    #children.each do |child|
    #  child.to_tk
    #end

    #    p 111
    #    p self.attr_type
    #    p self.attr_name
    #
    #    str = ''
    #
    #    if parent.nil?
    #      str << <<RUBY
    #class Application < TkRoot
    #
    #end
    #RUBY
    #    else
    #
    #      if attr_name
    #        str << "self.#{attr_name} = #{attr_type}.new(#{parent.attr_name}) \n"
    #      else
    #        str << "#{attr_type}.new(#{parent.attr_name}) \n"
    #      end
    #
    #    end
    #
    #    str << "\n" if children.size > 0
    #
    #    children.each do |child|
    #      p 222
    #      p child.class
    #      str << child.to_tk
    #    end
    #
    #    #puts str
    #
    #    str
  end
end

module Haml
  module Parser
    private
    class ParseNode
      include ParseNodeMethods
    end
  end
end